class PrimaryHeatingTypeController < FieldController
  def initialize()
    # cannot select microcogen from SAP tables
    #second system cannot be community heating
    #_heatOptions.SetAvailability(HEATING_TYPE.ROOM_HEATERS, false);
    # if DHW these SAP systems cannot heat water system
    @_fieldTitle = StringEnum.GetEnumTitle()
    @_primarySystemType1 = "\\PrimaryHeating1\\" + StringEnum.GetEnumTitle()
    @_sedbukIndex1 = "\\PrimaryHeating1\\SedbukBoilerIndex"
    @_primarySystemType2 = "\\PrimaryHeating2\\" + StringEnum.GetEnumTitle()
    @_sedbukIndex2 = "\\PrimaryHeating2\\SedbukBoilerIndex"
    @_heatOptions = ContainedEnum.Create()
    @_numSystemsTitle = StringEnum.GetEnumTitle()
    @_heatingType1 = "\\PrimaryHeating1\\" + StringEnum.GetEnumTitle()
    @_notRequired = NotRequiredDataRule.Instance
  end

  def DoControl()
    numberOfSystems = _connectedFields[@_numSystemsTitle].AsInt
    if self.@FullName.Contains("\\PrimaryHeating1\\") then
      system = _connectedFields[@_primarySystemType1].AsInt
      sedbukIndex = _connectedFields[@_sedbukIndex1].Value
      self.SetRule(1, system, sedbukIndex, numberOfSystems)
    elsif self.@FullName.Contains("\\PrimaryHeating2\\") then
      system = _connectedFields[@_primarySystemType2].AsInt
      sedbukIndex = _connectedFields[@_sedbukIndex2].Value
      self.SetRule(2, system, sedbukIndex, numberOfSystems)
    end
  end

  def SetRule(systemIndex, system, sedbukIndex, numberOfSystems)
    if system.HasValue then
      case system
        when PRIMARY_SYSTEM_TYPE.PST_NONE
          @_heatOptions.SetAvailability(@_heatOptions.All, false)
          @_heatOptions.SetAvailability(HEATING_TYPE.NONE, true)
          _ruleManager.SetRule(DiscreteDataRule[HEATING_TYPE].new(@_heatOptions))
        when PRIMARY_SYSTEM_TYPE.PST_SAP
          @_heatOptions.SetAvailability(@_heatOptions.All, true)
          @_heatOptions.SetAvailability(HEATING_TYPE.MICRO_COGENERATION, false)
          if (systemIndex == 2) and (numberOfSystems.HasValue and numberOfSystems == NUMBER_PRIMARY_SYSTEMS.NMS_TWO) then
            @_heatOptions.SetAvailability(HEATING_TYPE.COMMUNITY_HEATING, false)
          end
          if (systemIndex == 2) and (numberOfSystems.HasValue) and (numberOfSystems == NUMBER_PRIMARY_SYSTEMS.NMS_ONE_DHW) then
            @_heatOptions.SetAvailability(HEATING_TYPE.COMMUNITY_HEATING, false)
            @_heatOptions.SetAvailability(HEATING_TYPE.ELECTRIC_STORAGE, false)
            @_heatOptions.SetAvailability(HEATING_TYPE.ELECTRIC_UNDERFLOOR, false)
            @_heatOptions.SetAvailability(HEATING_TYPE.OTHER_HEATING, false)
          end
          if systemIndex == 2 and _connectedFields.ContainsKey(@_heatingType1) then
            mainType1 = _connectedFields[@_heatingType1].AsInt
            if mainType1.HasValue and mainType1 == HEATING_TYPE.ROOM_HEATERS then
              @_heatOptions.SetAvailability(HEATING_TYPE.ROOM_HEATERS, true)
            end
          end
          @_heatOptions.SetAvailability(HEATING_TYPE.NONE, false)
          _ruleManager.SetRule(DiscreteDataRule[HEATING_TYPE].new(@_heatOptions))
        when PRIMARY_SYSTEM_TYPE.PST_SEDBUK
          if System::String.IsNullOrEmpty(sedbukIndex) then
            _ruleManager.SetRule(NotRequiredDataRule.Instance)
          else
            boiler = SedbukAccess.GetBoilerByIndex(sedbukIndex)
            if boiler != nil then
              self.SetTypeFromBoiler(boiler)
            end
          end
      end
    else
      @_heatOptions.SetAvailability(@_heatOptions.All, true)
      if systemIndex == 2 then
        @_heatOptions.SetAvailability(HEATING_TYPE.COMMUNITY_HEATING, false)
      end
      _ruleManager.SetRule(DiscreteDataRule[HEATING_TYPE].new(@_heatOptions))
    end
  end

  def SetTypeFromBoiler(boiler)
    if (boiler) or (boiler) then
      @_heatOptions.SetAvailability(@_heatOptions.All, false)
      @_heatOptions.SetAvailability(HEATING_TYPE.CENTRAL_HEATING, true)
      _ruleManager.SetRule(DiscreteDataRule[HEATING_TYPE].new(@_heatOptions))
    elsif boiler then
      heatPump = boiler
      if (heatPump.F13_emitter_type == "1") or (heatPump.F13_emitter_type == "3") or (heatPump.F13_emitter_type == "2") or (heatPump.F13_emitter_type == "") then
        @_heatOptions.SetAvailability(@_heatOptions.All, false)
        @_heatOptions.SetAvailability(HEATING_TYPE.HEAT_PUMPS, true)
        _ruleManager.SetRule(DiscreteDataRule[HEATING_TYPE].new(@_heatOptions))
      elsif heatPump.F13_emitter_type == "4" then
        @_heatOptions.SetAvailability(@_heatOptions.All, false)
        @_heatOptions.SetAvailability(HEATING_TYPE.WARM_AIR_HEAT_PUMP, true)
        _ruleManager.SetRule(DiscreteDataRule[HEATING_TYPE].new(@_heatOptions))
      end
    elsif boiler then
      @_heatOptions.SetAvailability(@_heatOptions.All, false)
      @_heatOptions.SetAvailability(HEATING_TYPE.MICRO_COGENERATION, true)
      _ruleManager.SetRule(DiscreteDataRule[HEATING_TYPE].new(@_heatOptions))
    end
  end
end
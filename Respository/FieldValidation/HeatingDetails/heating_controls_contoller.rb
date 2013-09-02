class HeatingControlsController < FieldController
  def initialize()
    #this field is not required for 2nd system if its DHW only #never an option
    @_fieldTitle = StringEnum.GetEnumTitle()
    @_primaryHeatingTypeTitle1 = "\\PrimaryHeating1\\" + StringEnum.GetEnumTitle()
    @_heatingSystemTitle1 = "\\PrimaryHeating1\\" + StringEnum.GetEnumTitle()
    @_primaryHeatingTypeTitle2 = "\\PrimaryHeating2\\" + StringEnum.GetEnumTitle()
    @_heatingSystemTitle2 = "\\PrimaryHeating2\\" + StringEnum.GetEnumTitle()
    @_numOfSystemsTitle = StringEnum.GetEnumTitle()
    @_notRequireRule = NotRequiredDataRule.Instance
  end

  def DoControl()
    if self.@FullName.Contains("PrimaryHeating1") then
      self.CheckControls(@_primaryHeatingTypeTitle1, @_heatingSystemTitle1)
    elsif self.@FullName.Contains("PrimaryHeating2") then
      numberOfSystems = _connectedFields[@_numOfSystemsTitle].AsInt
      if (numberOfSystems.HasValue) and (numberOfSystems == NUMBER_PRIMARY_SYSTEMS.NMS_ONE_DHW) then
        self.Clear()
        _ruleManager.SetRule(NotRequiredDataRule.Instance)
        return
      end
      self.CheckControls(@_primaryHeatingTypeTitle2, @_heatingSystemTitle2)
    end
  end

  def CheckControls(primaryHeatingTypeTitle, heatingSystemTitle)
    HeatingType = _connectedFields[primaryHeatingTypeTitle].AsInt
    HeatingSystem = _connectedFields[heatingSystemTitle].AsInt
    if HeatingSystem.HasValue then
      controls = ContainedEnum.Create()
      controls.SetAvailability(HEATING_CONTROLS.HC_DHW_HEATING_SYSTEM, false)
      if HeatingSystem == PRIMARY_SYSTEM_TYPE.PST_SAP or HeatingSystem == PRIMARY_SYSTEM_TYPE.PST_SEDBUK then
        if HeatingType.HasValue then
          case HeatingType
            when HEATING_TYPE.MICRO_COGENERATION, HEATING_TYPE.CENTRAL_HEATING
              controls.SetAvailability(List[HEATING_CONTROLS].new(HEATING_CONTROLS.HC1_NONE, HEATING_CONTROLS.HC1_PROGRAMMER_ONLY, HEATING_CONTROLS.HC1_ROOMSTAT_ONLY, HEATING_CONTROLS.HC1_PROGRAMMER_ROOMSTAT, HEATING_CONTROLS.HC1_PROGRAMMER_MULTI_ROOMSTATS, HEATING_CONTROLS.HC1_PROGRAMMER_ROOMSTAT_TRVS, HEATING_CONTROLS.HC1_PROGRAMMER_TRVS_BYPASS, HEATING_CONTROLS.HC1_PROGRAMMER_TRVS_BEM, HEATING_CONTROLS.HC1_FULL_ZONE_CONTROL, HEATING_CONTROLS.HC1_TRVS_BYPASS), true, false)
            when HEATING_TYPE.HEAT_PUMPS
              controls.SetAvailability(List[HEATING_CONTROLS].new(HEATING_CONTROLS.HC2_NONE, HEATING_CONTROLS.HC2_PROGRAMMER_ONLY, HEATING_CONTROLS.HC2_ROOMSTAT_ONLY, HEATING_CONTROLS.HC2_PROGRAMMER_ROOMSTAT, HEATING_CONTROLS.HC2_PROGRAMMER_MULTI_ROOMSTATS, HEATING_CONTROLS.HC2_PROGRAMMER_TRVS_BYPASS, HEATING_CONTROLS.HC2_FULL_ZONE_CONTROL), true, false)
            when HEATING_TYPE.COMMUNITY_HEATING
              controls.SetAvailability(List[HEATING_CONTROLS].new(HEATING_CONTROLS.HC3_FRC_ONLY, HEATING_CONTROLS.HC3_FRC_PROGRAMMER_ONLY, HEATING_CONTROLS.HC3_FRC_ROOMSTAT_ONLY, HEATING_CONTROLS.HC3_FRC_PROGRAMMER_ROOMSTAT, HEATING_CONTROLS.HC3_FRC_PROGAMMER_TRVS, HEATING_CONTROLS.HC3_UBC_PROGRAMMER_TRVS, HEATING_CONTROLS.HC3_FRC_TRVS_ONLY, HEATING_CONTROLS.HC3_UBC_ROOMSTAT_ONLY, HEATING_CONTROLS.HC3_UBC_PROGRAMMER_ROOMSTAT, HEATING_CONTROLS.HC3_UBC_TRVS_ONLY), true, false)
            when HEATING_TYPE.ELECTRIC_STORAGE
              controls.SetAvailability(List[HEATING_CONTROLS].new(HEATING_CONTROLS.HC4_MANUAL_CHARGE, HEATING_CONTROLS.HC4_AUTOMATIC_CHARGE), true, false)
            when HEATING_TYPE.WARM_AIR, HEATING_TYPE.WARM_AIR_HEAT_PUMP
              controls.SetAvailability(List[HEATING_CONTROLS].new(HEATING_CONTROLS.HC5_NONE, HEATING_CONTROLS.HC5_PROGRAMMER_ONLY, HEATING_CONTROLS.HC5_ROOMSTAT_ONLY, HEATING_CONTROLS.HC5_PROGRAMMER_ROOMSTAT, HEATING_CONTROLS.HC5_PROGRAMMER_MULTI_ROOMSTATS, HEATING_CONTROLS.HC5_FULL_ZONE_CONTROL), true, false)
            when HEATING_TYPE.ROOM_HEATERS
              controls.SetAvailability(List[HEATING_CONTROLS].new(HEATING_CONTROLS.HC6_NONE, HEATING_CONTROLS.HC6_APPLSTAT, HEATING_CONTROLS.HC6_PROGRAMMER_APPLSTAT, HEATING_CONTROLS.HC6_ROOMSTAT_ONLY, HEATING_CONTROLS.HC6_PROGRAMMER_ROOMSTAT), true, false)
            when HEATING_TYPE.OTHER_HEATING, HEATING_TYPE.ELECTRIC_UNDERFLOOR
              controls.SetAvailability(List[HEATING_CONTROLS].new(HEATING_CONTROLS.HC7_NONE, HEATING_CONTROLS.HC7_PROGRAMMER_ONLY, HEATING_CONTROLS.HC7_ROOMSTAT_ONLY, HEATING_CONTROLS.HC7_PROGRAMMER_ROOMSTAT, HEATING_CONTROLS.HC7_TEMP_ONLY_ZONE_CONTROL, HEATING_CONTROLS.HC7_FULL_ZONE_CONTROL), true, false)
          end
          _ruleManager.SetRule(DiscreteDataRule[HEATING_CONTROLS].new(controls))
        else
          _ruleManager.SetRule(@_notRequireRule)
        end
      elsif HeatingSystem == PRIMARY_SYSTEM_TYPE.PST_NONE then
        _ruleManager.SetRule(@_notRequireRule)
      end
    else
      _ruleManager.SetRule(@_notRequireRule)
    end
  end
end
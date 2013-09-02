class WaterHeatingController < FieldController
  def initialize() # set everything to true, otherwise some options that get removed never come back until this class is recreated # can't determine system type so can't allow from main system for room heaters
    @_fieldTitle = StringEnum.GetEnumTitle()
    @_primaryHeatingTitle1 = "PrimaryHeating1\\" + StringEnum.GetEnumTitle()
    @_primaryHeatingTitle2 = "PrimaryHeating2\\" + StringEnum.GetEnumTitle()
    @_mainsGasTitle = "MainsGas"
    @_fuelTitle = StringEnum.GetEnumTitle()
    @_secondaryHeatingTitle = "Secondary" + StringEnum.GetEnumTitle()
    @_primarySystemTitle1 = "PrimaryHeating1\\" + StringEnum.GetEnumTitle()
    @_primarySystemTitle2 = "PrimaryHeating2\\" + StringEnum.GetEnumTitle()
    @_primarySystemType2 = "PrimaryHeating2\\" + StringEnum.GetEnumTitle()
    @_numberOfPrimarySystems = StringEnum.GetEnumTitle()
    @_gasOptions = List[WATER_TYPE].new(WATER_TYPE.WHTYPE_GASBACKBOILER, WATER_TYPE.WHTYPE_GASINSTANTMULTI, WATER_TYPE.WHTYPE_GASINSTANTSINGLE, WATER_TYPE.WHTYPE_GASWASYSTEM_1998On, WATER_TYPE.WHTYPE_GASWASYSTEM_PRE98)
    @_waterOptions = ContainedEnum.Create()
  end

  def DoControl()
    @_waterOptions.SetAvailability(@_waterOptions.All, true)
    numSystems = _connectedFields[@_numberOfPrimarySystems].AsInt
    if (numSystems.HasValue) and (numSystems == NUMBER_PRIMARY_SYSTEMS.NMS_ONE_DHW) then
      @_waterOptions.SetAvailability(@_waterOptions.All, false)
      @_waterOptions.SetAvailability(WATER_TYPE.WHTYPE_FROM_PRIMARYB, true)
      _ruleManager.SetRule(DiscreteDataRule[WATER_TYPE].new(@_waterOptions))
      return
    end
    Fuel = nil
    if _connectedFields.ContainsKey(@_fuelTitle) then
      Fuel = _connectedFields[@_fuelTitle].AsInt
    end
    PrimaryHeatingType1 = _connectedFields[@_primaryHeatingTitle1].AsInt
    MainsGas = _connectedFields[@_mainsGasTitle].AsInt
    PrimaryHeatingType2 = nil
    SecondayHeatingType = nil
    if _connectedFields.ContainsKey(@_primaryHeatingTitle2) and numSystems.HasValue and numSystems == NUMBER_PRIMARY_SYSTEMS.NMS_TWO then
      PrimaryHeatingType2 = _connectedFields[@_primaryHeatingTitle2].AsInt
    end
    if _connectedFields.ContainsKey(@_secondaryHeatingTitle) then
      SecondayHeatingType = _connectedFields[@_secondaryHeatingTitle].AsInt
    end
    @_waterOptions.SetAvailability(WATER_TYPE.WHTYPE_FROM_PRIMARYA, self.CanBeHeatedFromPrimary(PrimaryHeatingType1, @_primarySystemTitle1))
    @_waterOptions.SetAvailability(WATER_TYPE.WHTYPE_FROM_PRIMARYB, self.CanBeHeatedFromPrimary(PrimaryHeatingType2, @_primarySystemTitle2))
    if SecondayHeatingType.HasValue then
      if self.CheckForBackBoiler(@_secondaryHeatingTitle) then
        @_waterOptions.SetAvailability(WATER_TYPE.WHTYPE_FROM_SECONDARY, true)
      else
        @_waterOptions.SetAvailability(WATER_TYPE.WHTYPE_FROM_SECONDARY, false)
      end
    else
      @_waterOptions.SetAvailability(WATER_TYPE.WHTYPE_FROM_SECONDARY, false)
    end
    if MainsGas.HasValue and MainsGas == YESNO.NO then
      @_waterOptions.SetAvailability(@_gasOptions, false)
    else
      @_waterOptions.SetAvailability(@_gasOptions, true)
    end
    if PrimaryHeatingType1.HasValue and self.IsThereACPSU(@_primarySystemTitle1) then
      @_waterOptions.SetAvailability(List[WATER_TYPE].new(WATER_TYPE.WHTYPE_FROM_PRIMARYA), true, false)
    else
      if PrimaryHeatingType2.HasValue and self.IsThereACPSU(@_primarySystemTitle2) then
        @_waterOptions.SetAvailability(List[WATER_TYPE].new(WATER_TYPE.WHTYPE_FROM_PRIMARYB), true, false)
      end
    end
    @_waterOptions.SetAvailability(WATER_TYPE.WHTYPE_GASBACKBOILER, false)
    _ruleManager.SetRule(DiscreteDataRule[WATER_TYPE].new(@_waterOptions))
  end

  def CanBeHeatedFromPrimary(primaryHeatingType, _primarySystemTitle)
    if primaryHeatingType.HasValue and (primaryHeatingType == HEATING_TYPE.CENTRAL_HEATING or primaryHeatingType == HEATING_TYPE.WARM_AIR or primaryHeatingType == HEATING_TYPE.WARM_AIR_HEAT_PUMP or primaryHeatingType == HEATING_TYPE.ROOM_HEATERS or primaryHeatingType == HEATING_TYPE.COMMUNITY_HEATING or primaryHeatingType == HEATING_TYPE.HEAT_PUMPS or primaryHeatingType == HEATING_TYPE.MICRO_COGENERATION) then
      if primaryHeatingType == HEATING_TYPE.ROOM_HEATERS then
        if self.CheckForBackBoiler(_primarySystemTitle) then
          return true
        else
          return false
        end
      else
        return true
      end
    else
      return false
    end
  end

  def IsThereACPSU(Title)
    System = nil
    if _connectedFields.ContainsKey(Title) then
      System = _connectedFields[Title].AsInt
    end
    if System.HasValue then
      case System
        when HEATING_SYSTEM.ELEC_CPSU, HEATING_SYSTEM.GAS_CPSU_CONDENSING, HEATING_SYSTEM.GAS_CPSU_NORMAL
          return true
        else
          return false
      end
    end
    return false
  end

  def CheckForBackBoiler(Title)
    System = nil
    if _connectedFields.ContainsKey(Title) then
      System = _connectedFields[Title].AsInt
    end
    if System.HasValue then
      case System
        when HEATING_SYSTEM.GAS_FIRE_PRE80_BACKBOILER, HEATING_SYSTEM.GAS_FIRE_OPEN_FLUE_BACKBOILER, HEATING_SYSTEM.GAS_FIRE_FLUSH_SEALED_BACKBOILER, HEATING_SYSTEM.SOLID_OPEN_FIRE_BB, HEATING_SYSTEM.SOLID_CLOSED_HEATER_BB, HEATING_SYSTEM.SOLID_STOVE_BOILER_BB, HEATING_SYSTEM.OIL_HEATER_PRE00_BB_NORADS, HEATING_SYSTEM.OIL_HEATER_POST99_BB_NORADS
          return true
        else
          return false
      end
    else
      return false
    end
  end
end
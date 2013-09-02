class WaterHeatingFuelController < FieldController
  def initialize()
    # Allow all lpg gas types and mains gas only if available
    @_fuels = ContainedEnum.Create()
    @_fieldTitle = "WaterFuel"
    @_mainsGasTitle = "MainsGas"
    @_waterHeatingTitle = StringEnum.GetEnumTitle()
    @_primaryFuelType1 = "\\PrimaryHeating1\\" + StringEnum.GetEnumTitle()
    @_primaryFuelType2 = "\\PrimaryHeating2\\" + StringEnum.GetEnumTitle()
    @_secondaryFuelType = "Secondary" + StringEnum.GetEnumTitle()
  end

  def DoControl()
    waterSystem = _connectedFields[@_waterHeatingTitle].AsInt
    GasAvailable = _connectedFields[@_mainsGasTitle].AsInt
    isRequired = false
    if waterSystem.HasValue then
      waterType = waterSystem.Value
      isRequired = self.CheckIfRequired(waterType)
      if isRequired then
        @_fuels.SetAvailability(@_fuels.All, false)
        self.CheckGasHeating(waterType, GasAvailable)
        self.CheckElectricHeating(waterType)
        self.CheckFromPrimarySecondary(waterType)
        self.CheckOilHeating(waterType)
        self.CheckSolidHeating(waterType)
        self.CheckCommunityHeating(waterType)
      else
        @_fuels.SetAvailability(@_fuels.All, false)
        @_fuels.SetAvailability(HEATSYS_FUEL.HS_FUEL_NONE, true)
        _ruleManager.SetRule(DiscreteDataRule[HEATSYS_FUEL].new(@_fuels))
      end
    else
      _ruleManager.SetRule(NotRequiredDataRule.Instance)
    end
  end

  def CheckGasHeating(waterType, GasAvailable)
    if (waterType == WATER_TYPE.WHTYPE_GAS_BOILER_WATER_ONLY) or (waterType == WATER_TYPE.WHTYPE_GAS_RANGE_SINGLE_AUTO) or (waterType == WATER_TYPE.WHTYPE_GAS_RANGE_SINGLE_PERMPILOT) or (waterType == WATER_TYPE.WHTYPE_GAS_RANGE_TWIN__AUTO) or (waterType == WATER_TYPE.WHTYPE_GASBACKBOILER) or (waterType == WATER_TYPE.WHTYPE_GASINSTANTMULTI) or (waterType == WATER_TYPE.WHTYPE_GASINSTANTSINGLE) or (waterType == WATER_TYPE.WHTYPE_GASWASYSTEM_1998On) or (waterType == WATER_TYPE.WHTYPE_GASWASYSTEM_PRE98) then
      setFromSystem = self.CheckPrimaryAndSecondryForGas(GasAvailable)
      @_fuels.SetAvailability(@_fuels.All, false)
      @_fuels.SetAvailability(setFromSystem, true, false)
      _ruleManager.SetRule(DiscreteDataRule[HEATSYS_FUEL].new(@_fuels))
    end
  end

  def CheckPrimaryAndSecondryForGas(GasAvailable)
    rv = List[HEATSYS_FUEL].new(HEATSYS_FUEL.HSFUEL_LPG_BULK, HEATSYS_FUEL.HSFUEL_LPG_BOTTLE)
    if (GasAvailable.HasValue) and (GasAvailable.Value == 1) then
      rv.Add(HEATSYS_FUEL.HSFUEL_MAINSGAS)
    end
    return rv
  end

  def IsGas(fuelType)
    if not fuelType.HasValue then
      return nil
    else
      case fuelType.Value
        when HEATSYS_FUEL.HSFUEL_MAINSGAS
          return HEATSYS_FUEL.HSFUEL_MAINSGAS
        when HEATSYS_FUEL.HSFUEL_LPG_BULK
          return HEATSYS_FUEL.HSFUEL_LPG_BULK
        when HEATSYS_FUEL.HSFUEL_LPG_BOTTLE
          return HEATSYS_FUEL.HSFUEL_LPG_BOTTLE
        when HEATSYS_FUEL.HSFUEL_LPG_SPECIAL18
          return HEATSYS_FUEL.HSFUEL_LPG_SPECIAL18
      end
    end
    return nil
  end

  def CheckOilHeating(waterType)
    if (waterType == WATER_TYPE.WHTYPE_OIL_BOILER_WATER_ONLY) or (waterType == WATER_TYPE.WHTYPE_OIL_RANGE_SINGLE) or (waterType == WATER_TYPE.WHTYPE_OIL_RANGE_TWIN) then
      @_fuels.SetAvailability(HEATSYS_FUEL.HSFUEL_OIL, true)
      @_fuels.SetAvailability(HEATSYS_FUEL.HSFUEL_B30K, true)
      _ruleManager.SetRule(DiscreteDataRule[HEATSYS_FUEL].new(@_fuels))
    end
  end

  def CheckSolidHeating(waterType)
    if (waterType == WATER_TYPE.WHTYPE_SOLID_BOILER_WATER_ONLY) or (waterType == WATER_TYPE.WHTYPE_SOLID_RANGE_INDEPENDANT) or (waterType == WATER_TYPE.WHTYPE_SOLID_RANGE_INTEGRAL) then
      @_fuels.SetAvailability(List[HEATSYS_FUEL].new(HEATSYS_FUEL.HSFUEL_COAL, HEATSYS_FUEL.HSFUEL_ANTHRACITE, HEATSYS_FUEL.HSFUEL_SMOKELESS, HEATSYS_FUEL.HSFUEL_WOODLOGS, HEATSYS_FUEL.HSFUEL_WOODPELLETS, HEATSYS_FUEL.HSFUEL_WOODCHIPS, HEATSYS_FUEL.HSFUEL_SOLID_MULTIF), true, false)
      _ruleManager.SetRule(DiscreteDataRule[HEATSYS_FUEL].new(@_fuels))
    end
  end

  def CheckElectricHeating(waterType)
    if (waterType == WATER_TYPE.WHTYPE_IMMERSION) or (waterType == WATER_TYPE.WHTYPE_ELECTRICINSTANT) then
      @_fuels.SetAvailability(HEATSYS_FUEL.HSFUEL_ELECTRIC, true)
      _ruleManager.SetRule(DiscreteDataRule[HEATSYS_FUEL].new(@_fuels))
    end
  end

  def CheckCommunityHeating(waterType)
    if (waterType == WATER_TYPE.WHTYPE_COMMUNITY_BOILERS) or (waterType == WATER_TYPE.WHTYPE_COMMUNITY_CHP) or (waterType == WATER_TYPE.WHTYPE_COMMUNITY_HEAT_PUMP) then
      @_fuels.SetAvailability(List[HEATSYS_FUEL].new(HEATSYS_FUEL.HSFUEL_MAINSGAS, HEATSYS_FUEL.HSFUEL_OIL, HEATSYS_FUEL.HSFUEL_COAL, HEATSYS_FUEL.HSFUEL_ELECTRIC, HEATSYS_FUEL.HSFUEL_CH_WASTE, HEATSYS_FUEL.HSFUEL_CH_BIOMASS, HEATSYS_FUEL.HSFUEL_CH_BIOGAS, HEATSYS_FUEL.HSFUEL_B30D, HEATSYS_FUEL.HSFUEL_UNKNOWN), true, false)
      _ruleManager.SetRule(DiscreteDataRule[HEATSYS_FUEL].new(@_fuels))
    end
  end

  def CheckFromPrimarySecondary(waterType)
    if (waterType == WATER_TYPE.WHTYPE_FROM_PRIMARYA) then
      mainFuel = _connectedFields[@_primaryFuelType1].AsInt
      if mainFuel.HasValue then
        fuel = mainFuel.Value
        @_fuels.SetAvailability(@_fuels.All, false)
        @_fuels.SetAvailability(fuel, true)
        _ruleManager.SetRule(DiscreteDataRule[HEATSYS_FUEL].new(@_fuels))
      else
        _ruleManager.SetRule(NotRequiredDataRule.Instance)
      end
    elsif (waterType == WATER_TYPE.WHTYPE_FROM_PRIMARYB) then
      mainFuel = _connectedFields[@_primaryFuelType2].AsInt
      if mainFuel.HasValue then
        fuel = mainFuel.Value
        @_fuels.SetAvailability(@_fuels.All, false)
        @_fuels.SetAvailability(fuel, true)
        _ruleManager.SetRule(DiscreteDataRule[HEATSYS_FUEL].new(@_fuels))
      else
        _ruleManager.SetRule(NotRequiredDataRule.Instance)
      end
    elsif (waterType == WATER_TYPE.WHTYPE_FROM_SECONDARY) then
      mainFuel = _connectedFields[@_secondaryFuelType].AsInt
      if mainFuel.HasValue then
        fuel = mainFuel.Value
        @_fuels.SetAvailability(@_fuels.All, false)
        @_fuels.SetAvailability(fuel, true)
        _ruleManager.SetRule(DiscreteDataRule[HEATSYS_FUEL].new(@_fuels))
      else
        _ruleManager.SetRule(NotRequiredDataRule.Instance)
      end
    end
  end

  def CheckIfRequired(waterType)
    if waterType == WATER_TYPE.WHTYPE_NONE then
      return false
    end
    return true
  end
end
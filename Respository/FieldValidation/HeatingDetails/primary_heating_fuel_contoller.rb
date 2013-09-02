class PrimaryHeatingFuelController < FieldController
  def initialize()
    #electric room heaters currently dont have back boilers and so cannot be used for DHW only
    # There's an extra check required for mains gas.  If there are no mains gas then rmeove it form the list even if system type said it should be available
    @_fieldTitle = StringEnum.GetEnumTitle()
    @_primarySystemType1 = "\\PrimaryHeating1\\" + StringEnum.GetEnumTitle()
    @_primaryHeatingTypeTitle1 = "\\PrimaryHeating1\\" + StringEnum.GetEnumTitle()
    @_sedbukIndexTitle1 = "\\PrimaryHeating1\\SedbukBoilerIndex"
    @_primarySystemType2 = "\\PrimaryHeating2\\" + StringEnum.GetEnumTitle()
    @_primaryHeatingTypeTitle2 = "\\PrimaryHeating2\\" + StringEnum.GetEnumTitle()
    @_sedbukIndexTitle2 = "\\PrimaryHeating2\\SedbukBoilerIndex"
    @_mainsGasTitle = "MainsGas"
    @_numberOfSystemsTitle = StringEnum.GetEnumTitle()
    @_notRequired = NotRequiredDataRule.Instance
    @_fuel = ContainedEnum.Create()
  end

  def DoControl()
    dHWOnly = false
    if self.@FullName.Contains("PrimaryHeating1") then
      self.CheckFuelForSystem(@_primaryHeatingTypeTitle1, @_primarySystemType1, @_sedbukIndexTitle1, dHWOnly)
    elsif self.@FullName.Contains("PrimaryHeating2") then
      if _connectedFields.ContainsKey(@_numberOfSystemsTitle) then
        numberOfSystems = _connectedFields[@_numberOfSystemsTitle].AsInt
        if numberOfSystems.HasValue and numberOfSystems == NUMBER_PRIMARY_SYSTEMS.NMS_ONE_DHW then
          dHWOnly = true
        end
      end
      self.CheckFuelForSystem(@_primaryHeatingTypeTitle2, @_primarySystemType2, @_sedbukIndexTitle2, dHWOnly)
    end
  end

  def CheckFuelForSystem(primaryHeatingTypeTitle, primarySystemType, sedbukIndexTitle, dHWOnly)
    PrimaryHeating = _connectedFields[primaryHeatingTypeTitle].AsInt
    SystemType = _connectedFields[primarySystemType].AsInt
    SedbukIndex = _connectedFields[sedbukIndexTitle].Value
    if SystemType.HasValue and SystemType == PRIMARY_SYSTEM_TYPE.PST_NONE then
      @_fuel.SetAvailability(@_fuel.All, false)
      @_fuel.SetAvailability(HEATSYS_FUEL.HS_FUEL_NONE, true)
    elsif SedbukIndex != nil and (SedbukIndex != "0") then
      case SedbukAccess.GetFuelForBoiler(SedbukIndex)
        when SedbukAccess.SedbukFuel.SF_Gas
          @_fuel.SetAvailability(List[HEATSYS_FUEL].new(HEATSYS_FUEL.HSFUEL_MAINSGAS), true, false)
        when SedbukAccess.SedbukFuel.SF_LPG
          @_fuel.SetAvailability(List[HEATSYS_FUEL].new(HEATSYS_FUEL.HSFUEL_LPG_BULK, HEATSYS_FUEL.HSFUEL_LPG_SPECIAL18, HEATSYS_FUEL.HSFUEL_LPG_BOTTLE), true, false)
        when SedbukAccess.SedbukFuel.SF_Oil
          @_fuel.SetAvailability(List[HEATSYS_FUEL].new(HEATSYS_FUEL.HSFUEL_OIL), true, false)
        when SedbukAccess.SedbukFuel.SF_ELECTRICITY
          @_fuel.SetAvailability(List[HEATSYS_FUEL].new(HEATSYS_FUEL.HSFUEL_ELECTRIC), true, false)
        when SedbukAccess.SedbukFuel.SF_HOUSE_COAL
          @_fuel.SetAvailability(List[HEATSYS_FUEL].new(HEATSYS_FUEL.HSFUEL_COAL), true, false)
        when SedbukAccess.SedbukFuel.SF_ANTHRACITE
          @_fuel.SetAvailability(List[HEATSYS_FUEL].new(HEATSYS_FUEL.HSFUEL_ANTHRACITE), true, false)
        when SedbukAccess.SedbukFuel.SF_SMOKELESSFUEL
          @_fuel.SetAvailability(List[HEATSYS_FUEL].new(HEATSYS_FUEL.HSFUEL_SMOKELESS), true, false)
        when SedbukAccess.SedbukFuel.SF_WOODCHIPS
          @_fuel.SetAvailability(List[HEATSYS_FUEL].new(HEATSYS_FUEL.HSFUEL_WOODCHIPS), true, false)
        when SedbukAccess.SedbukFuel.SF_WOODLOGS
          @_fuel.SetAvailability(List[HEATSYS_FUEL].new(HEATSYS_FUEL.HSFUEL_WOODLOGS), true, false)
        when SedbukAccess.SedbukFuel.SF_WOODPELLETS
          @_fuel.SetAvailability(List[HEATSYS_FUEL].new(HEATSYS_FUEL.HSFUEL_WOODPELLETS), true, false)
        when SedbukAccess.SedbukFuel.SF_B30K
          @_fuel.SetAvailability(List[HEATSYS_FUEL].new(HEATSYS_FUEL.HSFUEL_B30K), true, false)
        when SedbukAccess.SedbukFuel.SF_BIODIESEL_BIOMASS
          @_fuel.SetAvailability(List[HEATSYS_FUEL].new(HEATSYS_FUEL.HSFUEL_BIODIESEL_BIOMASS), true, false)
        when SedbukAccess.SedbukFuel.SF_BIODIESEL_COOKINGOIL
          @_fuel.SetAvailability(List[HEATSYS_FUEL].new(HEATSYS_FUEL.HSFUEL_BIODIESEL_COOKINGOIL), true, false)
        when SedbukAccess.SedbukFuel.SF_RAPESEED_OIL
          @_fuel.SetAvailability(List[HEATSYS_FUEL].new(HEATSYS_FUEL.HSFUEL_RAPESEED_OIL), true, false)
        when SedbukAccess.SedbukFuel.SF_MINERALOIL
          @_fuel.SetAvailability(List[HEATSYS_FUEL].new(HEATSYS_FUEL.HSFUEL_MINERALOIL), true, false)
      end
    elsif SystemType.HasValue and SystemType == PRIMARY_SYSTEM_TYPE.PST_SEDBUK then
      @_fuel.SetAvailability(@_fuel.All, false)
    elsif PrimaryHeating.HasValue then
      case PrimaryHeating
        when HEATING_TYPE.CENTRAL_HEATING, HEATING_TYPE.ROOM_HEATERS
          if SystemType.HasValue and SystemType == PRIMARY_SYSTEM_TYPE.PST_SEDBUK then
            @_fuel.SetAvailability(List[HEATSYS_FUEL].new(HEATSYS_FUEL.HSFUEL_MAINSGAS, HEATSYS_FUEL.HSFUEL_LPG_BULK, HEATSYS_FUEL.HSFUEL_LPG_SPECIAL18, HEATSYS_FUEL.HSFUEL_OIL, HEATSYS_FUEL.HSFUEL_B30K), true, false)
          else
            @_fuel.SetAvailability(List[HEATSYS_FUEL].new(HEATSYS_FUEL.HSFUEL_COAL, HEATSYS_FUEL.HSFUEL_ANTHRACITE, HEATSYS_FUEL.HSFUEL_SMOKELESS, HEATSYS_FUEL.HSFUEL_WOODLOGS, HEATSYS_FUEL.HSFUEL_WOODPELLETS, HEATSYS_FUEL.HSFUEL_WOODCHIPS, HEATSYS_FUEL.HSFUEL_SOLID_MULTIF, HEATSYS_FUEL.HSFUEL_ELECTRIC, HEATSYS_FUEL.HSFUEL_MAINSGAS, HEATSYS_FUEL.HSFUEL_LPG_BULK, HEATSYS_FUEL.HSFUEL_LPG_BOTTLE, HEATSYS_FUEL.HSFUEL_LPG_SPECIAL18, HEATSYS_FUEL.HSFUEL_OIL, HEATSYS_FUEL.HSFUEL_B30K), true, false)
          end
          if PrimaryHeating == HEATING_TYPE.ROOM_HEATERS and dHWOnly then
            @_fuel.SetAvailability(HEATSYS_FUEL.HSFUEL_ELECTRIC, false)
          end
        when HEATING_TYPE.MICRO_COGENERATION
          @_fuel.SetAvailability(List[HEATSYS_FUEL].new(HEATSYS_FUEL.HSFUEL_MAINSGAS, HEATSYS_FUEL.HSFUEL_LPG_BULK, HEATSYS_FUEL.HSFUEL_LPG_SPECIAL18, HEATSYS_FUEL.HSFUEL_OIL, HEATSYS_FUEL.HSFUEL_B30K), true, false)
          break
        when HEATING_TYPE.HEAT_PUMPS, HEATING_TYPE.ELECTRIC_STORAGE, HEATING_TYPE.ELECTRIC_UNDERFLOOR, HEATING_TYPE.WARM_AIR_HEAT_PUMP, HEATING_TYPE.OTHER_HEATING
          @_fuel.SetAvailability(List[HEATSYS_FUEL].new(HEATSYS_FUEL.HSFUEL_ELECTRIC), true, false)
        when HEATING_TYPE.COMMUNITY_HEATING
          @_fuel.SetAvailability(List[HEATSYS_FUEL].new(HEATSYS_FUEL.HSFUEL_MAINSGAS, HEATSYS_FUEL.HSFUEL_OIL, HEATSYS_FUEL.HSFUEL_COAL, HEATSYS_FUEL.HSFUEL_ELECTRIC, HEATSYS_FUEL.HSFUEL_CH_WASTE, HEATSYS_FUEL.HSFUEL_CH_BIOMASS, HEATSYS_FUEL.HSFUEL_CH_BIOGAS, HEATSYS_FUEL.HSFUEL_B30D, HEATSYS_FUEL.HSFUEL_UNKNOWN), true, false)
        when HEATING_TYPE.WARM_AIR
          @_fuel.SetAvailability(List[HEATSYS_FUEL].new(HEATSYS_FUEL.HSFUEL_MAINSGAS, HEATSYS_FUEL.HSFUEL_LPG_BULK, HEATSYS_FUEL.HSFUEL_LPG_SPECIAL18, HEATSYS_FUEL.HSFUEL_LPG_BOTTLE, HEATSYS_FUEL.HSFUEL_ELECTRIC, HEATSYS_FUEL.HSFUEL_OIL, HEATSYS_FUEL.HSFUEL_B30K), true, false)
      end
    else
      @_fuel.SetAvailability(@_fuel.All, true)
      _ruleManager.SetRule(DiscreteDataRule[HEATSYS_FUEL].new(@_fuel))
    end
    gas = _connectedFields[@_mainsGasTitle].AsInt
    if gas.HasValue and gas == YESNO.NO then
      @_fuel.SetAvailability(List[HEATSYS_FUEL].new(HEATSYS_FUEL.HSFUEL_MAINSGAS, HEATSYS_FUEL.HSFUEL_MAINSGAS), false)
    end
    if @_fuel.Available.Count() > 0 then
      _ruleManager.SetRule(DiscreteDataRule[HEATSYS_FUEL].new(@_fuel))
    else
      _ruleManager.SetRule(NotRequiredDataRule.Instance)
    end
  end
end
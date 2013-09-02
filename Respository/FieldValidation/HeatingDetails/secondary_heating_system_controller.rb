class SecondaryHeatingSystemController < FieldController
  def initialize() # Attempting to catch the rest I don't know about # if Fuel hasn't been input yet then don't restrict options based on fuel
    @_fieldTitle = "Secondary" + StringEnum.GetEnumTitle()
    @_secondaryFuelTitle = "Secondary" + StringEnum.GetEnumTitle()
    @_secondaryHeatingPresentTitle = "SecondarySystemPresent"
    @_roomHeatersGasOptions = List[HEATING_SYSTEM].new(HEATING_SYSTEM.GAS_FIRE_PRE80, HEATING_SYSTEM.GAS_FIRE_PRE80_BACKBOILER, HEATING_SYSTEM.GAS_FIRE_OPEN_FLUE, HEATING_SYSTEM.GAS_FIRE_BALANCED_FLUE, HEATING_SYSTEM.GAS_FIRE_CLOSED, HEATING_SYSTEM.GAS_FIRE_CONDENSING, HEATING_SYSTEM.GAS_FIRE_FLUSH_SEALED, HEATING_SYSTEM.GAS_FIRE_FLUSH_SEALED_FANNED, HEATING_SYSTEM.GAS_FIRE_DECORATIVE_TO_CHIMNEY, HEATING_SYSTEM.GAS_FIRE_FLUELESS, HEATING_SYSTEM.GAS_FIRE_OPEN_FLUE_BACKBOILER, HEATING_SYSTEM.GAS_FIRE_FLUSH_SEALED_BACKBOILER)
    @_roomHeatersOilOptions = List[HEATING_SYSTEM].new(HEATING_SYSTEM.OIL_HEATER_PRE00, HEATING_SYSTEM.OIL_HEATER_POST99, HEATING_SYSTEM.OIL_HEATER_PRE00_BB_NORADS, HEATING_SYSTEM.OIL_HEATER_POST99_BB_NORADS)
    @_roomHeatersSolidOptions = List[HEATING_SYSTEM].new(HEATING_SYSTEM.SOLID_OPEN_FIRE, HEATING_SYSTEM.SOLID_OPEN_FIRE_BB, HEATING_SYSTEM.SOLID_CLOSED_HEATER, HEATING_SYSTEM.SOLID_CLOSED_HEATER_BB, HEATING_SYSTEM.SOLID_STOVE, HEATING_SYSTEM.SOLID_STOVE_BOILER_BB)
    @_roomHeatersElectricOptions = List[HEATING_SYSTEM].new(HEATING_SYSTEM.ELEC_PANEL_HEATERS, HEATING_SYSTEM.ELEC_WATER_OIL_RADS)
    @_notRequired = NotRequiredDataRule.Instance
    @_heatingSystem = ContainedEnum.Create()
  end

  def DoControl()
    current = _connectedFields[@_secondaryHeatingPresentTitle].AsInt
    fuel = _connectedFields[@_secondaryFuelTitle].AsInt
    if current.HasValue and current == YESNO.YES then
      if fuel.HasValue then
        case fuel
          when HEATSYS_FUEL.HSFUEL_OIL, HEATSYS_FUEL.HSFUEL_B30K
            @_heatingSystem.SetAvailability(@_roomHeatersOilOptions, true, false)
          when HEATSYS_FUEL.HSFUEL_BIOETHANOL_SECONDARY
            @_heatingSystem.SetAvailability(@_heatingSystem.All, false)
            @_heatingSystem.SetAvailability(HEATING_SYSTEM.OIL_BIOETHANOL_SECONDARY_ONLY, true)
          when HEATSYS_FUEL.HSFUEL_ELECTRIC
            @_heatingSystem.SetAvailability(@_roomHeatersElectricOptions, true, false)
          when HEATSYS_FUEL.HSFUEL_COAL, HEATSYS_FUEL.HSFUEL_ANTHRACITE, HEATSYS_FUEL.HSFUEL_SOLID_MULTIF, HEATSYS_FUEL.HSFUEL_WOODLOGS, HEATSYS_FUEL.HSFUEL_WOODPELLETS, HEATSYS_FUEL.HSFUEL_SMOKELESS
            @_heatingSystem.SetAvailability(@_roomHeatersSolidOptions, true, false)
          when HEATSYS_FUEL.HSFUEL_MAINSGAS, HEATSYS_FUEL.HSFUEL_LPG_BOTTLE, HEATSYS_FUEL.HSFUEL_LPG_BULK, HEATSYS_FUEL.HSFUEL_LPG_SPECIAL18
            @_heatingSystem.SetAvailability(@_roomHeatersGasOptions, true, false)
          else
            @_heatingSystem.SetAvailability(List[HEATING_SYSTEM].new(HEATING_SYSTEM.UNKNOWN), true, false)
        end
      else
        @_heatingSystem.SetAvailability(List[HEATING_SYSTEM].new(HEATING_SYSTEM.OIL_HEATER_PRE00, HEATING_SYSTEM.OIL_HEATER_POST99, HEATING_SYSTEM.SOLID_OPEN_FIRE, HEATING_SYSTEM.SOLID_CLOSED_HEATER, HEATING_SYSTEM.ELEC_PANEL_HEATERS), true, false)
      end
      _ruleManager.SetRule(DiscreteDataRule[HEATING_SYSTEM].new(@_heatingSystem))
    else
      _ruleManager.SetRule(@_notRequired)
    end
  end
end
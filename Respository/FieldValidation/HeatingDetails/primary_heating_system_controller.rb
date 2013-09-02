class PrimaryHeatingSystemController < FieldController
  def initialize()
    # Sub type not selected so display them all # Attempting to catch the rest I don't know about # if Fuel hasn't been input yet then don't restrict options based on fuel # Attempting to catch the rest I don't know about # if Fuel hasn't been input yet then don't restrict options based on fuel # Attempting to catch the rest I don't know about # if Fuel hasn't been input yet then don't restrict options based on fuel
    @_centralHeatedGasOptions1998OrLater = List[HEATING_SYSTEM].new(HEATING_SYSTEM.GAS_POST97_AUTO, HEATING_SYSTEM.GAS_POST97_COMBI_AUTO, HEATING_SYSTEM.GAS_POST97_CONDENSING, HEATING_SYSTEM.GAS_POST97_CONDENSING_COMBI, HEATING_SYSTEM.GAS_POST97_PILOT, HEATING_SYSTEM.GAS_POST97_COMBI_PILOT, HEATING_SYSTEM.GAS_POST97_BACK)
    @_centralHeatedGasOptionsPre1998FanAssistedFlue = List[HEATING_SYSTEM].new(HEATING_SYSTEM.GAS_FAN_PRE98, HEATING_SYSTEM.GAS_FAN_PRE98_COMBI, HEATING_SYSTEM.GAS_FAN_PRE98_CONDENSING, HEATING_SYSTEM.GAS_FAN_PRE98_CONDENSING_COMBI)
    @_centralHeatedGasOptionsPre1998BalancedOrOpenFlue = List[HEATING_SYSTEM].new(HEATING_SYSTEM.GAS_PRE98_WALL, HEATING_SYSTEM.GAS_PRE98_FLOOR_OLD, HEATING_SYSTEM.GAS_PRE98_FLOOR, HEATING_SYSTEM.GAS_PRE98_COMBI, HEATING_SYSTEM.GAS_PRE98_BACK)
    @_centralHeatedGasOptionsCPSU = List[HEATING_SYSTEM].new(HEATING_SYSTEM.GAS_CPSU_NORMAL, HEATING_SYSTEM.GAS_CPSU_CONDENSING)
    @_centralHeatedGasOptionsRangeCookers = List[HEATING_SYSTEM].new(HEATING_SYSTEM.GAS_RANGE_SINGLE, HEATING_SYSTEM.GAS_RANGE_SINGLE_AUTO, HEATING_SYSTEM.GAS_RANGE_TWIN)
    @_centralheatedSolidFuleOptions = List[HEATING_SYSTEM].new(HEATING_SYSTEM.SOLID_MANUAL, HEATING_SYSTEM.SOLID_MANUAL_UNHEATED, HEATING_SYSTEM.SOLID_AUTO, HEATING_SYSTEM.SOLID_AUTO_HEATED, HEATING_SYSTEM.SOLID_OPEN_BACK, HEATING_SYSTEM.SOLID_WOOD_INDEPENDANT, HEATING_SYSTEM.SOLID_CLOSED_BACK, HEATING_SYSTEM.SOLID_STOVE_WITH_BOILER, HEATING_SYSTEM.SOLID_RANGE_COOKER)
    @_centralHeatedElectricOptions = List[HEATING_SYSTEM].new(HEATING_SYSTEM.ELEC_DIRECT_BOILER, HEATING_SYSTEM.ELEC_CPSU, HEATING_SYSTEM.ELEC_DRYCORE_STORAGE, HEATING_SYSTEM.ELEC_WATER_STORAGE)
    @_centralHeatedElectricWithSingleMeterOptions = List[HEATING_SYSTEM].new(HEATING_SYSTEM.ELEC_DIRECT_BOILER)
    @_centralHeatedOilOptions = List[HEATING_SYSTEM].new(HEATING_SYSTEM.OIL_POST97_STANDARD, HEATING_SYSTEM.OIL_PRE98_STANDARD, HEATING_SYSTEM.OIL_CONDENSING, HEATING_SYSTEM.OIL_PRE98_COMBI, HEATING_SYSTEM.OIL_POST97_COMBI, HEATING_SYSTEM.OIL_CONDENSING_COMBI, HEATING_SYSTEM.OIL_PRE00_BACK, HEATING_SYSTEM.OIL_POST99_BACK, HEATING_SYSTEM.OIL_RANGE_SINGLE, HEATING_SYSTEM.OIL_RANGE_TWIN)
    @_roomHeatersGasOptions = List[HEATING_SYSTEM].new(HEATING_SYSTEM.GAS_FIRE_PRE80, HEATING_SYSTEM.GAS_FIRE_PRE80_BACKBOILER, HEATING_SYSTEM.GAS_FIRE_OPEN_FLUE, HEATING_SYSTEM.GAS_FIRE_BALANCED_FLUE, HEATING_SYSTEM.GAS_FIRE_CLOSED, HEATING_SYSTEM.GAS_FIRE_CONDENSING, HEATING_SYSTEM.GAS_FIRE_FLUSH_SEALED, HEATING_SYSTEM.GAS_FIRE_FLUSH_SEALED_FANNED, HEATING_SYSTEM.GAS_FIRE_DECORATIVE_TO_CHIMNEY, HEATING_SYSTEM.GAS_FIRE_FLUELESS, HEATING_SYSTEM.GAS_FIRE_OPEN_FLUE_BACKBOILER, HEATING_SYSTEM.GAS_FIRE_FLUSH_SEALED_BACKBOILER)
    @_roomHeatersGasOptionsBackBoiler = List[HEATING_SYSTEM].new(HEATING_SYSTEM.GAS_FIRE_PRE80_BACKBOILER, HEATING_SYSTEM.GAS_FIRE_OPEN_FLUE_BACKBOILER, HEATING_SYSTEM.GAS_FIRE_FLUSH_SEALED_BACKBOILER)
    @_roomHeatersGasOpenFlueOptions = List[HEATING_SYSTEM].new(HEATING_SYSTEM.GAS_FIRE_PRE80, HEATING_SYSTEM.GAS_FIRE_PRE80_BACKBOILER, HEATING_SYSTEM.GAS_FIRE_OPEN_FLUE, HEATING_SYSTEM.GAS_FIRE_OPEN_FLUE_BACKBOILER, HEATING_SYSTEM.GAS_FIRE_FLUSH_SEALED_BACKBOILER, HEATING_SYSTEM.GAS_FIRE_FLUSH_SEALED_FANNED, HEATING_SYSTEM.GAS_FIRE_FLUSH_SEALED)
    @_roomHeatersGasOpenFlueOptionsBackBoiler = List[HEATING_SYSTEM].new(HEATING_SYSTEM.GAS_FIRE_PRE80_BACKBOILER, HEATING_SYSTEM.GAS_FIRE_OPEN_FLUE_BACKBOILER, HEATING_SYSTEM.GAS_FIRE_FLUSH_SEALED_BACKBOILER)
    @_roomHeatersGasBalancedFlueOptions = List[HEATING_SYSTEM].new(HEATING_SYSTEM.GAS_FIRE_BALANCED_FLUE, HEATING_SYSTEM.GAS_FIRE_CLOSED, HEATING_SYSTEM.GAS_FIRE_CONDENSING)
    @_roomHeatersGasChimneyOptions = List[HEATING_SYSTEM].new(HEATING_SYSTEM.GAS_FIRE_DECORATIVE_TO_CHIMNEY)
    @_roomHeatersGasFluelessOptions = List[HEATING_SYSTEM].new(HEATING_SYSTEM.GAS_FIRE_FLUELESS)
    @_roomHeatersOilOptions = List[HEATING_SYSTEM].new(HEATING_SYSTEM.OIL_HEATER_PRE00, HEATING_SYSTEM.OIL_HEATER_POST99, HEATING_SYSTEM.OIL_HEATER_PRE00_BB_NORADS, HEATING_SYSTEM.OIL_HEATER_POST99_BB_NORADS)
    @_roomHeatersOilOptionsBackBoilers = List[HEATING_SYSTEM].new(HEATING_SYSTEM.OIL_HEATER_PRE00_BB_NORADS, HEATING_SYSTEM.OIL_HEATER_POST99_BB_NORADS)
    @_roomHeatersSolidOptions = List[HEATING_SYSTEM].new(HEATING_SYSTEM.SOLID_OPEN_FIRE, HEATING_SYSTEM.SOLID_OPEN_FIRE_BB, HEATING_SYSTEM.SOLID_CLOSED_HEATER, HEATING_SYSTEM.SOLID_CLOSED_HEATER_BB, HEATING_SYSTEM.SOLID_STOVE, HEATING_SYSTEM.SOLID_STOVE_BOILER_BB)
    @_roomHeatersSolidOptionsBackBoiler = List[HEATING_SYSTEM].new(HEATING_SYSTEM.SOLID_OPEN_FIRE_BB, HEATING_SYSTEM.SOLID_CLOSED_HEATER_BB, HEATING_SYSTEM.SOLID_STOVE_BOILER_BB)
    @_roomHeatersElectricOptions = List[HEATING_SYSTEM].new(HEATING_SYSTEM.ELEC_PANEL_HEATERS, HEATING_SYSTEM.ELEC_PORTABLE_HEATERS, HEATING_SYSTEM.ELEC_WATER_OIL_RADS)
    @_centralHeatedOilCombiOptions = List[HEATING_SYSTEM].new(HEATING_SYSTEM.OIL_PRE98_COMBI, HEATING_SYSTEM.OIL_POST97_COMBI, HEATING_SYSTEM.OIL_CONDENSING_COMBI)
    @_centralHeatedOilNonCombiOptions = List[HEATING_SYSTEM].new(HEATING_SYSTEM.OIL_POST97_STANDARD, HEATING_SYSTEM.OIL_PRE98_STANDARD, HEATING_SYSTEM.OIL_CONDENSING, HEATING_SYSTEM.OIL_PRE00_BACK, HEATING_SYSTEM.OIL_POST99_BACK)
    @_centralHeatedOilRangeOptions = List[HEATING_SYSTEM].new(HEATING_SYSTEM.OIL_RANGE_SINGLE, HEATING_SYSTEM.OIL_RANGE_TWIN)
    @_fieldTitle = StringEnum.GetEnumTitle()
    @_primaryHeatingTypeTitle1 = "\\PrimaryHeating1\\" + StringEnum.GetEnumTitle()
    @_primaryHeatingTypeTitle2 = "\\PrimaryHeating2\\" + StringEnum.GetEnumTitle()
    @_primaryHeatingFuelTitle1 = "\\PrimaryHeating1\\" + StringEnum.GetEnumTitle()
    @_primaryHeatingFuelTitle2 = "\\PrimaryHeating2\\" + StringEnum.GetEnumTitle()
    @_primarySystemTitle1 = "\\PrimaryHeating1\\" + StringEnum.GetEnumTitle()
    @_primarySystemTitle2 = "\\PrimaryHeating2\\" + StringEnum.GetEnumTitle()
    @_primarySystemSubTypeTitle1 = "\\PrimaryHeating1\\" + StringEnum.GetEnumTitle()
    @_primarySystemSubTypeTitle2 = "\\PrimaryHeating2\\" + StringEnum.GetEnumTitle()
    @_numberOfSystemsTitle = StringEnum.GetEnumTitle()
    @_electricMeterTitle = StringEnum.GetEnumTitle()
    @_notRequired = NotRequiredDataRule.Instance
    @_heatingSystem = ContainedEnum.Create()
  end

  def DoControl()
    PrimaryHeatingType = nil
    Primaryfuel = nil
    SystemType = nil
    SystemSubType = nil
    electricMeter = nil
    systemIndex = 1
    dHWOnly = false
    if _connectedFields.ContainsKey(@_electricMeterTitle) then
      electricMeter = _connectedFields[@_electricMeterTitle].AsInt
    end
    if self.@FullName.Contains("\\PrimaryHeating1\\") then
      systemIndex = 1
      if _connectedFields.ContainsKey(@_primaryHeatingTypeTitle1) then
        PrimaryHeatingType = _connectedFields[@_primaryHeatingTypeTitle1].AsInt
      end
      if _connectedFields.ContainsKey(@_primaryHeatingFuelTitle1) then
        Primaryfuel = _connectedFields[@_primaryHeatingFuelTitle1].AsInt
      end
      if _connectedFields.ContainsKey(@_primarySystemTitle1) then
        SystemType = _connectedFields[@_primarySystemTitle1].AsInt
      end
      if _connectedFields.ContainsKey(@_primarySystemSubTypeTitle1) then
        SystemSubType = _connectedFields[@_primarySystemSubTypeTitle1].AsInt
      end
    elsif self.@FullName.Contains("\\PrimaryHeating2\\") then
      systemIndex = 2
      if _connectedFields.ContainsKey(@_primaryHeatingTypeTitle2) then
        PrimaryHeatingType = _connectedFields[@_primaryHeatingTypeTitle2].AsInt
      end
      if _connectedFields.ContainsKey(@_primaryHeatingFuelTitle2) then
        Primaryfuel = _connectedFields[@_primaryHeatingFuelTitle2].AsInt
      end
      if _connectedFields.ContainsKey(@_primarySystemTitle2) then
        SystemType = _connectedFields[@_primarySystemTitle2].AsInt
      end
      if _connectedFields.ContainsKey(@_primarySystemSubTypeTitle2) then
        SystemSubType = _connectedFields[@_primarySystemSubTypeTitle2].AsInt
      end
    end
    if _connectedFields.ContainsKey(@_numberOfSystemsTitle) and systemIndex == 2 then
      numberOfSystems = _connectedFields[@_numberOfSystemsTitle].AsInt
      if numberOfSystems.HasValue and numberOfSystems == NUMBER_PRIMARY_SYSTEMS.NMS_ONE_DHW then
        dHWOnly = true
      end
    end
    self.DoControlForSystem(PrimaryHeatingType, Primaryfuel, SystemType, SystemSubType, electricMeter, dHWOnly)
  end

  def SetCentralHeatingSystem(PrimaryHeatingType, Primaryfuel, SystemType, electricMeter, SystemSubType)
    if Primaryfuel.HasValue then
      case Primaryfuel
        when HEATSYS_FUEL.HSFUEL_OIL, HEATSYS_FUEL.HSFUEL_B30K
          if SystemSubType.HasValue then
            @_heatingSystem.SetAvailability(self.GetSubSystemEnumerator(SystemSubType), true, false)
          else
            @_heatingSystem.SetAvailability(@_centralHeatedOilOptions, true, false)
          end
        when HEATSYS_FUEL.HSFUEL_ELECTRIC
          if electricMeter.HasValue and (electricMeter.Value == ELECTRIC_METER.EM_DOUBLE or electricMeter.Value == ELECTRIC_METER.EM_24HOUR or electricMeter.Value == ELECTRIC_METER.EM_UNKNOWN) then
            @_heatingSystem.SetAvailability(@_centralHeatedElectricOptions, true, false)
          else
            @_heatingSystem.SetAvailability(@_centralHeatedElectricWithSingleMeterOptions, true, false)
          end
        when HEATSYS_FUEL.HSFUEL_COAL, HEATSYS_FUEL.HSFUEL_ANTHRACITE, HEATSYS_FUEL.HSFUEL_SOLID_MULTIF, HEATSYS_FUEL.HSFUEL_WOODLOGS, HEATSYS_FUEL.HSFUEL_SMOKELESS, HEATSYS_FUEL.HSFUEL_WOODCHIPS, HEATSYS_FUEL.HSFUEL_WOODPELLETS
          @_heatingSystem.SetAvailability(@_centralheatedSolidFuleOptions, true, false)
        when HEATSYS_FUEL.HSFUEL_MAINSGAS, HEATSYS_FUEL.HSFUEL_LPG_BOTTLE, HEATSYS_FUEL.HSFUEL_LPG_BULK, HEATSYS_FUEL.HSFUEL_LPG_SPECIAL18
          if SystemSubType.HasValue then
            systems = self.GetSubSystemEnumerator(SystemSubType)
            if systems != nil then
              @_heatingSystem.SetAvailability(systems, true, false)
            end
          else
            @_heatingSystem.SetAvailability(@_heatingSystem.All, false)
            @_heatingSystem.SetAvailability(self.GetSubSystemEnumerator(HEATING_SYSTEM_SUB_TYPE.HSMT_GasBoilers1998OrLater), true)
            @_heatingSystem.SetAvailability(self.GetSubSystemEnumerator(HEATING_SYSTEM_SUB_TYPE.HSMT_GasBoilersPre1998WithBalancedOrOpenFlue), true)
            @_heatingSystem.SetAvailability(self.GetSubSystemEnumerator(HEATING_SYSTEM_SUB_TYPE.HSMT_GasBoilersPre1998WithFanAssistedFlue), true)
            @_heatingSystem.SetAvailability(self.GetSubSystemEnumerator(HEATING_SYSTEM_SUB_TYPE.HSMT_CPSU), true)
            @_heatingSystem.SetAvailability(self.GetSubSystemEnumerator(HEATING_SYSTEM_SUB_TYPE.HSMT_GasRangeCookerBoilers), true)
          end
        else
          @_heatingSystem.SetAvailability(List[HEATING_SYSTEM].new(HEATING_SYSTEM.UNKNOWN), true, false)
      end
    else
      @_heatingSystem.SetAvailability(List[HEATING_SYSTEM].new(HEATING_SYSTEM.OIL_POST97_STANDARD, HEATING_SYSTEM.OIL_PRE98_STANDARD, HEATING_SYSTEM.OIL_CONDENSING, HEATING_SYSTEM.OIL_PRE98_COMBI, HEATING_SYSTEM.OIL_POST97_COMBI, HEATING_SYSTEM.OIL_CONDENSING_COMBI, HEATING_SYSTEM.OIL_PRE00_BACK, HEATING_SYSTEM.OIL_POST99_BACK, HEATING_SYSTEM.OIL_RANGE_SINGLE, HEATING_SYSTEM.OIL_RANGE_TWIN, HEATING_SYSTEM.ELEC_DIRECT_BOILER, HEATING_SYSTEM.ELEC_CPSU, HEATING_SYSTEM.ELEC_DRYCORE_STORAGE, HEATING_SYSTEM.ELEC_WATER_STORAGE, HEATING_SYSTEM.SOLID_MANUAL, HEATING_SYSTEM.SOLID_AUTO, HEATING_SYSTEM.SOLID_OPEN_BACK, HEATING_SYSTEM.SOLID_CLOSED_BACK, HEATING_SYSTEM.SOLID_RANGE_COOKER, HEATING_SYSTEM.GAS_POST97_AUTO, HEATING_SYSTEM.GAS_POST97_COMBI_AUTO, HEATING_SYSTEM.GAS_POST97_CONDENSING, HEATING_SYSTEM.GAS_POST97_CONDENSING_COMBI, HEATING_SYSTEM.GAS_POST97_PILOT, HEATING_SYSTEM.GAS_POST97_COMBI_PILOT, HEATING_SYSTEM.GAS_POST97_BACK, HEATING_SYSTEM.GAS_FAN_PRE98, HEATING_SYSTEM.GAS_FAN_PRE98_COMBI, HEATING_SYSTEM.GAS_FAN_PRE98_CONDENSING, HEATING_SYSTEM.GAS_FAN_PRE98_CONDENSING_COMBI, HEATING_SYSTEM.GAS_PRE98_WALL, HEATING_SYSTEM.GAS_PRE98_FLOOR_OLD, HEATING_SYSTEM.GAS_PRE98_FLOOR, HEATING_SYSTEM.GAS_PRE98_COMBI, HEATING_SYSTEM.GAS_PRE98_BACK, HEATING_SYSTEM.GAS_CPSU_NORMAL, HEATING_SYSTEM.GAS_CPSU_CONDENSING, HEATING_SYSTEM.GAS_RANGE_SINGLE, HEATING_SYSTEM.GAS_RANGE_SINGLE_AUTO, HEATING_SYSTEM.GAS_RANGE_TWIN), true, false)
      if electricMeter.HasValue and (electricMeter.Value == ELECTRIC_METER.EM_DOUBLE or electricMeter.Value == ELECTRIC_METER.EM_24HOUR or electricMeter.Value == ELECTRIC_METER.EM_UNKNOWN) then
        @_heatingSystem.SetAvailability(@_centralHeatedElectricOptions, false)
        @_heatingSystem.SetAvailability(@_centralHeatedElectricWithSingleMeterOptions, true)
      end
    end
  end

  def SetRoomHeaterSystem(PrimaryHeatingType, Primaryfuel, SystemType, SystemSubType, dHWOnly)
    if Primaryfuel.HasValue then
      case Primaryfuel
        when HEATSYS_FUEL.HSFUEL_OIL, HEATSYS_FUEL.HSFUEL_B30K
          if not dHWOnly then
            @_heatingSystem.SetAvailability(@_roomHeatersOilOptions, true, false)
          else
            @_heatingSystem.SetAvailability(@_roomHeatersOilOptionsBackBoilers, true, false)
          end
        when HEATSYS_FUEL.HSFUEL_ELECTRIC
          if not dHWOnly then
            @_heatingSystem.SetAvailability(@_roomHeatersElectricOptions, true, false)
          end
        when HEATSYS_FUEL.HSFUEL_COAL, HEATSYS_FUEL.HSFUEL_ANTHRACITE, HEATSYS_FUEL.HSFUEL_SOLID_MULTIF, HEATSYS_FUEL.HSFUEL_WOODLOGS, HEATSYS_FUEL.HSFUEL_WOODPELLETS, HEATSYS_FUEL.HSFUEL_WOODCHIPS, HEATSYS_FUEL.HSFUEL_SMOKELESS
          if not dHWOnly then
            @_heatingSystem.SetAvailability(@_roomHeatersSolidOptions, true, false)
          else
            @_heatingSystem.SetAvailability(@_roomHeatersSolidOptionsBackBoiler, true, false)
          end
        when HEATSYS_FUEL.HSFUEL_MAINSGAS, HEATSYS_FUEL.HSFUEL_LPG_BOTTLE, HEATSYS_FUEL.HSFUEL_LPG_BULK, HEATSYS_FUEL.HSFUEL_LPG_SPECIAL18
          if SystemSubType.HasValue then
            SubTypeDrivenOptions = ContainedEnum.Create()
            SubTypeDrivenOptions.SetAvailability(@_roomHeatersGasOptions, true, false)
            case SystemSubType
              when HEATING_SYSTEM_SUB_TYPE.HSMT_RoomHeatersBalancedflue
                @_heatingSystem.SetAvailability(@_roomHeatersGasBalancedFlueOptions, true, false)
              when HEATING_SYSTEM_SUB_TYPE.HSMT_RoomHeatersOpenflue
                if not dHWOnly then
                  @_heatingSystem.SetAvailability(@_roomHeatersGasOpenFlueOptions, true, false)
                else
                  @_heatingSystem.SetAvailability(@_roomHeatersGasOpenFlueOptionsBackBoiler, true, false)
                end
              when HEATING_SYSTEM_SUB_TYPE.HSMT_RoomHeatersChimney
                @_heatingSystem.SetAvailability(@_roomHeatersGasChimneyOptions, true, false)
              when HEATING_SYSTEM_SUB_TYPE.HSMT_RoomHeatersFlueless
                @_heatingSystem.SetAvailability(@_roomHeatersGasFluelessOptions, true, false)
            end
          else
            if not dHWOnly then
              @_heatingSystem.SetAvailability(@_roomHeatersGasOptions, true, false)
            else
              @_heatingSystem.SetAvailability(@_roomHeatersGasOptionsBackBoiler, true, false)
            end
          end
        else
          @_heatingSystem.SetAvailability(List[HEATING_SYSTEM].new(HEATING_SYSTEM.UNKNOWN), true, false)
      end
    else
      if not dHWOnly then
        @_heatingSystem.SetAvailability(@_heatingSystem.All, false)
        @_heatingSystem.SetAvailability(@_roomHeatersOilOptions, true)
        @_heatingSystem.SetAvailability(@_roomHeatersElectricOptions, true)
        @_heatingSystem.SetAvailability(@_roomHeatersGasOptions, true)
        @_heatingSystem.SetAvailability(@_roomHeatersSolidOptions, true)
      else
        @_heatingSystem.SetAvailability(@_heatingSystem.All, false)
        @_heatingSystem.SetAvailability(@_roomHeatersOilOptionsBackBoilers, true)
        @_heatingSystem.SetAvailability(@_roomHeatersGasOptionsBackBoiler, true)
        @_heatingSystem.SetAvailability(@_roomHeatersSolidOptionsBackBoiler, true)
      end
    end
  end

  def SetWarmAirSystem(PrimaryHeatingType, Primaryfuel, SystemType, SystemSubType)
    if Primaryfuel.HasValue then
      case Primaryfuel
        when HEATSYS_FUEL.HSFUEL_OIL, HEATSYS_FUEL.HSFUEL_B30K
          @_heatingSystem.SetAvailability(List[HEATING_SYSTEM].new(HEATING_SYSTEM.OIL_WARMAIR), true, false)
        when HEATSYS_FUEL.HSFUEL_ELECTRIC
          @_heatingSystem.SetAvailability(List[HEATING_SYSTEM].new(HEATING_SYSTEM.ELEC_ELECTRICAIRE_SYSTEM), true, false)
        when HEATSYS_FUEL.HSFUEL_MAINSGAS, HEATSYS_FUEL.HSFUEL_LPG_BOTTLE, HEATSYS_FUEL.HSFUEL_LPG_BULK, HEATSYS_FUEL.HSFUEL_LPG_SPECIAL18
          @_heatingSystem.SetAvailability(List[HEATING_SYSTEM].new(HEATING_SYSTEM.GAS_WARMAIR_PRE98, HEATING_SYSTEM.GAS_WARMAIR_POST97, HEATING_SYSTEM.GAS_WARMAIR_HEAT_RECOVERY, HEATING_SYSTEM.GAS_WARMAIR_CONDENSING), true, false)
        else
          @_heatingSystem.SetAvailability(List[HEATING_SYSTEM].new(HEATING_SYSTEM.UNKNOWN), true, false)
      end
    else
      @_heatingSystem.SetAvailability(List[HEATING_SYSTEM].new(HEATING_SYSTEM.OIL_WARMAIR, HEATING_SYSTEM.ELEC_ELECTRICAIRE_SYSTEM, HEATING_SYSTEM.GAS_WARMAIR_PRE98, HEATING_SYSTEM.GAS_WARMAIR_POST97, HEATING_SYSTEM.GAS_WARMAIR_HEAT_RECOVERY, HEATING_SYSTEM.GAS_WARMAIR_CONDENSING), true, false)
    end
  end

  def DoControlForSystem(PrimaryHeatingType, Primaryfuel, SystemType, SystemSubType, electricMeter, dHWOnly)
    if PrimaryHeatingType.HasValue and SystemType.HasValue and SystemType == PRIMARY_SYSTEM_TYPE.PST_SAP then
      case PrimaryHeatingType
        when HEATING_TYPE.CENTRAL_HEATING
          self.SetCentralHeatingSystem(PrimaryHeatingType, Primaryfuel, SystemType, electricMeter, SystemSubType)
        when HEATING_TYPE.COMMUNITY_HEATING
          @_heatingSystem.SetAvailability(List[HEATING_SYSTEM].new(HEATING_SYSTEM.COMMUMITY_HEATING_BOILERS, HEATING_SYSTEM.COMMUNITY_HEATING_BOILERS_CHP, HEATING_SYSTEM.COMMUNITY_HEATING_HEATPUMP), true, false)
        when HEATING_TYPE.ELECTRIC_STORAGE
          if electricMeter.HasValue and electricMeter.Value == ELECTRIC_METER.EM_SINGLE then
            @_heatingSystem.SetAvailability(List[HEATING_SYSTEM].new(HEATING_SYSTEM.ELEC_LARGE_STORAGE_HEATERS), true, false)
          else
            @_heatingSystem.SetAvailability(List[HEATING_SYSTEM].new(HEATING_SYSTEM.ELEC_LARGE_STORAGE_HEATERS, HEATING_SYSTEM.ELEC_FAN_STORAGE_HEATERS, HEATING_SYSTEM.ELEC_INTEGRATED_HEATERS, HEATING_SYSTEM.ELEC_SLIMLINE_STORAGE_HEATERS), true, false)
          end
        when HEATING_TYPE.ELECTRIC_UNDERFLOOR
          if electricMeter.HasValue and electricMeter.Value == ELECTRIC_METER.EM_SINGLE then
            @_heatingSystem.SetAvailability(List[HEATING_SYSTEM].new(HEATING_SYSTEM.ELEC_UNDERFLOOR_DIRECT), true, false)
          else
            @_heatingSystem.SetAvailability(List[HEATING_SYSTEM].new(HEATING_SYSTEM.ELEC_UNDERFLOOR_OFFPEAK, HEATING_SYSTEM.ELEC_UNDERFLOOR_COMBINED, HEATING_SYSTEM.ELEC_UNDERFLOOR_DIRECT), true, false)
          end
        when HEATING_TYPE.HEAT_PUMPS
          @_heatingSystem.SetAvailability(List[HEATING_SYSTEM].new(HEATING_SYSTEM.ELEC_GROUND_HEATPUMP, HEATING_SYSTEM.ELEC_GROUND_HEATPUMP_AUX_HEATER, HEATING_SYSTEM.ELEC_WATER_HEATPUMP, HEATING_SYSTEM.ELEC_AIR_HEATPUMP), true, false)
        when HEATING_TYPE.OTHER_HEATING
          @_heatingSystem.SetAvailability(List[HEATING_SYSTEM].new(HEATING_SYSTEM.ELEC_CEILING_HEATING), true, false)
        when HEATING_TYPE.ROOM_HEATERS
          self.SetRoomHeaterSystem(PrimaryHeatingType, Primaryfuel, SystemType, SystemSubType, dHWOnly)
        when HEATING_TYPE.WARM_AIR
          self.SetWarmAirSystem(PrimaryHeatingType, Primaryfuel, SystemType, SystemSubType)
        when HEATING_TYPE.WARM_AIR_HEAT_PUMP
          @_heatingSystem.SetAvailability(List[HEATING_SYSTEM].new(HEATING_SYSTEM.ELEC_GROUND_AIR_HEATPUMP, HEATING_SYSTEM.ELEC_GROUND_AIR_HEATPUMP_AUX, HEATING_SYSTEM.ELEC_WATER_AIR_HEATPUMP, HEATING_SYSTEM.ELEC_AIR_AIR_HEATPUMP), true, false)
      end
      _ruleManager.SetRule(DiscreteDataRule[HEATING_SYSTEM].new(@_heatingSystem))
    elsif SystemType.HasValue and SystemType == PRIMARY_SYSTEM_TYPE.PST_NONE then
      @_heatingSystem.SetAvailability(@_heatingSystem.All, false)
      @_heatingSystem.SetAvailability(HEATING_SYSTEM.NO_HEATING_SYSTEM, true)
      _ruleManager.SetRule(DiscreteDataRule[HEATING_SYSTEM].new(@_heatingSystem))
    else
      _ruleManager.SetRule(@_notRequired)
    end
  end

  def GetSubSystemEnumerator(SubSystem)
    case SubSystem
      when HEATING_SYSTEM_SUB_TYPE.HSMT_GasBoilers1998OrLater
        return @_centralHeatedGasOptions1998OrLater
      when HEATING_SYSTEM_SUB_TYPE.HSMT_GasBoilersPre1998WithBalancedOrOpenFlue
        return @_centralHeatedGasOptionsPre1998BalancedOrOpenFlue
      when HEATING_SYSTEM_SUB_TYPE.HSMT_GasBoilersPre1998WithFanAssistedFlue
        return @_centralHeatedGasOptionsPre1998FanAssistedFlue
      when HEATING_SYSTEM_SUB_TYPE.HSMT_CPSU
        return @_centralHeatedGasOptionsCPSU
      when HEATING_SYSTEM_SUB_TYPE.HSMT_GasRangeCookerBoilers
        return @_centralHeatedGasOptionsRangeCookers
      when HEATING_SYSTEM_SUB_TYPE.HSMT_OilBoilersCombi
        return @_centralHeatedOilCombiOptions
      when HEATING_SYSTEM_SUB_TYPE.HSMT_OilBoilersNonCombi
        return @_centralHeatedOilNonCombiOptions
      when HEATING_SYSTEM_SUB_TYPE.HSMT_OilRangeCookerBoilers
        return @_centralHeatedOilRangeOptions
    end
    return nil
  end
end
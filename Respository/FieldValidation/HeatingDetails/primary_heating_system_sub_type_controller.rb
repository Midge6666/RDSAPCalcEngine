class PrimaryHeatingSystemSubTypeController < FieldController
  def initialize()
    @_fieldTitle = StringEnum.GetEnumTitle()
    @_primarySystemTitle = StringEnum.GetEnumTitle()
    @_primaryHeatingTypeTitle = StringEnum.GetEnumTitle()
    @_primaryHeatingFuelTitle = StringEnum.GetEnumTitle()
    @_numberOfSystemsTitle = StringEnum.GetEnumTitle()
    @_centalHeatingGasSubTypes = List[HEATING_SYSTEM_SUB_TYPE].new(HEATING_SYSTEM_SUB_TYPE.HSMT_CPSU, HEATING_SYSTEM_SUB_TYPE.HSMT_GasBoilers1998OrLater, HEATING_SYSTEM_SUB_TYPE.HSMT_GasBoilersPre1998WithBalancedOrOpenFlue, HEATING_SYSTEM_SUB_TYPE.HSMT_GasBoilersPre1998WithFanAssistedFlue, HEATING_SYSTEM_SUB_TYPE.HSMT_GasRangeCookerBoilers)
    @_centalHeatingOilSubTypes = List[HEATING_SYSTEM_SUB_TYPE].new(HEATING_SYSTEM_SUB_TYPE.HSMT_OilBoilersCombi, HEATING_SYSTEM_SUB_TYPE.HSMT_OilBoilersNonCombi, HEATING_SYSTEM_SUB_TYPE.HSMT_OilRangeCookerBoilers)
    @_roomHeatersSubTypes = List[HEATING_SYSTEM_SUB_TYPE].new(HEATING_SYSTEM_SUB_TYPE.HSMT_RoomHeatersOpenflue, HEATING_SYSTEM_SUB_TYPE.HSMT_RoomHeatersBalancedflue, HEATING_SYSTEM_SUB_TYPE.HSMT_RoomHeatersChimney, HEATING_SYSTEM_SUB_TYPE.HSMT_RoomHeatersFlueless)
    @_subTypeOptions = ContainedEnum.Create()
  end

  def DoControl()
    SystemType = nil
    if _connectedFields.ContainsKey(@_primarySystemTitle) then
      SystemType = _connectedFields[@_primarySystemTitle].AsInt
    end
    PrimaryHeatingType = nil
    if _connectedFields.ContainsKey(@_primaryHeatingTypeTitle) then
      PrimaryHeatingType = _connectedFields[@_primaryHeatingTypeTitle].AsInt
    end
    PrimaryHeatingFuel = nil
    if _connectedFields.ContainsKey(@_primaryHeatingFuelTitle) then
      PrimaryHeatingFuel = _connectedFields[@_primaryHeatingFuelTitle].AsInt
    end
    dHWOnly = false
    if _connectedFields.ContainsKey(@_numberOfSystemsTitle) and self.@FullName.Contains("\\PrimaryHeating2\\") then
      numberOfSystems = _connectedFields[@_numberOfSystemsTitle].AsInt
      if numberOfSystems.HasValue and numberOfSystems == NUMBER_PRIMARY_SYSTEMS.NMS_ONE_DHW then
        dHWOnly = true
      end
    end
    if PrimaryHeatingType.HasValue and PrimaryHeatingFuel.HasValue and SystemType.HasValue and SystemType == PRIMARY_SYSTEM_TYPE.PST_SAP then
      case PrimaryHeatingType
        when HEATING_TYPE.CENTRAL_HEATING
          if PrimaryHeatingFuel.HasValue then
            case PrimaryHeatingFuel
              when HEATSYS_FUEL.HSFUEL_MAINSGAS, HEATSYS_FUEL.HSFUEL_LPG_BULK, HEATSYS_FUEL.HSFUEL_LPG_BOTTLE, HEATSYS_FUEL.HSFUEL_LPG_SPECIAL18
                @_subTypeOptions.SetAvailability(@_centalHeatingGasSubTypes, true, false)
              when HEATSYS_FUEL.HSFUEL_OIL, HEATSYS_FUEL.HSFUEL_B30K
                @_subTypeOptions.SetAvailability(@_centalHeatingOilSubTypes, true, false)
              else
                @_subTypeOptions.SetAvailability(@_subTypeOptions.All, false)
            end
          else
            @_subTypeOptions.SetAvailability(@_subTypeOptions.All, false)
            @_subTypeOptions.SetAvailability(@_centalHeatingGasSubTypes, true)
            @_subTypeOptions.SetAvailability(@_centalHeatingOilSubTypes, true)
          end
        when HEATING_TYPE.ROOM_HEATERS
          if PrimaryHeatingFuel.HasValue and (PrimaryHeatingFuel == HEATSYS_FUEL.HSFUEL_MAINSGAS) or PrimaryHeatingFuel == HEATSYS_FUEL.HSFUEL_LPG_BULK or PrimaryHeatingFuel == HEATSYS_FUEL.HSFUEL_LPG_BOTTLE then
            if not dHWOnly then
              @_subTypeOptions.SetAvailability(@_roomHeatersSubTypes, true, false)
            else
              @_subTypeOptions.SetAvailability(@_subTypeOptions.All, false)
              @_subTypeOptions.SetAvailability(HEATING_SYSTEM_SUB_TYPE.HSMT_RoomHeatersOpenflue, true)
            end
          else
            @_subTypeOptions.SetAvailability(@_subTypeOptions.All, false)
          end
        when HEATING_TYPE.COMMUNITY_HEATING, HEATING_TYPE.ELECTRIC_STORAGE, HEATING_TYPE.ELECTRIC_UNDERFLOOR, HEATING_TYPE.WARM_AIR, HEATING_TYPE.WARM_AIR_HEAT_PUMP, HEATING_TYPE.OTHER_HEATING, HEATING_TYPE.HEAT_PUMPS
          @_subTypeOptions.SetAvailability(@_subTypeOptions.All, false)
      end
      if @_subTypeOptions.Available.Count() > 0 then
        _ruleManager.SetRule(DiscreteDataRule[HEATING_SYSTEM_SUB_TYPE].new(@_subTypeOptions))
      else
        _ruleManager.SetRule(NotRequiredDataRule.Instance)
      end
    else
      _ruleManager.SetRule(NotRequiredDataRule.Instance)
    end
  end
end
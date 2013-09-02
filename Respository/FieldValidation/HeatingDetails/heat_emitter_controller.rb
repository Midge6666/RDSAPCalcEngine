class HeatEmitterController < FieldController
  def initialize()
    #this field is not required for 2nd system if its DHW only
    # already all set to false
    @_heatingSystemTitle = StringEnum.GetEnumTitle()
    @_primaryHeatingTypeTitle = StringEnum.GetEnumTitle()
    @_fuelTitle = StringEnum.GetEnumTitle()
    @_primaryHeatingSystemTitle = StringEnum.GetEnumTitle()
    @_sedbukIndex = "SedbukBoilerIndex"
    @_emitters = ContainedEnum.Create()
    @_numOfSystemsTitle = StringEnum.GetEnumTitle()
  end

  def DoControl()
    if _connectedFields.Count <= 1 then
      _ruleManager.SetRule(NotRequiredDataRule.Instance)
      return
    end
    numberOfSystems = _connectedFields[@_numOfSystemsTitle].AsInt
    @_emitters.SetAvailability(@_emitters.All, false)
    if (self.@FullName.Contains("\\PrimaryHeating2\\")) and ((numberOfSystems.HasValue) and (numberOfSystems == NUMBER_PRIMARY_SYSTEMS.NMS_ONE_DHW)) then
      self.Clear()
      _ruleManager.SetRule(NotRequiredDataRule.Instance)
      return
    end
    heatingSystem = _connectedFields[@_heatingSystemTitle].AsInt
    primaryHeatingType = _connectedFields[@_primaryHeatingTypeTitle].AsInt
    fuel = _connectedFields[@_fuelTitle].AsInt
    primarySystemType = _connectedFields[@_primaryHeatingSystemTitle].AsInt
    sedbukIndex = _connectedFields[@_sedbukIndex].Value
    if (heatingSystem.HasValue) and (primaryHeatingType.HasValue) then
      case primaryHeatingType
        when HEATING_TYPE.HEAT_PUMPS
          if heatingSystem == PRIMARY_SYSTEM_TYPE.PST_SEDBUK then
            boiler = SedbukAccess.GetBoilerByIndex(sedbukIndex)
            if (boiler != nil) and (boiler) then
              heatPump = boiler
              if heatPump.F13_emitter_type == "1" then
                @_emitters.SetAvailability(EMITTER_TYPE.ET_RADIATORS, true)
              elsif heatPump.F13_emitter_type == "3" then
                @_emitters.SetAvailability(EMITTER_TYPE.ET_UNDERFLOOR_ELEMENTS, true)
              elsif heatPump.F13_emitter_type == "2" then
                @_emitters.SetAvailability(EMITTER_TYPE.ET_FANCOIL_UNITS, true)
              end
            end
          else
            @_emitters.SetAvailability(EMITTER_TYPE.ET_RADIATORS, true)
            @_emitters.SetAvailability(EMITTER_TYPE.ET_UNDERFLOOR_ELEMENTS, true)
            @_emitters.SetAvailability(EMITTER_TYPE.ET_FANCOIL_UNITS, true)
          end
          break
        when HEATING_TYPE.MICRO_COGENERATION, HEATING_TYPE.CENTRAL_HEATING
          @_emitters.SetAvailability(EMITTER_TYPE.ET_RADIATORS, true)
          if primarySystemType.HasValue and primarySystemType == HEATING_SYSTEM.ELEC_CPSU then
            @_emitters.SetAvailability(EMITTER_TYPE.ET_UNDERFLOOR_ELEMENTS, true)
          elsif fuel.HasValue and (fuel == HEATSYS_FUEL.HSFUEL_MAINSGAS or fuel == HEATSYS_FUEL.HSFUEL_OIL or fuel == HEATSYS_FUEL.HSFUEL_LPG_BOTTLE or fuel == HEATSYS_FUEL.HSFUEL_LPG_BULK or fuel == HEATSYS_FUEL.HSFUEL_ANTHRACITE or fuel == HEATSYS_FUEL.HSFUEL_ELECTRIC) then
            @_emitters.SetAvailability(EMITTER_TYPE.ET_UNDERFLOOR_ELEMENTS, true)
          elsif fuel.HasValue and HeatingMapping.GetFuelCategoryFromType(fuel) == HEATSYS_FUEL_CATEGORY.SOLID then
            @_emitters.SetAvailability(EMITTER_TYPE.ET_UNDERFLOOR_ELEMENTS, false)
          else
            @_emitters.SetAvailability(EMITTER_TYPE.ET_UNDERFLOOR_ELEMENTS, true)
          end
          break
        when HEATING_TYPE.ELECTRIC_UNDERFLOOR
          @_emitters.SetAvailability(EMITTER_TYPE.ET_UNDERFLOOR_ELEMENTS, true)
          break
        else
          break
      end
    end
    if @_emitters.Available.Count() == 0 then
      _ruleManager.SetRule(NotRequiredDataRule.Instance)
    else
      _ruleManager.SetRule(DiscreteDataRule[EMITTER_TYPE].new(@_emitters))
    end
  end
end
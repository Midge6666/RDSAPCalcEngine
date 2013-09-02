class SedbukfuelController < FieldController
  def initialize()
    @_fuels = ContainedEnum.Create()
    @_fieldTitle = StringEnum.GetEnumTitle()
    @_mainsGasTitle = "MainsGas"
    @_heatingSystemTitle = StringEnum.GetEnumTitle()
  end

  def DoControl()
    HeatingSystem = _connectedFields[@_heatingSystemTitle].AsInt
    GasAvailable = _connectedFields[@_mainsGasTitle].AsInt
    if HeatingSystem.HasValue and HeatingSystem == PRIMARY_SYSTEM_TYPE.PST_SEDBUK then
      if GasAvailable.HasValue and GasAvailable == YESNO.NO then
        @_fuels.SetAvailability(List[SEDBUK_FUEL].new(SEDBUK_FUEL.SF_FUEL_MAINSGAS, SEDBUK_FUEL.SF_FUEL_ALL), false, true)
      else
        @_fuels.SetAvailability(List[SEDBUK_FUEL].new(SEDBUK_FUEL.SF_FUEL_LPG_OIL), false, true)
      end
      _ruleManager.SetRule(DiscreteDataRule[SEDBUK_FUEL].new(@_fuels))
    else
      _ruleManager.SetRule(NotRequiredDataRule.Instance)
    end
  end
end
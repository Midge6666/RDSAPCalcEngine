class SecondaryHeatingFuelController < FieldController
  def initialize()
    # There's an extra check required for mains gas.  If there are no mains gas then rmeove it form the list even if system type said it should be available
    @_fieldTitle = "Secondary" + StringEnum.GetEnumTitle()
    @_mainsGasTitle = "MainsGas"
    @_secondaryHeatingPresentTitle = "SecondarySystemPresent"
    @_notRequired = NotRequiredDataRule.Instance
    @_Fuel = ContainedEnum.Create()
  end

  def DoControl()
    current = _connectedFields[@_secondaryHeatingPresentTitle].AsInt
    if current.HasValue and current == YESNO.YES then
      @_Fuel.SetAvailability(List[HEATSYS_FUEL].new(HEATSYS_FUEL.HSFUEL_COAL, HEATSYS_FUEL.HSFUEL_ANTHRACITE, HEATSYS_FUEL.HSFUEL_SMOKELESS, HEATSYS_FUEL.HSFUEL_WOODLOGS, HEATSYS_FUEL.HSFUEL_WOODPELLETS, HEATSYS_FUEL.HSFUEL_WOODCHIPS, HEATSYS_FUEL.HSFUEL_SOLID_MULTIF, HEATSYS_FUEL.HSFUEL_ELECTRIC, HEATSYS_FUEL.HSFUEL_MAINSGAS, HEATSYS_FUEL.HSFUEL_LPG_BULK, HEATSYS_FUEL.HSFUEL_LPG_SPECIAL18, HEATSYS_FUEL.HSFUEL_LPG_BOTTLE, HEATSYS_FUEL.HSFUEL_OIL, HEATSYS_FUEL.HSFUEL_B30K, HEATSYS_FUEL.HSFUEL_BIOETHANOL_SECONDARY), true, false)
      gas = _connectedFields[@_mainsGasTitle].AsInt
      if gas.HasValue and gas == YESNO.NO then
        @_Fuel.SetAvailability(HEATSYS_FUEL.HSFUEL_MAINSGAS, false)
      end
      _ruleManager.SetRule(DiscreteDataRule[HEATSYS_FUEL].new(@_Fuel))
    else
      _ruleManager.SetRule(@_notRequired)
    end
  end
end
class ImmersionTypecontroller < FieldController
  def initialize()
    @_fieldTitle = StringEnum.GetEnumTitle()
    @_waterTypeTitle = StringEnum.GetEnumTitle()
    @_immersionOptions = ContainedEnum.Create()
    @_notRequired = NotRequiredDataRule.Instance
  end

  def DoControl()
    WaterHeating = _connectedFields[@_waterTypeTitle].AsInt
    if WaterHeating.HasValue and WaterHeating == WATER_TYPE.WHTYPE_IMMERSION then
      _ruleManager.SetRule(DiscreteDataRule[IMMERSION_TYPE].new(@_immersionOptions))
    else
      _ruleManager.SetRule(@_notRequired)
    end
  end
end
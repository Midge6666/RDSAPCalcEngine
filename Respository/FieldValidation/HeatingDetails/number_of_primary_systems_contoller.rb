class NumberOfPrimarySystemsController < FieldController
  def initialize()
    @_fieldTitle = StringEnum.GetEnumTitle()
  end

  def DoControl()
    if _ruleManager.ActiveRules.Count == 0 then
      _ruleManager.SetRule(DiscreteDataRule[NUMBER_PRIMARY_SYSTEMS].new(ContainedEnum.Create()))
    end
  end
end
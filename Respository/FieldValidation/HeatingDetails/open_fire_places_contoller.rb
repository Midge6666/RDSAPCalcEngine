class OpenFirePlacesController < FieldController
  def initialize()
    @_theRule = ConstrainedValueDataRule[System::Int32].new(0, 100)
  end

  def CheckValidityAgainstRule(rule, reasonForFailure)
    return (rule.IsValid(AsInt, reasonForFailure))
  end

  def DoControl()
    if _ruleManager.ActiveRules.Count == 0 then
      _ruleManager.SetRule(@_theRule)
    end
  end
end
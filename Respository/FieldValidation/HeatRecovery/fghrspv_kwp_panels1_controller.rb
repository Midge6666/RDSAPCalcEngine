class FGHRSPVKwpPanels1Controller < FieldController
  def initialize()
    @_constrainedValuesRule = ConstrainedValueDataRule[System::Nullable].new(0.2f, 10.0f)
  end

  def CheckValidityAgainstRule(rule, reasonForFailure)
    return (rule.IsValid(AsFloat, reasonForFailure))
  end

  def DoControl()
    if _ruleManager.ActiveRules.Count == 0 then
      _ruleManager.SetRule(@_constrainedValuesRule)
    end
  end
end
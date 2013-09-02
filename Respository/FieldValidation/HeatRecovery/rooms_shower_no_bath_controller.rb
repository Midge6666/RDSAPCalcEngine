class RoomsShowerNoBathController < FieldController
  def initialize()
    @_fieldTitle = "RoomsWithMixerShowerNoBath"
  end

  def CheckValidityAgainstRule(rule, reasonForFailure)
    return (rule.IsValid(AsInt, reasonForFailure))
  end

  def DoControl()
    if _ruleManager.ActiveRules.Count == 0 then
      _ruleManager.SetRule(ConstrainedValueDataRule[System::Nullable].new(0, 99))
    end
  end
end
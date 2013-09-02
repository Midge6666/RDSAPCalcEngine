class ShowerWWHRSNoBath1Controller < FieldController
  def initialize()
    @_fieldTitle = "MixerShowersWithWWHRSWithoutBath1"
    @_relatedFieldTitle = "MixerShowersWithWWHRSWithBath1"
    @_hasWWHRSTitle = StringEnum.GetEnumTitle()
  end

  def CheckValidityAgainstRule(rule, reasonForFailure)
    return (rule.IsValid(AsInt, reasonForFailure))
  end

  def DoControl()
    hasWWHRS = _connectedFields[@_hasWWHRSTitle].AsInt
    withBath = _connectedFields[@_relatedFieldTitle].AsInt
    if hasWWHRS.HasValue then
      if hasWWHRS == HAS_WWHRS.HASWWHRS_ONE or hasWWHRS == HAS_WWHRS.HASWWHRS_TWO then
        if withBath.HasValue and withBath.Value == 0 then
          _ruleManager.SetRule(ConstrainedValueDataRule[System::Int32].new(1, 99))
        else
          _ruleManager.SetRule(ConstrainedValueDataRule[System::Int32].new(0, 99))
        end
      else
        _ruleManager.SetRule(NotRequiredDataRule.Instance)
      end
    else
      _ruleManager.SetRule(NotRequiredDataRule.Instance)
    end
  end
end
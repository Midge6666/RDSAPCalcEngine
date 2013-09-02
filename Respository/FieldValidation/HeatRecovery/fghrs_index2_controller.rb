class FGHRSIndex2Controller < FieldController
  def initialize()
    @_fieldTitle = "FGHRSIndex2"
    @_hasFGHRSTitle = StringEnum.GetEnumTitle()
  end

  def DoControl()
    hasFGHRS = _connectedFields[@_hasFGHRSTitle].AsInt
    if hasFGHRS.HasValue then
      if hasFGHRS == HAS_FGHRS.HASFGHRS_ONE or hasFGHRS == HAS_FGHRS.HASFGHRS_TWO or hasFGHRS == HAS_FGHRS.HASFGHRS_BOTH then
        _ruleManager.SetRule(NotNullDataRule.Instance)
      else
        _ruleManager.SetRule(NotRequiredDataRule.Instance)
      end
    else
      _ruleManager.SetRule(NotRequiredDataRule.Instance)
    end
  end
end
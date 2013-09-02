class WWHRSIndex1Controller < FieldController
  def initialize()
    @_fieldTitle = "WWHRSIndex1"
    @_hasWWHRSTitle = StringEnum.GetEnumTitle()
  end

  def DoControl()
    hasWWHRS = _connectedFields[@_hasWWHRSTitle].AsInt
    if hasWWHRS.HasValue then
      if hasWWHRS == HAS_WWHRS.HASWWHRS_ONE or hasWWHRS == HAS_WWHRS.HASWWHRS_TWO then
        _ruleManager.SetRule(NotNullDataRule.Instance)
      else
        _ruleManager.SetRule(NotRequiredDataRule.Instance)
      end
    else
      _ruleManager.SetRule(NotRequiredDataRule.Instance)
    end
  end
end
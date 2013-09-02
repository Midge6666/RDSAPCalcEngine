class SedbukBoilerIDController < FieldController
  def initialize()
    @_fieldTitle = "SedbukBoilerIndex"
    @_heatingSystemTitle = StringEnum.GetEnumTitle()
  end

  def DoControl()
    HeatingSystem = _connectedFields[@_heatingSystemTitle].AsInt
    if HeatingSystem.HasValue then
      if HeatingSystem == PRIMARY_SYSTEM_TYPE.PST_SEDBUK then
        _ruleManager.SetRule(NotNullDataRule.Instance)
      else
        _ruleManager.SetRule(NotRequiredDataRule.Instance)
      end
    else
      _ruleManager.SetRule(NotRequiredDataRule.Instance)
    end
  end
end
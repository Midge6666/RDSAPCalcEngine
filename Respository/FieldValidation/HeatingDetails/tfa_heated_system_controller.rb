class TFAHeatedSystemAController < FieldController
  def initialize()
    @_primarySystemATFA = "\\PrimaryHeating1\\TFAHeated"
    @_primarySystemBTFA = "\\PrimaryHeating2\\TFAHeated"
    @_primarySystemCount = StringEnum.GetEnumTitle()
  end

  def CheckValidityAgainstRule(rule, reasonForFailure)
    return (rule.IsValid(AsInt, reasonForFailure))
  end

  def DoControl()
    systemBTFAController = EpcDomainController.Singleton[@_primarySystemBTFA]
    systemCount = _connectedFields[@_primarySystemCount].AsInt
    if (systemCount.HasValue) and (systemCount.Value == NUMBER_PRIMARY_SYSTEMS.NMS_TWO) then
      @_theRule = ConstrainedValueDataRule[System::Int32].new(1, 100)
      _ruleManager.SetRule(@_theRule)
      if (systemBTFAController != nil) and (systemBTFAController.AsInt.HasValue) then
        primaryAValue = 100 - systemBTFAController.AsInt.Value
        update = UpdateFieldCommand.new(@_primarySystemATFA, primaryAValue)
        EpcDomainController.Singleton.Execute(update)
      end
    elsif (systemCount.HasValue) and (systemCount.Value == NUMBER_PRIMARY_SYSTEMS.NMS_ONE_DHW) then
      @_theRule = ConstrainedValueDataRule[System::Int32].new(0, 100)
      _ruleManager.SetRule(@_theRule)
      update = UpdateFieldCommand.new(@_primarySystemATFA, 100)
      EpcDomainController.Singleton.Execute(update)
      update = UpdateFieldCommand.new(@_primarySystemBTFA, 0)
      EpcDomainController.Singleton.Execute(update)
    else
      @_theRule = ConstrainedValueDataRule[System::Int32].new(1, 100)
      _ruleManager.SetRule(@_theRule)
      update = UpdateFieldCommand.new(@_primarySystemATFA, 100)
      EpcDomainController.Singleton.Execute(update)
    end
  end
end
class ElectricityMeterController < FieldController
  def initialize()
    @_fieldTitle = StringEnum.GetEnumTitle()
    @_meterEnum = ContainedEnum.Create()
  end

  def DoControl()
    if _ruleManager.ActiveRules.Count == 0 then
      @_meterEnum.SetAvailability(@_meterEnum.All, true)
      _ruleManager.SetRule(DiscreteDataRule[ELECTRIC_METER].new(@_meterEnum))
    end
  end
end
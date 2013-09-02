class SecondaryHeatingPresentController < FieldController
  def initialize()
    @_fieldTitle = "SecondarySystemPresent"
    @_primarySystemType = "\\PrimaryHeating1\\" + StringEnum.GetEnumTitle()
  end

  def DoControl()
    primarySystemType = _connectedFields[@_primarySystemType].AsInt
    yesNo = ContainedEnum.Create()
    if primarySystemType.HasValue then
      if primarySystemType == PRIMARY_SYSTEM_TYPE.PST_NONE then
        yesNo.SetAvailability(YESNO.NO, true)
        yesNo.SetAvailability(YESNO.YES, false)
      else
        yesNo.SetAvailability(YESNO.NO, true)
        yesNo.SetAvailability(YESNO.YES, true)
      end
      _ruleManager.SetRule(DiscreteDataRule[YESNO].new(yesNo))
    else
      _ruleManager.SetRule(DiscreteDataRule[YESNO].new(yesNo))
    end
  end
end
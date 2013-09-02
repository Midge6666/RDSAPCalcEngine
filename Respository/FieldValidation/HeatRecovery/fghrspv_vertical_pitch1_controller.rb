class FGHRSPVVerticalPitch1Controller < FieldController
  def initialize()
    @_fieldTitle = "FGHRS" + StringEnum.GetEnumTitle() + "1"
    @_kwpPVText = "FGHRSPhotoVoltaicPanelsKwp1"
    @_verticalPitchValues = ContainedEnum.Create()
  end

  def DoControl()
    kwpPVText = _connectedFields[@_kwpPVText].AsFloat
    if kwpPVText.HasValue and kwpPVText.Value > 0.0 then
      _ruleManager.SetRule(DiscreteDataRule[VERTICAL_PITCH].new(@_verticalPitchValues))
    else
      _ruleManager.SetRule(NotRequiredDataRule.Instance)
    end
  end
end
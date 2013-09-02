class FGHRSPVShading2Controller < FieldController
  def initialize()
    @_fieldTitle = "FGHRS" + StringEnum.GetEnumTitle() + "2"
    @_kwpPVText = "FGHRSPhotoVoltaicPanelsKwp2"
    @_shadingValues = ContainedEnum.Create()
  end

  def DoControl()
    kwpPVText = _connectedFields[@_kwpPVText].AsFloat
    if kwpPVText.HasValue and kwpPVText.Value > 0.0 then
      _ruleManager.SetRule(DiscreteDataRule[SOLAR_COLLECTION_SHADING].new(@_shadingValues))
    else
      _ruleManager.SetRule(NotRequiredDataRule.Instance)
    end
  end
end
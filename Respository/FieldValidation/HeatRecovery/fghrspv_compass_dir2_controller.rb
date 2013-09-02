class FGHRSPVCompassDir2Controller < FieldController
  def initialize()
    @_fieldTitle = "FGHRS" + StringEnum.GetEnumTitle() + "2"
    @_pitch = "FGHRS" + StringEnum.GetEnumTitle() + "2"
    @_kwpPVText = "FGHRSPhotoVoltaicPanelsKwp2"
    @_compassValues = ContainedEnum.Create()
  end

  def DoControl()
    kwpPVText = _connectedFields[@_kwpPVText].AsFloat
    if kwpPVText.HasValue and kwpPVText.Value > 0.0 then
      pitch = _connectedFields[@_pitch].AsInt
      if pitch.HasValue then
        if pitch != VERTICAL_PITCH.VER_HORIZONTAL then
          @_compassValues.SetAvailability(@_compassValues.All, true)
          @_compassValues.SetAvailability(COMPASS_DIRECTIONS.DIR_HORIZONTAL, false)
          _ruleManager.SetRule(DiscreteDataRule[COMPASS_DIRECTIONS].new(@_compassValues))
        else
          @_compassValues.SetAvailability(@_compassValues.All, false)
          @_compassValues.SetAvailability(COMPASS_DIRECTIONS.DIR_HORIZONTAL, true)
          _ruleManager.SetRule(DiscreteDataRule[COMPASS_DIRECTIONS].new(@_compassValues))
        end
      end
    else
      _ruleManager.SetRule(NotRequiredDataRule.Instance)
    end
  end
end
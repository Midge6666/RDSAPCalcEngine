class RoomsWithBathShowerController < FieldController
  def initialize()
    @_fieldTitle = "RoomsWithBathShower"
    @_bathAndMixerShowerTitle = "RoomsWithBathAndMixerShower"
    @_bathMixerShoweAndNoBathTitle = "RoomsWithMixerShowerNoBath"
    @_mixerNoBath1Title = "MixerShowersWithWWHRSWithoutBath1"
    @_mixerNoBath2Title = "MixerShowersWithWWHRSWithoutBath2"
    @_mixerWithBath1Title = "MixerShowersWithWWHRSWithBath1"
    @_mixerWithBath2Title = "MixerShowersWithWWHRSWithBath2"
    @_hasWWHRSTitle = StringEnum.GetEnumTitle()
  end

  def CheckValidityAgainstRule(rule, reasonForFailure)
    return (rule.IsValid(AsInt, reasonForFailure))
  end

  def DoControl()
    _ruleManager.SetRule(ConstrainedValueDataRule[System::Nullable].new(self.GetTotalUsed(), 99))
  end

  def GetTotalUsed()
    totalUsed = 0
    bathAndMixerShower = _connectedFields[@_bathAndMixerShowerTitle].AsInt
    bathMixerShoweAndNoBath = _connectedFields[@_bathMixerShoweAndNoBathTitle].AsInt
    mixerNoBath1 = _connectedFields[@_mixerNoBath1Title].AsInt
    mixerNoBath2 = _connectedFields[@_mixerNoBath2Title].AsInt
    mixerWithBath1 = _connectedFields[@_mixerWithBath1Title].AsInt
    mixerWithBath2 = _connectedFields[@_mixerWithBath2Title].AsInt
    if mixerNoBath1.HasValue then
      totalUsed += mixerNoBath1.Value
    end
    if mixerNoBath2.HasValue then
      totalUsed += mixerNoBath2.Value
    end
    if mixerWithBath1.HasValue then
      totalUsed += mixerWithBath1.Value
    end
    if mixerWithBath2.HasValue then
      totalUsed += mixerWithBath2.Value
    end
    sumWithMixer = 0
    if bathAndMixerShower.HasValue then
      sumWithMixer += bathAndMixerShower.Value
    end
    if bathMixerShoweAndNoBath.HasValue then
      sumWithMixer += bathMixerShoweAndNoBath.Value
    end
    totalUsed = totalUsed > sumWithMixer ? totalUsed : sumWithMixer
    return totalUsed
  end
end
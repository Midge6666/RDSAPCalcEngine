

class AddWallInsulationThicknessController < FieldController
  def initialize()
    @_fieldTitle = "AdditionalWall" + StringEnum.GetEnumTitle()
    @_wallInsulationTitle = "AdditionalWall" + StringEnum.GetEnumTitle()
    @_uValueKnownTitle = "AdditionalWallUValueKnown"
    @_wallThicknessEnum = ContainedEnum.Create()
  end

  def DoControl()
    wallInsulation = _connectedFields[@_wallInsulationTitle].AsInt
    wallUValueKnown = _connectedFields[@_uValueKnownTitle].AsInt
    isEnabled = false
    if wallUValueKnown.HasValue and wallUValueKnown.Value == 1 then
      isEnabled = false
    elsif wallInsulation.HasValue then
      if wallInsulation.Value == WALL_INSULATION.WITYPE_EXTERNAL or wallInsulation.Value == WALL_INSULATION.WITYPE_INTERNAL or wallInsulation.Value == WALL_INSULATION.WITYPE_FILLED_EXTERNAL or wallInsulation.Value == WALL_INSULATION.WITYPE_FILLED_INTERNAL then
        @_wallThicknessEnum.SetAvailability(@_wallThicknessEnum.All, true)
        _ruleManager.SetRule(DiscreteDataRule[WALL_INSULATION_THICKNESS].new(@_wallThicknessEnum))
        isEnabled = true
      end
    end
    if not isEnabled then
      _ruleManager.SetRule(NotRequiredDataRule.Instance)
    end
  end
end

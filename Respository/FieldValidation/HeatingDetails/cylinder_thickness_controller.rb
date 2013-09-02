class CylinderInsulationThicknessController < FieldController
  def initialize()
    @_fieldTitle = StringEnum.GetEnumTitle()
    @_cylinderInsulationTypeTitle = StringEnum.GetEnumTitle()
  end

  def DoControl()
    CylinderInsul = _connectedFields[@_cylinderInsulationTypeTitle].AsInt
    if CylinderInsul.HasValue and CylinderInsul != CYLINDER_INSULATION_TYPE.CITYPE_NONE then
      _ruleManager.SetRule(DiscreteDataRule[CYLINDER_INSULATION_THICK].new(ContainedEnum.Create()))
    else
      _ruleManager.SetRule(NotRequiredDataRule.Instance)
    end
  end
end
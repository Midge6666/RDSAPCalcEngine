class CylinderInsulationTypeController < FieldController
  def initialize()
    @_fieldTitle = StringEnum.GetEnumTitle()
    @_cylinderSizeTitle = StringEnum.GetEnumTitle()
  end

  def DoControl()
    CylinderSize = _connectedFields[@_cylinderSizeTitle].AsInt
    if CylinderSize.HasValue and (CylinderSize != CYLINDER_SIZE.HWCSIZE_NOCYLINDER and CylinderSize != CYLINDER_SIZE.HWCSIZE_NOACCESS) then
      _ruleManager.SetRule(DiscreteDataRule[CYLINDER_INSULATION_TYPE].new(ContainedEnum.Create()))
    else
      _ruleManager.SetRule(NotRequiredDataRule.Instance)
    end
  end
end
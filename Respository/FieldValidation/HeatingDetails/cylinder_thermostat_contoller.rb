class CylinderThermostatController < FieldController
  def initialize()
    @_fieldTitle = "CylinderThermostat"
    @_cylinderSizeTitle = StringEnum.GetEnumTitle()
    @_waterHeatingTitle = StringEnum.GetEnumTitle()
  end

  def DoControl()
    CylinderSize = _connectedFields[@_cylinderSizeTitle].AsInt
    waterType = _connectedFields[@_waterHeatingTitle].AsInt
    if (waterType.HasValue) and (waterType == WATER_TYPE.WHTYPE_IMMERSION) then
      _ruleManager.SetRule(NotRequiredDataRule.Instance)
    elsif CylinderSize.HasValue and (CylinderSize != CYLINDER_SIZE.HWCSIZE_NOCYLINDER and CylinderSize != CYLINDER_SIZE.HWCSIZE_NOACCESS) then
      _ruleManager.SetRule(DiscreteDataRule[YESNO].new(ContainedEnum.Create()))
    else
      _ruleManager.SetRule(NotRequiredDataRule.Instance)
    end
  end
end
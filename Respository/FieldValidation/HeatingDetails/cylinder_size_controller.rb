class CylinderSizeController < FieldController
  def initialize()
    #_ruleManager.SetRule(_notRequired);
    #case HEATING_SYSTEM.ELEC_DIRECT_BOILER:
    @_fieldTitle = StringEnum.GetEnumTitle()
    @_waterHeatingTitle = StringEnum.GetEnumTitle()
    @_primarySystemTitle1 = "PrimaryHeating1\\" + StringEnum.GetEnumTitle()
    @_primarySystemTitle2 = "PrimaryHeating2\\" + StringEnum.GetEnumTitle()
    @_sedbukTitle1 = "PrimaryHeating1\\SedbukBoilerIndex"
    @_sedbukTitle2 = "PrimaryHeating2\\SedbukBoilerIndex"
    @_notRequired = NotRequiredDataRule.Instance
    @CylinderEnum = ContainedEnum.Create()
  end

  def DoControl()
    WaterHeating = _connectedFields[@_waterHeatingTitle].AsInt
    systemType1 = _connectedFields[@_primarySystemTitle1].AsInt
    systemType2 = nil
    if _connectedFields.ContainsKey(@_primarySystemTitle2) then
      systemType2 = _connectedFields[@_primarySystemTitle2].AsInt
    end
    @CylinderEnum.SetAvailability(@CylinderEnum.All, true)
    if WaterHeating.HasValue and (WaterHeating == WATER_TYPE.WHTYPE_NONE or WaterHeating == WATER_TYPE.WHTYPE_GASINSTANTMULTI or WaterHeating == WATER_TYPE.WHTYPE_GASINSTANTSINGLE or WaterHeating == WATER_TYPE.WHTYPE_ELECTRICINSTANT) then
      @CylinderEnum.SetAvailability(@CylinderEnum.All, false)
      @CylinderEnum.SetAvailability(CYLINDER_SIZE.HWCSIZE_NOCYLINDER, true)
      _ruleManager.SetRule(DiscreteDataRule[CYLINDER_SIZE].new(@CylinderEnum))
    elsif ((WaterHeating.HasValue) and (WaterHeating == WATER_TYPE.WHTYPE_FROM_PRIMARYA)) and ((self.IsPrimarySystemCombiOrCPSU(systemType1) or self.IsSedbukCombi(@_sedbukTitle1))) then
      @CylinderEnum.SetAvailability(@CylinderEnum.All, false)
      @CylinderEnum.SetAvailability(CYLINDER_SIZE.HWCSIZE_NOCYLINDER, true)
      _ruleManager.SetRule(DiscreteDataRule[CYLINDER_SIZE].new(@CylinderEnum))
    elsif ((WaterHeating.HasValue) and (WaterHeating == WATER_TYPE.WHTYPE_FROM_PRIMARYB)) and ((self.IsPrimarySystemCombiOrCPSU(systemType2) or self.IsSedbukCombi(@_sedbukTitle2))) then
      @CylinderEnum.SetAvailability(@CylinderEnum.All, false)
      @CylinderEnum.SetAvailability(CYLINDER_SIZE.HWCSIZE_NOCYLINDER, true)
      _ruleManager.SetRule(DiscreteDataRule[CYLINDER_SIZE].new(@CylinderEnum))
    else
      if _connectedFields.ContainsKey(@_primarySystemTitle2) then
        systemType2 = _connectedFields[@_primarySystemTitle2].AsInt
      end
      if WaterHeating.HasValue and WaterHeating == WATER_TYPE.WHTYPE_FROM_PRIMARYA then
        @CylinderEnum.SetAvailability(CYLINDER_SIZE.HWCSIZE_NOCYLINDER, self.SetCylinderFromSystem(systemType1, WaterHeating, @_sedbukTitle1))
      elsif WaterHeating.HasValue and WaterHeating == WATER_TYPE.WHTYPE_FROM_PRIMARYB then
        @CylinderEnum.SetAvailability(CYLINDER_SIZE.HWCSIZE_NOCYLINDER, self.SetCylinderFromSystem(systemType2, WaterHeating, @_sedbukTitle2))
      end
      _ruleManager.SetRule(DiscreteDataRule[CYLINDER_SIZE].new(@CylinderEnum))
    end
  end

  def SetCylinderFromSystem(systemType, waterType, sedbukTitle)
    if systemType.HasValue and (systemType == HEATING_SYSTEM.COMMUMITY_HEATING_BOILERS or systemType == HEATING_SYSTEM.COMMUNITY_HEATING_BOILERS_CHP) then
      return true
    elsif waterType.HasValue and (waterType == WATER_TYPE.WHTYPE_COMMUNITY_BOILERS or waterType == WATER_TYPE.WHTYPE_COMMUNITY_CHP or waterType == WATER_TYPE.WHTYPE_COMMUNITY_HEAT_PUMP) then
      return true
    elsif self.IsSedbukHeatpump(sedbukTitle) or self.IsSedbukMicroCHP(sedbukTitle) then
      return true
    else
      return false
    end
  end

  def IsSedbukCombi(sedbukTitle)
    if _connectedFields.ContainsKey(sedbukTitle) then
      SedbukIndex = _connectedFields[sedbukTitle].Value
      if SedbukIndex != nil then
        sedbukInt = Convert.ToInt32(SedbukIndex)
        return SedbukAccess.IsThisBoilerACombi(sedbukInt.ToString("000000"))
      end
    end
    return false
  end

  def IsSedbukMicroCHP(sedbukTitle)
    if _connectedFields.ContainsKey(sedbukTitle) then
      SedbukIndex = _connectedFields[sedbukTitle].Value
      if SedbukIndex != nil then
        sedbukInt = Convert.ToInt32(SedbukIndex)
        return SedbukAccess.IsThisAMicroCHP(sedbukInt.ToString("000000"))
      end
    end
    return false
  end

  def IsSedbukHeatpump(sedbukTitle)
    if _connectedFields.ContainsKey(sedbukTitle) then
      SedbukIndex = _connectedFields[sedbukTitle].Value
      if SedbukIndex != nil then
        sedbukInt = Convert.ToInt32(SedbukIndex)
        return SedbukAccess.IsThisAHeatPump(sedbukInt.ToString("000000"))
      end
    end
    return false
  end

  def IsPrimarySystemCombiOrCPSU(SystemType)
    if SystemType.HasValue then
      case SystemType
        when HEATING_SYSTEM.GAS_POST97_COMBI_AUTO, HEATING_SYSTEM.GAS_POST97_CONDENSING_COMBI, HEATING_SYSTEM.GAS_POST97_COMBI_PILOT, HEATING_SYSTEM.GAS_FAN_PRE98_COMBI, HEATING_SYSTEM.GAS_FAN_PRE98_CONDENSING_COMBI, HEATING_SYSTEM.GAS_PRE98_COMBI, HEATING_SYSTEM.GAS_CPSU_NORMAL, HEATING_SYSTEM.GAS_CPSU_CONDENSING, HEATING_SYSTEM.OIL_PRE98_COMBI, HEATING_SYSTEM.OIL_POST97_COMBI, HEATING_SYSTEM.OIL_CONDENSING_COMBI, HEATING_SYSTEM.ELEC_CPSU
          return true
        else
          return false
      end
    else
      return false
    end
  end
end
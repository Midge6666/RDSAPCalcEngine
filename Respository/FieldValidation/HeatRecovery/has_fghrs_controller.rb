class HasFGHRSController < FieldController
  def initialize()
    @_fieldTitle = StringEnum.GetEnumTitle()
    @_numberOfSystemsTitle = StringEnum.GetEnumTitle()
    @_sedbukIndexTitle1 = "PrimaryHeating1\\SedbukBoilerIndex"
    @_sedbukIndexTitle2 = "PrimaryHeating2\\SedbukBoilerIndex"
    @_primaryHeating1Title = "PrimaryHeating1\\" + StringEnum.GetEnumTitle()
    @_primaryHeating2Title = "PrimaryHeating2\\" + StringEnum.GetEnumTitle()
    @_fghrsOptions = ContainedEnum.Create()
  end

  def DoControl()
    @_fghrsOptions.SetAvailability(@_fghrsOptions.All, false)
    @_fghrsOptions.SetAvailability(HAS_FGHRS.HASFGHRS_NO, true)
    self.CheckMainSystemsForCondensingBoiler()
    _ruleManager.SetRule(DiscreteDataRule[HAS_FGHRS].new(@_fghrsOptions))
    self.SetDefault()
  end

  def SetDefault()
    if System::String.IsNullOrEmpty(self.@Current) then
      EpcDomainController.Singleton.Execute(EpcDomainController.CreateUpdateCommand(self.@FullName, HAS_FGHRS.HASFGHRS_NO))
    end
  end

  def CheckMainSystemsForCondensingBoiler()
    sedbukIndex1 = nil
    sedbukIndex2 = nil
    primaryHeating1 = nil
    primaryHeating2 = nil
    numberOfSystems = nil
    if _connectedFields.ContainsKey(@_numberOfSystemsTitle) then
      numberOfSystems = _connectedFields[@_numberOfSystemsTitle].AsInt
    end
    if _connectedFields.ContainsKey(@_sedbukIndexTitle1) then
      sedbukIndex1 = _connectedFields[@_sedbukIndexTitle1].Value
    end
    if _connectedFields.ContainsKey(@_sedbukIndexTitle2) then
      sedbukIndex2 = _connectedFields[@_sedbukIndexTitle2].Value
    end
    if _connectedFields.ContainsKey(@_primaryHeating1Title) then
      primaryHeating1 = _connectedFields[@_primaryHeating1Title].AsInt
    end
    if _connectedFields.ContainsKey(@_primaryHeating2Title) then
      primaryHeating2 = _connectedFields[@_primaryHeating2Title].AsInt
    end
    if numberOfSystems.HasValue then
      if numberOfSystems.Value == NUMBER_PRIMARY_SYSTEMS.NMS_ONE or numberOfSystems.Value == NUMBER_PRIMARY_SYSTEMS.NMS_ONE_DHW or numberOfSystems.Value == NUMBER_PRIMARY_SYSTEMS.NMS_TWO then
        if self.CheckSedbukRecordIsCondensing(sedbukIndex1) or self.CheckPrimaryHeatingRecordIsCondensing(primaryHeating1) then
          @_fghrsOptions.SetAvailability(HAS_FGHRS.HASFGHRS_ONE, true)
        end
        if self.CheckSedbukRecordIsCondensing(sedbukIndex2) or self.CheckPrimaryHeatingRecordIsCondensing(primaryHeating2) then
          @_fghrsOptions.SetAvailability(HAS_FGHRS.HASFGHRS_TWO, true)
          if self.CheckSedbukRecordIsCondensing(sedbukIndex1) or self.CheckPrimaryHeatingRecordIsCondensing(primaryHeating1) then
            @_fghrsOptions.SetAvailability(HAS_FGHRS.HASFGHRS_BOTH, true)
          end
        end
      end
    end
  end

  def CheckSedbukRecordIsCondensing(sedbukIndex)
    if not System::String.IsNullOrEmpty(sedbukIndex) then
      return SedbukAccess.IsThisBoilerCondensing(sedbukIndex)
    end
    return false
  end

  def CheckPrimaryHeatingRecordIsCondensing(primaryHeatingSystemCode)
    if primaryHeatingSystemCode.HasValue then
      case primaryHeatingSystemCode.Value
        when HEATING_SYSTEM.GAS_POST97_CONDENSING, HEATING_SYSTEM.GAS_POST97_CONDENSING_COMBI, HEATING_SYSTEM.OIL_CONDENSING, HEATING_SYSTEM.OIL_CONDENSING_COMBI, HEATING_SYSTEM.GAS_WARMAIR_CONDENSING, HEATING_SYSTEM.GAS_CPSU_CONDENSING, HEATING_SYSTEM.GAS_FAN_PRE98_CONDENSING, HEATING_SYSTEM.GAS_FAN_PRE98_CONDENSING_COMBI
          return true
      end
    end
    return false
  end
end
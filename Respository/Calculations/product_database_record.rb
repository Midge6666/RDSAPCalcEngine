class ProductDatabaseRecord
  def initialize(id)
    self.@_pcdfRecord = nil
    self.@_communityUse = false
    self.@_appendixNRecord = nil
    _validator = Validator.new(self)
    _pcdfRecord = (id)
    if _pcdfRecord.GetRecordType() == Pcdf_CoGen then
      _appendixNRecord = MicroCoGenRecord[IPcdfCoGenRecord].new(_pcdfRecord)
    end
    if _pcdfRecord.GetRecordType() == Pcdf_HeatPump then
      _appendixNRecord = HeatPumpRecord[IPcdfHeatPumpRecord].new(_pcdfRecord)
    end
    if _pcdfRecord == nil then
      raise self.EngineException("Attempt to construct a ProductDatabaseRecord with invalid pcdb record id")
    end
  end

  def Dispose()
    if _appendixNRecord != nil then
      _appendixNRecord = nil
      _appendixNRecord = nil
    end
    _validator = nil
  end

  def GetHeatingClass()
    if _communityUse then
      return HSC_COMMUNITY_HEATING
    else
      if self.IsHeatpump() then
        HeatPump = _pcdfRecord
        if HeatPump.GetEmitter_type() == Pcdf_Hpet_WarmAir then # some confusion over - HeatPump->GetEmitter_type() == Pcdf_Hpet_FanCoil ||
          return HSC_WARM_AIR
        else
          return HSC_CENTRAL_HEATING
        end
      else
        return HSC_CENTRAL_HEATING
      end
    end
  end

  def GetHeatingCode()
    return self.N()
  end

  def GetFuelCategory()
    case _pcdfRecord.GetFuel()
      else, F_GAS_MAINS, F_GAS_LNG, F_GAS_BULK_LPG, F_GAS_BOTTLED_LPG, F_GAS_LPG_SC18, F_COMMUNITY_MAINS_GAS, F_COMMUNITY_LPG
      return FC_GAS
      when F_OIL, F_BIODIESEL_BIOMASS, F_BIODIESEL_COOKING_OIL, F_RAPESEED_OIL, F_MINERAL_OIL, F_B30K, F_BIOETHANOL, F_COMMUNITY_OIL
      return FC_OIL
      when F_HOUSECOAL, F_ANTHRACITE, F_SMOKELESS, F_WOOD_LOGS, F_WOOD_PELLETS_BAGGED, F_WOOD_PELLETS_BULK, F_WOOD_CHIPS, F_DUAL_FUEL, F_COMMUNITY_COAL
      return FC_SOLID
      when F_ELEC_STANDARD, F_ELEC_7HOUR_ONPEAK, F_ELEC_7HOUR_OFFPEAK, F_ELEC_10HOUR_ONPEAK, F_ELEC_10HOUR_OFFPEAK, F_ELEC_24HOUR, F_ELEC_SOLD, F_ELEC_DISPLACED, F_ELEC_UNSPECIFIED, F_COMMUNITY_CHP_ELEC, F_COMMUNITY_ELEC_DNET, F_COMMUNITY_ELEC_HEATPUMP
      return FC_ELECTRIC
    end
  end

  def GetEfficiency()
    if _pcdfRecord.GetRecordType() == Pcdf_Boiler then
      return (_pcdfRecord).GetSapWinterSeasonal()
    end
    # TODO : For solid fuel boilers the effiiency could be blank.  It is then calculated based on Appendix J driven by other data in the same record.
    # At this stage time is better spent getting regular boilers working before sorting out specific Solid fuel issues
    # Also need to hook up other record type efficiencies - Cooker, cogen
    return 0.0
  end

  def GetHeatingType()
    # all product DB systems are category 1
    return (1)
  end

  def GetResponsiveness()
    if _pcdfRecord.GetRecordType() == Pcdf_SolidFuel then
      #Systems classed as room heaters have a responsiveness of 0.5 unless they are pellet fired
      if () == Pcdf_SFP_Open or (_pcdfRecord).GetMainType() == Pcdf_SFP_ClosedRoomHeater then
      end
    else
      return (0.75)
    end
  end

  def HasFuelSpecificEfficiency(fuel)
    # product DB don't have fuel specific efficiencies
    return (false)
  end

  def GetFuelSpecificEfficiency(fuel)
    self._ASSERT(0)
    # product DB don't have fuel specific efficiencies
    return (self.GetEfficiency())
  end

  def HasFuelSpecificResponsiveness(fuel)
    # product DB don't have fuel specific responsiveness
    return (false)
  end

  def GetFuelSpecificResponsiveness(fuel)
    self._ASSERT(0)
    # product DB don't have fuel specific responsiveness
    return (self.GetResponsiveness())
  end

  def CanProvideHotWater()
    if _pcdfRecord.GetRecordType() == Pcdf_CoGen or _pcdfRecord.GetRecordType() == Pcdf_HeatPump then
      if _appendixNRecord.GetServiceProvision() == MCG_SP_SPACE_ONLY then
        return false
      end
    end
    return (true)
  end

  def RequiresSupplementalHeating()
    if _pcdfRecord.GetRecordType() == Pcdf_CoGen or _pcdfRecord.GetRecordType() == Pcdf_HeatPump then
      if _appendixNRecord.GetServiceProvision() == MCG_SP_SPACE_AND_WATER_SEASONAL then
        return true
      end
    end
    return (false)
  end

  def IsFromProductDatabase()
    return (true)
  end

  def IsOffPeakOnlySystem()
    return (false)
  end

  def HasSeperateDHWTestsBeenConducted()
    rv = false
    if _pcdfRecord.GetRecordType() == Pcdf_Boiler then
      if _pcdfRecord then
        () != DHWtests_none
      end
    end
  end

  def IsSeperateDHWTestsUsing2Schedules()
    rv = false
    if _pcdfRecord.GetRecordType() == Pcdf_Boiler then
      case _pcdfRecord

      ()
      when DHWtests_two_tests_schedules_2_and_3, DHWtests_two_tests_schedules_2_and_1
      rv = true
    end
  end
  return rv
end

def GetRejectedEnergyR1InHWTest1()
  if _pcdfRecord.GetRecordType() == Pcdf_Boiler then
    return (_pcdfRecord).GetRejectedEnergyR1InHWTest1()
  end
  return self.N()
end

def GetStorageLossFactorF1()
  if _pcdfRecord.GetRecordType() == Pcdf_Boiler then
    return (_pcdfRecord).GetStorageLossFactorF1()
  end
  return self.N()
end

def GetStorageLossFactorF2()
  if _pcdfRecord.GetRecordType() == Pcdf_Boiler then
    return (_pcdfRecord).GetStorageLossFactorF2()
  end
  return self.N()
end

def GetStorageLossFactorF3()
  if _pcdfRecord.GetRecordType() == Pcdf_Boiler then
    return (_pcdfRecord).GetStorageLossFactorF3()
  end
  return self.N()
end

def GetManufacturersWaterLossFactor()
  if _pcdfRecord.GetRecordType() == Pcdf_Boiler then
    boiler = _pcdfRecord
    case boiler.GetSeperateDHWTests()
      when DHWtests_none # returns 0 below
      when DHWtests_one_test_schedule_2, DHWtests_two_tests_schedules_2_and_3, DHWtests_two_tests_schedules_2_and_1
        return boiler.GetStorageLossFactorF2()
    end
  end # storage factor F2 is the primary type in each test case, Additional loss factor returns either loss factor 1 or 3
  return self.N(0)
end

def GetManufacturersAdditionalWaterLossFactor()
  if _pcdfRecord.GetRecordType() == Pcdf_Boiler then
    boiler = _pcdfRecord
    case boiler.GetSeperateDHWTests()
      when DHWtests_one_test_schedule_2, DHWtests_none # returns 0 below
      when DHWtests_two_tests_schedules_2_and_3
        return boiler.GetStorageLossFactorF3()
      when DHWtests_two_tests_schedules_2_and_1
        return boiler.GetStorageLossFactorF1()
    end
  end
  return self.N(0)
end

def GetFuel()
  return (_pcdfRecord.GetFuel())
end

def GetBoilerPowerTop()
  case _pcdfRecord.GetRecordType()
    when Pcdf_Boiler
      return (_pcdfRecord).GetBoilerPowerTop()
    when Pcdf_SolidFuel
      return (_pcdfRecord).GetBoilerPowerTop()
    when Pcdf_Cooker
      return (_pcdfRecord).GetBoilerPowerTop()
    else
      return nil
  end
end

def GetWinterEfficiency(hetasApproved)
  case _pcdfRecord.GetRecordType()
    when Pcdf_Boiler
      return (_pcdfRecord).GetSapWinterSeasonal() / 100.0
    when Pcdf_Cooker
      return (_pcdfRecord).GetSapWinterSeasonal() / 100.0
    when Pcdf_SolidFuel
      return (_pcdfRecord).GetSapEfficiency() / 100.0
    else
      return nil
  end
end

def GetSummerEfficiency()
  case _pcdfRecord.GetRecordType()
    when Pcdf_Boiler
      return (_pcdfRecord).GetSapSummerSeasonal() / 100.0
    when Pcdf_Cooker
      return (_pcdfRecord).GetSapSummerSeasonal() / 100.0
    when Pcdf_SolidFuel
      return (_pcdfRecord).GetSapEfficiency() / 100.0
    else
      return nil
  end
end

def GetSeparateDHWtests()
  if _pcdfRecord.GetRecordType() == Pcdf_Boiler then
    return (_pcdfRecord).GetSeperateDHWTests()
  else
    return DHWtests_none
  end
end

def GetKeepHotFacility()
  if _pcdfRecord.GetRecordType() == Pcdf_Boiler then
    pcdfBoilerRecord = _pcdfRecord
    if not self.IsCombiSystem() then
      _keepHotFacility = KHF_NOT_COMBI
    end
    if pcdfBoilerRecord.GetKeepHotFacility() == KHF_Inapplicable or pcdfBoilerRecord.GetKeepHotFacility() == KHF_None then
      _keepHotFacility = KHF_NO_FACILITY
    else
      if pcdfBoilerRecord.GetKeepHotTimer() then
        _keepHotFacility = KHF_WITH_TIME_CONTROL
      else
        _keepHotFacility = KHF_NO_TIME_CONTROL
      end
    end
  else
    _keepHotFacility = KHF_NO_FACILITY
  end
  return _keepHotFacility
end

def GetKeepHotSource()
  if _pcdfRecord.GetRecordType() == Pcdf_Boiler then
    case _pcdfRecord

    ()
    when KHF_Gas_Oil_Only, KHF_Gas_Oil_Electricity
    return KHS_HEATING_FUEL
    when KHF_Electric
    return KHS_ELECTRIC
  end
else
  return KHS_NONE
end
end

def GetKeepHotPower()
  if _pcdfRecord.GetRecordType() == Pcdf_Boiler then
    _keepHotPower = (_pcdfRecord).GetKeepHotPower()
  end
  return _keepHotPower
end

def IsCPSU()
  if _pcdfRecord.GetRecordType() == Pcdf_Boiler then
    boiler = _pcdfRecord
    if boiler.GetMainType() == MT_CPSU then
      # If the record is set to cpsu but store volume is < 70 then this isn't a cpsu
      if self.GetStoreVolume() < 70 then
        return false
      else
        return true
      end
    elsif boiler.GetMainType() == MT_Unknown then
      return self.N()
    else
      return false
    end
  end
  return false
end

def IsCombiSystem()
  if _pcdfRecord.GetRecordType() == Pcdf_Boiler then
    boiler = _pcdfRecord
    if boiler.GetMainType() == MT_Combi or boiler.GetMainType() == MT_CPSU then
      return true
    elsif boiler.GetMainType() == MT_Unknown then
      return self.N()
    else
      return false
    end
  end
  return false
end

def IsFromDirectActingElectric()
  #TODO: May need to add this logic from product database boilers (LEE)
  return (false)
end

def GetStoreVolume()
  if _pcdfRecord.GetRecordType() == Pcdf_Boiler then
    return (_pcdfRecord).GetStoreVolume()
  else
    return self.N()
  end
end

def GetStoreSolarVolume()
  if _pcdfRecord.GetRecordType() == Pcdf_Boiler then
    return (_pcdfRecord).GetStoreSolarVolume()
  else
    return self.N()
  end
end

def GetHotWaterProvision()
  if _pcdfRecord.GetRecordType() == Pcdf_CoGen or _pcdfRecord.GetRecordType() == Pcdf_HeatPump then
    case _appendixNRecord.GetServiceProvision()
      else, MCG_SP_UNKNOWN, MCG_SP_SPACE_AND_WATER_ALL_YEAR, MCG_SP_WATER_ONLY
      return HWP_INDEPENDANT
      when MCG_SP_SPACE_AND_WATER_SEASONAL
      return HWP_WINTER
      when MCG_SP_SPACE_ONLY
      return HWP_NONE
    end
  elsif _pcdfRecord.GetRecordType() == Pcdf_SolidFuel then
    case _pcdfRecord

    ()
  else, Pcdf_SFP_Independant
  return HWP_INDEPENDANT
  end
else
  return (HWP_INDEPENDANT)
end
end

def GetHeatpumpType()
  if _pcdfRecord.GetRecordType() == Pcdf_HeatPump then
    case _pcdfRecord

    ()
    when Pcdf_Hps_Water
    return HPT_WATER_SOURCE
    when Pcdf_Hps_Air, Pcdf_Hps_ExhaustAirMEV, Pcdf_Hps_ExhaustAirMVHR, Pcdf_Hps_MixedAirMEWAndOutsideAir
    return HPT_AIR_SOURCE
  end
end
return HPT_NOT_HEATPUMP
end

def GetStoreInsThick()
  if _pcdfRecord.GetRecordType() == Pcdf_Boiler then
    return (_pcdfRecord).GetStoreInsThick()
  else
    return self.N()
  end
end

def GetThermalStoreType()
  # Here's the rule we're going with for now:
  # If the system is a regular boiler with a volume defined then return integrated, otherwise return no thermal store
  if _pcdfRecord.GetRecordType() == Pcdf_Boiler then
    pRecord = _pcdfRecord
    if pRecord.GetMainType() == MT_Regular and pRecord.GetStoreVolume().TestValue() == true and pRecord.GetStoreVolume().GetValue() > 0.0 then
      return TST_INTEGRATED
    end
  end
  return TST_NO_THERMAL_STORE
end

def GetCombiType()
  if _pcdfRecord.GetRecordType() == Pcdf_Boiler then
    case _pcdfRecord

    ()
  end
end
def GetStorageHeatingType()
  # storage heaters no in product database (at the moment)
  return (SHT_NOT_STORAGE)
end

def IsStoveOrRange()
  if _pcdfRecord.GetRecordType() == Pcdf_Cooker then
    return true
  end
  return false
end

def IsBackBoiler()
  if _pcdfRecord.GetRecordType() == Pcdf_Boiler then
    if _pcdfRecord then
      () == Pcdf_MountingPosBackBoiler
    end
  end
end

def IsUnitInHeatedSpace()
  return self.N()
end

def IsMicrogenSystem()
  return (_pcdfRecord.GetRecordType() == Pcdf_CoGen)
end

def IsElectricCPSU()
  if _pcdfRecord.GetRecordType() == Pcdf_Boiler then
    if self.GetFuelCategory() == FC_ELECTRIC and (_pcdfRecord).GetMainType() == MT_CPSU then
      return true
    end
  end
  return false
end

def IsHeatpump()
  if _pcdfRecord.GetRecordType() == Pcdf_HeatPump then
    return true
  end
  return false
end

def IsUnderfloorHeating()
  # no underfloor heating in DB
  return (false)
end

def IsPre98System()
  if _pcdfRecord.GetFirstYear() == "" then
    return self.N()
  elsif Convert.ToInt32(_pcdfRecord.GetFirstYear().c_str()) < 98 then
    return true
  end
  return false
end

def IsCondensingBoiler()
  if _pcdfRecord.GetRecordType() == Pcdf_Boiler then
    return ()
  elsif _pcdfRecord.GetRecordType() == Pcdf_Cooker then
    return ()
  elsif _pcdfRecord.GetRecordType() == Pcdf_CoGen then
    return ()
  else
    return false
  end
end

def HasFlueGasHeatRecovery()
  return (_pcdfRecord.GetRecordType() == Pcdf_FlueGasHeatRecovery)
end

def HasChimney()
  if _pcdfRecord.GetFlueType() == Pcdf_FlueTypeOpenChimney then
    return true
  end
  return false
end

def HasOpenFlue()
  if _pcdfRecord.GetFlueType() == Pcdf_FlueTypeOpen then
    return true
  end
  return false
end

def HasFanFlue()
  if _pcdfRecord.GetRecordType() == Pcdf_Boiler then
    FanAssist = (_pcdfRecord).GetFanAssist()
    if FanAssist == Pcdf_FanAssistUnknown then
      _isFanFlue.Clear()
    elsif FanAssist == Pcdf_FanAssistNoFan then
      _isFanFlue.SetValue(false)
    elsif FanAssist == Pcdf_FanAssistFan then
      _isFanFlue.SetValue(true)
    else
      # TODO: validation error
      _isFanFlue.Clear()
    end
    return _isFanFlue
  end
  return _isFanFlue
end

def GetCondensingState(Value)
  case Value
    when Pcdf_Condensing
      return true
    when Pcdf_CondensingUnknown
      return self.N()
    else, Pcdf_NonCondensing
    return false
  end
end

def IsFuelValid(Fuel)
  return _pcdfRecord.IsFuelValid(Fuel)
end

def GetStorageLossFactor()
  if _pcdfRecord.GetRecordType() == Pcdf_Boiler then
    return (_pcdfRecord).GetStorageLossFactorF1()
  end
  return self.N()
end

def GetAppendixNInterfaceRecord()
  if _pcdfRecord.GetRecordType() == Pcdf_CoGen or _pcdfRecord.GetRecordType() == Pcdf_HeatPump then
    return _appendixNRecord
  else
    return nil
  end
end

def GetCookerCaseLossAtFullOutput()
  if _pcdfRecord.GetRecordType() == Pcdf_Cooker then
    return (_pcdfRecord).GetCaseLossFullOutput()
  else
    return self.N()
  end
end

def GetCookerFullOutput()
  if _pcdfRecord.GetRecordType() == Pcdf_Cooker then
    return (_pcdfRecord).GetFullOutputPower()
  else
    return self.N()
  end
end

def IsElectricaireSystem()
  return false
end

def HasPFGHRSInstalled()
  if _pcdfRecord.GetRecordType() == Pcdf_Boiler then
    BoilerRec = _pcdfRecord
    if BoilerRec.GetSubsidiaryType() == PCDF_ST_PFGHRD then
      return true
    end
  end
  return false
end

def GetPFGHRSIndex()
  if self.HasPFGHRSInstalled() then
    return (_pcdfRecord).GetSubsidiaryTypeIndex()
  end
  return self.N()
end

def GetIsSeperateStore()
  if _pcdfRecord.GetRecordType() == Pcdf_Boiler then
    BoilerRec = _pcdfRecord
    if BoilerRec.GetSeperateStore() == TST_SEPARATED then
      return true
    end
  end
  return false
end
end
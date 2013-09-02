class HeatingSystemData
  def initialize()
    self.@_pMainPrimarySystem = nil
    self.@_pSecondarySystem = nil
    self.@_pAssumedSecondarySystem = nil
    self.@_pAssumedPrimarySystem = nil
    self.@_pCalculationForcedElectricSystem = nil
    _validator = Validator.new(self, _validationController)
    _waterHeatingSystem.SetCommunityHeatingLink(_communityHeatingData)
  end

  def Dispose()
    _validator = nil
    self.ClearHeatingData()
  end

  def ClearHeatingData()
    if _pMainPrimarySystem != nil then
      _pMainPrimarySystem = nil
      _pMainPrimarySystem = nil
    end
    if _pSecondarySystem != nil then
      _pSecondarySystem = nil
      _pSecondarySystem = nil
    end
    if _pCalculationForcedElectricSystem != nil then
      _pCalculationForcedElectricSystem = nil
      _pCalculationForcedElectricSystem = nil
    end
    if _pAssumedSecondarySystem != nil then
      _pAssumedSecondarySystem = nil
      _pAssumedSecondarySystem = nil
    end
    if _pAssumedPrimarySystem != nil then
      _pAssumedPrimarySystem = nil
      _pAssumedPrimarySystem = nil
    end
    self.DeleteAndClearVector(_supplementaryPrimarySystems)
  end

  def NumberCentralHeatingPumpsInHeatedSpace()
    count = 0
    if _pMainPrimarySystem != nil then
      if _pMainPrimarySystem.HasWaterPumpInHeatedSpace() then
        count += 1
      end
    end
    enumerator = .GetEnumerator()
    while enumerator.MoveNext()
      = enumerator.Current
    end

  end

  def NumberOilBoilerPumpsInsideDwelling()
    count = 0
    if _pMainPrimarySystem != nil then
      if _pMainPrimarySystem.GetFuelPumpType() == FPT_PUMP_HEATED_SPACE then
        count += 1
      end
    end
    enumerator = .GetEnumerator()
    while enumerator.MoveNext()
      = enumerator.Current
    end

  end

  def IsWarmAirSystemInDwelling()
    result = false
    if _pMainPrimarySystem != nil then
      if _pMainPrimarySystem.IsClass(HSC_WARM_AIR) then
        result = true
      end
    end
    if result == false then
      cit = _supplementaryPrimarySystems.begin()
      while cit.MoveNext()
        if (cit.Current).pSystem.IsClass(HSC_WARM_AIR) then
          result = true
          break
        end
      end
    end
    return (result)
  end

  def GetChimneyCount()
    count = 0
    limit = self.GetPrimarySystemCount()
    index = 0
    while index < limit
      if self.GetPrimarySystemData(index).HasChimney() then
        count += 1
      end
      index += 1
    end
    if _pSecondarySystem != nil then
      if _pSecondarySystem.HasChimney() then
        count += 1
      end
    end
    return (count)
  end

  def GetFlueCount()
    count = 0
    limit = self.GetPrimarySystemCount()
    index = 0
    while index < limit
      pPrimary = self.GetPrimarySystemData(index)
      if pPrimary.HasOpenFlue() and (pPrimary.IsHeatingUnitInHeatedSpace() and pPrimary.IsProvidingSpaceHeating()) then
        count += 1
      end
      index += 1
    end
    pSecondary = self.GetSecondarySystemData()
    if pSecondary != nil then # In occupancy assessment if the RdSAP system has been replaced by a room heater then ignore the flue of the new heater
      if pSecondary.HasOpenFlue() then
        count += 1
      end
    end
    return (count)
  end

  def GetFlues(primary1, primary2, secondary)
    count = 0
    limit = self.GetPrimarySystemCount()
    index = 0
    while index < limit
      pPrimary = self.GetPrimarySystemData(index)
      if pPrimary.HasOpenFlue() and (pPrimary.IsHeatingUnitInHeatedSpace() and pPrimary.IsProvidingSpaceHeating()) then
        if index == 0 then
          primary1 = 1
        else
          primary2 = 1
        end
      end
      index += 1
    end
    pSecondary = self.GetSecondarySystemData()
    if pSecondary != nil then # In occupancy assessment if the RdSAP system has been replaced by a room heater then ignore the flue of the new heater
      if pSecondary.HasOpenFlue() then
        secondary = 1
      end
    end
  end

  def SetPrimarySystem(system, fuel, controls)
    HeatingData = SpaceHeatingData.new(system)
    self.SetPrimarySystem(HeatingData, fuel, controls)
  end

  def SetPrimarySystem(id, fuel, controls)
    HeatingData = SpaceHeatingData.new(id)
    self.SetPrimarySystem(HeatingData, fuel, controls)
  end

  def SetPrimarySystem(SpaceHeatingSystem, fuel, controls)
    # TODO: if linked to water heating - wipe water heating...
    if _pMainPrimarySystem != nil then
      _pMainPrimarySystem = nil
    end
    _pMainPrimarySystem = SpaceHeatingSystem
    _validationController.RegisterComponent(_pMainPrimarySystem)
    _pMainPrimarySystem.SetSystemControls(controls)
    _pMainPrimarySystem.SetSystemFuel(fuel)
    # this is only required on the primary system for now (it's to deal with community heating schemes)
    _pMainPrimarySystem.SetCommunityHeatingLink(_communityHeatingData)
    self.ConfigureUnderheatingAssumptions()
    self.ConfigureHeatProvision()
  end

  def GetSystemPointer(systemIndex)
    # cast away const-ness (this is done to avoid having to repeat logic for whether to return
    # assumed system or *real* system based on under heating level.
    return (self.GetPrimarySystemData(systemIndex))
  end

  def GetSecondarySystemPointer()
    if _pSecondarySystem != nil then
      return (_pSecondarySystem)
    elsif _pAssumedSecondarySystem != nil then
      return (_pAssumedSecondarySystem)
    else
      return (nil)
    end
  end

  def AddSupplementalPrimarySystem(system, fuel, controls, fraction)
    pSystem = SpaceHeatingData.new(system)
    _validationController.RegisterComponent(pSystem)
    if pSystem.IsClass(HSC_COMMUNITY_HEATING) then
      pSystem = nil
      return (SIE10002_ILLEGAL_SUPPLEMENTARY_SYSTEM_DEFINED)
    end
    pSystem.SetSystemControls(controls)
    pSystem.SetSystemFuel(fuel)
    _supplementaryPrimarySystems.push_back(SupplementarySystem.new(fraction, pSystem))
    self.ConfigureHeatProvision()
    return (_supplementaryPrimarySystems.size())
  end

  def AddSupplementalPrimarySystem(id, fuel, controls, fraction)
    pSystem = SpaceHeatingData.new(id)
    _validationController.RegisterComponent(pSystem)
    pSystem.SetSystemFuel(fuel)
    pSystem.SetSystemControls(controls)
    _supplementaryPrimarySystems.push_back(SupplementarySystem.new(fraction, pSystem))
    self.ConfigureHeatProvision()
    return (_supplementaryPrimarySystems.size())
  end

  def SetFlueType(systemIndex, type)
    pSystem = self.GetSystemPointer(systemIndex)
    if pSystem == nil then
      return (SIE10001_INVALID_SYSTEM_INDEX)
    end
    pSystem.SetFlueType(type)
    return (SIE0000_NO_ERROR)
  end

  def SetControlFeatures(systemIndex, delayedStartThermostat, loadCompensation, weatherCompensation)
    pSystem = self.GetSystemPointer(systemIndex)
    pSystem.SetHasDelayedStartThermostat(delayedStartThermostat)
    pSystem.SetHasLoadCompensation(loadCompensation)
    pSystem.SetHasWeatherCompensation(weatherCompensation)
  end

  def SetSecondaryHeating(code, fuel, hetasApproved)
    if _pSecondarySystem != nil then
      _pSecondarySystem = nil
      _pSecondarySystem = nil
    end
    if code != HC_NONE then
      _pSecondarySystem = SpaceHeatingData.new(code)
      _validationController.RegisterComponent(_pSecondarySystem)
      _pSecondarySystem.SetHetasApproved(hetasApproved)
      _pSecondarySystem.SetSystemFuel(fuel)
    end
  end

  def SetWarmAirFanCount(systemIndex, count)
    pSystem = self.GetSystemPointer(systemIndex)
    if pSystem == nil then
      return (SIE10001_INVALID_SYSTEM_INDEX)
    end
    pSystem.SetWarmAirFanCount(count)
    return (0)
  end

  def SetDeclaredEfficiency(systemIndex, eff, isModulating)
    pSystem = self.GetSystemPointer(systemIndex)
    if pSystem == nil then
      return (SIE10001_INVALID_SYSTEM_INDEX)
    end
    pSystem.SetDeclaredEfficiency(eff, isModulating)
    return (SE00000_NO_ERROR)
  end

  def SetBoilerInterlock(systemIndex, hasBoilerInterlock)
    pSystem = self.GetSystemPointer(systemIndex)
    if pSystem != nil then
      pSystem.SetHasBoilerInterlock(hasBoilerInterlock)
    end
  end

  def ClearDeclaredEfficiency(systemIndex)
    pSystem = self.GetSystemPointer(systemIndex)
    if pSystem == nil then
      return (SIE10001_INVALID_SYSTEM_INDEX)
    end
    pSystem.ClearDeclaredEfficiency()
    return (SE00000_NO_ERROR)
  end

  def SetOnPeakElectricTariff(fuel)
    if Table12.GetFuelCategory(fuel) != FC_ELECTRIC then
      return (SIE10003_NON_ELECTRIC_FUEL_SUPPLIED_FOR_ELECTRIC_TARIFF)
    end
    # ensure on-peak electric has been specified (all electric fuels stored as on-peak)...
    fuel = Table12.GetOnPeakEquivalent(fuel)
    error = self.EnsureTariffConsistency(fuel)
    if error == SIE0000_NO_ERROR then
      _electricityTariff = fuel
    end
    return (error)
  end

  def EnsureTariffConsistency(fuel)
    electricSystems = List[SpaceHeatingData].new()
    error = SIE0000_NO_ERROR
    pCount = self.GetPrimarySystemCount()
    systemIndex = 0
    while systemIndex < pCount
      if self.ProcessElectricSystem(fuel, self.GetSystemPointer(systemIndex), electricSystems) == false then
        error = SIE10004_INCONSISTENT_ELECTRIC_TARIFF_SUPPLIED
        break
      end
      systemIndex += 1
    end
    pSecondary = self.GetSecondarySystemPointer()
    if (error == SIE0000_NO_ERROR) and (pSecondary != nil) then
      # so far so good... now check secondary
      if self.ProcessElectricSystem(fuel, pSecondary, electricSystems) == false then
        error = SIE10004_INCONSISTENT_ELECTRIC_TARIFF_SUPPLIED
      end
    end
    if error == SIE0000_NO_ERROR then
      _waterHeatingSystem.MakeTariffConsistent(fuel)
      it = electricSystems.GetEnumerator()
      while it.MoveNext()
        (it.Current).MakeTariffConsistent(fuel)
      end
      _electricityTariff = fuel
    end
    return (error)
  end

  def ProcessElectricSystem(fuel, pSystem, inconsistentList)
    result = pSystem.CheckTariffConsistency(fuel)
    if result == TCR_INCONSISTENT then
      inconsistentList.Add(pSystem)
    end
    return (result != TCR_CONFLICTING)
  end

  def SetCommunityDistributionLossFactor(lossFactor)
    _communityHeatingData.SetCalculatedDistributionLossFactor(lossFactor)
  end

  def SetHeatDistributionSystem(heatDistribution)
    _communityHeatingData.SetHeatDistributionSystem(heatDistribution)
  end

  def ConfigureMainHeatSource(fuel, fraction)
    _communityHeatingData.ConfigureMainHeatSource(fuel, fraction)
  end

  def AddAdditionalHeatSource(fuel, fraction, efficiency, isCHP, heatToPowerRatio)
    if isCHP then
      _communityHeatingData.CreateAdditionalHeatSource(fuel, fraction, efficiency, heatToPowerRatio)
    else
      _communityHeatingData.CreateAdditionalHeatSource(fuel, fraction, efficiency)
    end
    return (SE00000_NO_ERROR)
  end

  def ClearAdditionalHeatSources()
    _communityHeatingData.ClearHeatSources()
  end

  def IsSharedSpaceAndWaterHeatingCommunitySystem()
    return (_pMainPrimarySystem.GetClass() == HSC_COMMUNITY_HEATING and self.IsProvidingWaterHeating(_pMainPrimarySystem))
  end

  def GetPrimarySystemCount()
    return (_supplementaryPrimarySystems.size() + 1)
  end

  def IsUsingCalculatedDistributionLossFactor()
    return (_communityHeatingData.IsUsingCalculatedDistributionLossFactor())
  end

  def GetCalculatedDistributionLossFactor()
    return (_communityHeatingData.GetCalculatedDistributionLossFactor())
  end

  def GetHeatDistributionSystem()
    return (_communityHeatingData.GetHeatDistributionSystem())
  end

  def AssumedSecondaryHeating()
    if _pCalculationForcedElectricSystem != nil then
      return (true)
    else
      return (_pAssumedSecondarySystem != nil and self.GetSecondarySystemData() == _pAssumedSecondarySystem)
    end
  end

  def SetBoilerEquipmentLocation(systemIndex, waterPumpInHeatedSpace, fuelPump)
    pSystem = self.GetSystemPointer(systemIndex)
    if pSystem != nil then
      pSystem.SetWaterPumpInHeatedSpace(waterPumpInHeatedSpace)
      pSystem.SetFuelPumpType(fuelPump)
    end
  end

  def GetPrimarySystemData(systemIndex)
    if systemIndex == 0 then
      if _pAssumedPrimarySystem != nil then
        self._ASSERT(_underheatingDefinition.TestValue() and _underheatingDefinition.GetValue() == SUD_SEVERELY_UNDERHEATED)
        return (_pAssumedPrimarySystem)
      end
      return (_pMainPrimarySystem)
    elsif systemIndex == 2 then
      # Just return the last one - this is the case where a System has been substituted for a system supplying water
      # which can happen with an occupancy assessment.
      index = _supplementaryPrimarySystems.size() - 1
      if index >= 0 then
        return (_supplementaryPrimarySystems[index].pSystem)
      else
        return (nil)
      end
    else
      index = systemIndex - 1
      if index < _supplementaryPrimarySystems.size() then
        return (_supplementaryPrimarySystems[index].pSystem)
      else
        return (nil)
      end
    end
  end

  def GetPrimarySystemFraction(index)
    if index == 0 then
      fraction = 1.0
      cit = _supplementaryPrimarySystems.begin()
      while cit.MoveNext()
        fraction -= (cit.Current).fraction
      end
      return (fraction)
    else
      return (_supplementaryPrimarySystems[index - 1].fraction)
    end
  end

  def HasSecondarySystem()
    return (_pSecondarySystem != nil)
  end

  def GetSecondarySystemData()
    if _underheatingDefinition.TestValue() != false and _pSecondarySystem == nil then
      if _underheatingDefinition == SUD_SLIGHTLY_UNDERHEATED then
        # slight underheating and no secondary - assume portable electric heaters
        return (_pAssumedSecondarySystem)
      elsif _underheatingDefinition == SUD_SEVERELY_UNDERHEATED then
        return (_pAssumedSecondarySystem)
      elsif self.RequiresSupplementaryHeating() then
        return (_pAssumedSecondarySystem)
      end
    end
    if _pCalculationForcedElectricSystem != nil then
      return (_pCalculationForcedElectricSystem)
    end
    return (_pSecondarySystem)
  end

  def GetWaterHeatingSystemData()
    return (_waterHeatingSystem)
  end

  def GetHeatingPattern()
    return (_heatingPattern)
  end

  def GetOnPeakElectricTariff()
    if _pMainPrimarySystem.GetFuelCategory() == FC_ELECTRIC then
      return (Table12.GetOnPeakEquivalent(_pMainPrimarySystem.GetFuel()))
    elsif _electricityTariff.TestValue() then
      return (Table12.GetOnPeakEquivalent(_electricityTariff.GetValue()))
    else
      _validator.NotifyItem(VSC_ERROR, CVL_SPACE_HEATING, SE10012_ELECTRIC_METER_TYPE_MISSING, "Electricity tariff not specified (defaulted to standard)")
      return (F_ELEC_STANDARD)
    end
  end

  def IsProvidingWaterHeating(pSystem)
    return (pSystem != nil and _waterHeatingSystem.GetWaterHeatingSystem() == pSystem)
  end

  def HasBoilerInterlock(pSystem)
    interlock = pSystem.HasBoilerInterlock()
    if interlock.TestValue() then
      # can tell just from primary system
      return (interlock.GetValue())
    end
    # system unsure - use water info to work out
    if self.IsProvidingWaterHeating(pSystem) then
      if _waterHeatingSystem.GetCylinderInfo().HasThermostat() then
        # ok - there is a thermostat
        if pSystem.IsProvidingSpaceHeating() then
          interlock.SetValue(pSystem.HasRoomThermostat())
        else
          # hot water only so cylinder == enough for interlock
          interlock.SetValue(true)
        end
      else
        # no cylinderstat so we assume no interlock
        interlock.SetValue(false)
      end
    else
      # TODO: validation
      #_pValidator->NotifyItem(
      #	VSC_ERROR,
      #	CVL_SPACE_HEATING,
      #	SE10013_BOILER_INTERLOCK_SPECIFICATION_MISSING,
      #	"Client has failed to record whether a boiler interlock is present or not for this system - assuming no interlock");
      return (false)
    end
    return (interlock.GetValue())
  end

  def GetElectricCPSUSystem()
    pCandidate = _waterHeatingSystem.GetWaterHeatingSystem()
    if pCandidate != nil then
      if pCandidate.IsElectricCPSU() == false then
        pCandidate = nil
      end
    end
    return (pCandidate)
  end

  def SetWaterHeatingSystem(system, doubleSummerImmersion)
    # TODO: review this...
    pLinkedSys = nil
    if system == HWS_FROM_MAIN_SYSTEM then
      pLinkedSys = self.GetSystemPointer(0)
    elsif system == HWS_FROM_ALTERNATE_MAIN_SYSTEM then
      pLinkedSys = self.GetSystemPointer(1)
    elsif system == HWS_FROM_SECONDARY_SYSTEM then
      pLinkedSys = self.GetSecondarySystemPointer()
    elsif system == HWS_FROM_SUBSTITUTED_SYSTEM then
      pLinkedSys = self.GetSystemPointer(2)
    end
    #else if (system == HWS_COMMUNITY_BOILERS || system == HWS_COMMUNITY_CHP || system == HWS_COMMUNITY_HEATPUMP)
    #{
    #	// cannot have more than 1 heating system with community heating
    #	pLinkedSys = this->GetSystemPointer(0);
    #	// TODO: fail validation is pLinkedSys is *not* HSC_COMMUNITY
    #}
    tariff = (_electricityTariff.TestValue()) ? _electricityTariff.GetValue() : F_ELEC_STANDARD
    _waterHeatingSystem.SetSystemCode(system, tariff, pLinkedSys, doubleSummerImmersion)
  end

  def WaterHeatingSpecification()
    return (_waterHeatingSystem)
  end

  def SetSystemEmitters(index, type, pipeConfig)
    extraIdx = index > 0 ? _supplementaryPrimarySystems.size() : index
    pSystem = (extraIdx == 0) ? _pMainPrimarySystem : _supplementaryPrimarySystems[extraIdx - 1].pSystem
    pSystem.SetEmitters(type, pipeConfig)
  end

  def SetCalculationForcedElectricSecondary()
    _pCalculationForcedElectricSystem = SpaceHeatingData.new(HC_ELECRH_PORTABLE_HEATERS)
    _pCalculationForcedElectricSystem.SetSystemFuel((_electricityTariff.TestValue()) ? _electricityTariff : F_ELEC_STANDARD)
  end

  def CylinderSpecification()
    return (_waterHeatingSystem.CylinderSpecification())
  end

  def SolarWaterSpecification()
    return _waterHeatingSystem.SolarWaterSpecification()
  end

  def SetUnderheatingDefinition(def)
  _underheatingDefinition = def
  self.ConfigureUnderheatingAssumptions()
  end

  def ConfigureUnderheatingAssumptions()
    if _pAssumedSecondarySystem != nil then
      _pAssumedSecondarySystem = nil
      _pAssumedSecondarySystem = nil
    end
    if _pAssumedPrimarySystem != nil then
      _pAssumedPrimarySystem = nil
      _pAssumedPrimarySystem = nil
    end
    if self.RequiresSupplementaryHeating() then
      _pAssumedSecondarySystem = SpaceHeatingData.new(HC_ELECRH_PORTABLE_HEATERS)
      _pAssumedSecondarySystem.SetSystemFuel((_electricityTariff.TestValue()) ? _electricityTariff : F_ELEC_STANDARD)
    elsif _underheatingDefinition.TestValue() == false or _underheatingDefinition == SUD_NOT_UNDERHEATED then
    elsif 		# nothing to do
    _underheatingDefinition == SUD_SLIGHTLY_UNDERHEATED then
      # add an assumed secondary system (will only be used if no other secondary)
      _pAssumedSecondarySystem = SpaceHeatingData.new(HC_ELECRH_PORTABLE_HEATERS)
      _pAssumedSecondarySystem.SetSystemFuel((_electricityTariff.TestValue()) ? _electricityTariff : F_ELEC_STANDARD)
    elsif _underheatingDefinition == SUD_SEVERELY_UNDERHEATED then
      # if primary qualifies then switch primary to secondary and add portable heaters for primary, else add portable for secondary
      # BRE have specifies this swap can only happen if the primary system is a non-electric room heater
      # also don't swap if water heating is coming from the primary system (e.g. room heaters with back boiler)
      if _pMainPrimarySystem != nil and (_pMainPrimarySystem.IsClass(HSC_ROOM_HEATERS) and _pMainPrimarySystem.GetFuelCategory() != FC_ELECTRIC and self.IsProvidingWaterHeating(_pMainPrimarySystem) == false) or (_pMainPrimarySystem.IsClass(HSC_NOT_PRESENT)) then
        if not _pMainPrimarySystem.IsClass(HSC_NOT_PRESENT) then
          # create secondary system copy of main system
          _pAssumedSecondarySystem = SpaceHeatingData.new(_pMainPrimarySystem.GetHeatingCode())
          _pAssumedSecondarySystem.SetSystemFuel(_pMainPrimarySystem.GetFuel())
        end
        # create new "electric heaters" primary
        _pAssumedPrimarySystem = SpaceHeatingData.new(HC_ELECRH_PORTABLE_HEATERS)
        _pAssumedPrimarySystem.SetSystemFuel((_electricityTariff.TestValue()) ? _electricityTariff : F_ELEC_STANDARD)
        _pAssumedPrimarySystem.SetEmitters(SET_INTRINSIC, UPC_NO_UNDERFLOOR_PIPES)
        _pAssumedPrimarySystem.SetSystemControls(CG6_NO_CONTROLS)
        _pAssumedPrimarySystem.SetHasDelayedStartThermostat(false)
      else # can't switch
           # add an assumed secondary system (will only be used if no other secondary)
        _pAssumedSecondarySystem = SpaceHeatingData.new(HC_ELECRH_PORTABLE_HEATERS)
        _pAssumedSecondarySystem.SetSystemFuel((_electricityTariff.TestValue()) ? _electricityTariff : F_ELEC_STANDARD)
      end
    end
  end

  # TODO: else validation failure?
  def ConfigureHeatProvision()
    fraction = 1.0
    it = _supplementaryPrimarySystems.begin()
    while it.MoveNext()
      fraction -= (it.Current).fraction
      (it.Current).pSystem.SetIsProvidingSpaceHeating((it.Current).fraction > 0.0)
    end
    if _pMainPrimarySystem != nil then
      _pMainPrimarySystem.SetIsProvidingSpaceHeating(fraction > 0.0)
    end
  end

  def RequiresSupplementaryHeating()
    if _pMainPrimarySystem != nil then
      return (_pMainPrimarySystem.IsOffPeakOnlySystem())
    end
    return (false)
  end

  def SetDemandTemperature(Temp)
    _heatingPattern.SetDemandTemperature(Temp)
  end

  def SetZoneHeatingHours(zone, weekdayOff1, weekdayOff2, weekdayOff3, weekdayOff4, weekendOff1, weekendOff2, weekendOff3, weekendOff4)
    _heatingPattern.SetZoneHeatingHours(zone, weekdayOff1, weekdayOff2, weekdayOff3, weekdayOff4, weekendOff1, weekendOff2, weekendOff3, weekendOff4)
  end

  def IsAppendixGCombiUnit(SystemIndex)
    pSystem = self.GetPrimarySystemData(SystemIndex)
    if pSystem != nil then
      if pSystem.IsCombiSystem() then
        if not pSystem.GetKeepHotFacility().TestValue() or (pSystem.GetKeepHotFacility().TestValue() and pSystem.GetKeepHotFacility().GetValue() == KHF_NO_FACILITY) then
          return true
        else # no keep hot so may be an appendix g combi
          return false
        end
      else
        return false
      end
    end
    return false
  end

  def CheckForFGHRSSystem(index)
    pPrimary = self.GetPrimarySystemData(index)
    return pPrimary.GetPFGHRSIndex()
  end

end
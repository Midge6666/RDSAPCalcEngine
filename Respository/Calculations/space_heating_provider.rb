class SpaceHeatingProvider
  def initialize(pSystem, fraction, pSpaceRequirement, pWaterRequirement, pAppendixF, elecFuel)
    self.@_pSystem = pSystem
    self.@_fraction = fraction
    self.@_elecFuel = elecFuel
    self.@_pEfficiencyCalculator = nil
    self.@_pPrimaryFuel = nil
    self.@_pAppendixN = nil
    self.@_pAppendixF = pAppendixF
    self.Initialise(pSpaceRequirement, pWaterRequirement, true)
  end

  def initialize(pSystem, fraction, pSpaceRequirement, pWaterRequirement, pAppendixF, elecFuel)
    self.@_pSystem = pSystem
    self.@_fraction = fraction
    self.@_elecFuel = elecFuel
    self.@_pEfficiencyCalculator = nil
    self.@_pPrimaryFuel = nil
    self.@_pAppendixN = nil
    self.@_pAppendixF = pAppendixF
    self.Initialise(pSpaceRequirement, pWaterRequirement, true)
  end

  def initialize(pSystem, fraction, pSpaceRequirement, pWaterRequirement, pAppendixF, elecFuel)
    self.@_pSystem = pSystem
    self.@_fraction = fraction
    self.@_elecFuel = elecFuel
    self.@_pEfficiencyCalculator = nil
    self.@_pPrimaryFuel = nil
    self.@_pAppendixN = nil
    self.@_pAppendixF = pAppendixF
    self.Initialise(pSpaceRequirement, pWaterRequirement, true)
  end

  def Initialise(pSpaceRequirement, pWaterRequirement, isPrimary)
    _pCHPElectricalEfficiency = 0.0
    _isPrimary = isPrimary
    enumerator = .GetEnumerator()
    while enumerator.MoveNext()
      = enumerator.Current
    end

  end

  def Initialise(pSpaceRequirement, pWaterRequirement, isPrimary)
    _pCHPElectricalEfficiency = 0.0
    _isPrimary = isPrimary
    enumerator = .GetEnumerator()
    while enumerator.MoveNext()
      = enumerator.Current
    end

  end

  def initialize()
    # NOTE: WARM AIR SYSTEMS ARE HANDLED BY THE ENGINE BECAUSE THEY ARE NOT SYSTEM INDEPENDANT BUT
    #		 ARE BASED ON THE VOLUME OF THE BUILDING
    # create fuel usage for providing the heating
    # work out the off-peak fraction...
    # must be a electric CPSU - use appendix F in preference to table12
    #If the fuel is multifuel there mayvbe bill data for both Wood logs and Coal so we need to seperate the fuel useage here
    #They should always both be true if one is tru
    #Derived from OA-3 - even if no bill data we split to house coal and wood logs
    # note: no efficiency is applied for CH! Strange but that's how SAP seems to work # apply tabl4c   (control and method)
    # community heating can have multiple heat sources
    @pCH = _pSystem.GetCommunityHeatingData()
    @heatSourceCount = @pCH.GetHeatSourceCount()
  end

  def GetEfficiencyCalculator()
    return (_pEfficiencyCalculator)
  end

  def GetPrimaryFuelUnitCost()
    if _pPrimaryFuel != nil then
      return (_pPrimaryFuel.GetCost(CV_AVERAGE))
    else
      return (0.0)
    end
  end

  def GetPrimaryFuelUnitEmissions()
    if _pPrimaryFuel != nil then
      return (_pPrimaryFuel.GetEmissions())
    else
      return (0.0)
    end
  end

  def Dispose()
    self.Clear()
    if _pEfficiencyCalculator != nil then
      _pEfficiencyCalculator = nil
      _pEfficiencyCalculator = nil
    end
    _pPrimaryFuel = nil
  end

  def Clear()
    self.DeleteAndClearVector(_heatSources)
  end

  def ApplyTable12c(pTable12c)
    _pTable12c = pTable12c
  end

  def Calculate(pRegister, pOccupancy)
    if _fraction == 0.0 then
      _requiredFuel.SetAllMonths(0.0)
      return
    end
    if _pSystem.IsClass(HSC_COMMUNITY_HEATING) then
      self.CalculateCommunityFuelUseage(pRegister)
    else
      self.CalculateIndividualFuelUseage(pRegister, pOccupancy)
    end
    self.CheckAncillaryFanElectricity(pRegister)
  end

  def CalculateIndividualFuelUseage(pRegister, pOccupancy)
    if _pAppendixN != nil then
      eff = _pAppendixN.GetSpaceHeatingEfficiency()
    else
      eff = _pEfficiencyCalculator.GetSpaceHeatingEfficiency()
    end
    it = Year.Begin()
    while it != Year.End()
      v = _energyRequirement.GetMonthResult() / eff
      _requiredFuel.SetMonthResult(, v)
      it += 1
    end
    cat = _isPrimary ? FU_SPACE_HEATING : FU_SPACE_HEATING_SECONDARY
    if _pSystem.GetFuelCategory() == FC_ELECTRIC then
      onpeakFuel = Table12.GetOnPeakEquivalent(_pSystem.GetFuel())
      offpeakFuel = Table12.GetOffPeakEquivalent(onpeakFuel)
      if _pAppendixF != nil then
        _pAppendixF.CalculateTariffSplit(_requiredFuel, onpeakRequirement, offpeakRequirement)
        _pPrimaryFuel = pRegister.AddFuelUsage(cat, FUS_PRIMARY_PROVISION, onpeakFuel, onpeakRequirement, self, "Provision of space heating (high rate)")
        pRegister.AddFuelUsage(cat, FUS_PRIMARY_PROVISION, offpeakFuel, offpeakRequirement, self, "Provision of space heating (low rate)")
      else
        onpeakFraction = Table12a.GetSpaceHeaingOnPeakFraction(_pSystem, _pAppendixN)
        offpeakFraction = 1.0 - onpeakFraction
        requirement = _requiredFuel.GetYearResult()
        _pPrimaryFuel = pRegister.AddFuelUsage(cat, FUS_PRIMARY_PROVISION, onpeakFuel, requirement * onpeakFraction, self, "Provision of space heating (high rate)")
        pRegister.AddFuelUsage(cat, FUS_PRIMARY_PROVISION, offpeakFuel, requirement * offpeakFraction, self, "Provision of space heating (low rate)")
      end
    else
      if pOccupancy != nil and pOccupancy.IsGreenDealOccupancy(BILL_RECONCILIATION) and _pSystem.GetFuel() == F_DUAL_FUEL then
        billDataVect = pOccupancy.GetBillData()
        woodFound = false
        mineralFound = false
        woodFuel = SAP_FUELS.new()
        mineralFuel = SAP_FUELS.new()
        it = billDataVect.begin()
        while it != billDataVect.end()
          if (it).GetFuel() == F_WOOD_LOGS or (it).GetFuel() == F_WOOD_CHIPS or (it).GetFuel() == F_WOOD_PELLETS_BAGGED or (it).GetFuel() == F_WOOD_PELLETS_BULK then
            woodFound = true
            woodFuel = (it).GetFuel()
          end
          if (it).GetFuel() == F_HOUSECOAL or (it).GetFuel() == F_ANTHRACITE or (it).GetFuel() == F_SMOKELESS then
            mineralFound = true
            mineralFuel = (it).GetFuel()
          end
          it += 1
        end
        if mineralFound and woodFound then
          requiredFuel = _requiredFuel.GetYearResult()
          _pPrimaryFuel = pRegister.AddFuelUsage(cat, FUS_PRIMARY_PROVISION, woodFuel, requiredFuel / 2, self, "Provision of space heating")
          _pPrimaryFuel = pRegister.AddFuelUsage(cat, FUS_PRIMARY_PROVISION, mineralFuel, requiredFuel / 2, self, "Provision of space heating")
        else
          requiredFuel = _requiredFuel.GetYearResult()
          _pPrimaryFuel = pRegister.AddFuelUsage(cat, FUS_PRIMARY_PROVISION, F_WOOD_LOGS, requiredFuel / 2, self, "Provision of space heating")
          _pPrimaryFuel = pRegister.AddFuelUsage(cat, FUS_PRIMARY_PROVISION, F_HOUSECOAL, requiredFuel / 2, self, "Provision of space heating")
        end
      else
        _pPrimaryFuel = pRegister.AddFuelUsage(cat, FUS_PRIMARY_PROVISION, _pSystem.GetFuel(), _requiredFuel.GetYearResult(), self, "Provision of space heating")
      end
    end
  end

  def CalculateCommunityFuelUseage(pRegister)
    controlChargeFactor = _pEfficiencyCalculator.GetControlChargeFactorSH()
    lossFactor = _pTable12c.GetLossFactor()
    enumerator = .GetEnumerator()
    while enumerator.MoveNext()
      = enumerator.Current
    end

    _requiredFuel.SetMonthResult(month, v * lossFactor * controlChargeFactor)
  end

  def CheckAncillaryCHPumpElectricity()
    #	bool result = false;
    #	SAP_FUELS offpeakFuel = Table12::GetOffPeakEquivalent(_elecFuel);
    #	double onPeakFraction = Table12a::GetLightingOnPeakFraction(_elecFuel);
    #	double offPeakFraction = 1.0 - onPeakFraction;
    # Appendix N states that pumps included in the test data should not be included in internal gains or electricity consumed, so effectively they're not here
    if _pSystem.IsFromProductDatabase() and (_pSystem.IsMicrogenSystem() or _pSystem.IsHeatpump()) and _pSystem.GetAppendixNInterfaceRecord().IsSeperateCirculatorIncludedInTestData() then
      _waterPumpElec = 0.0
    else
      _waterPumpElec = Table4f.GetWaterPumpElectricity(_pSystem.IsProvidingSpaceHeating(), _pSystem)
    end
    #		if (_waterPumpElec > 0.0)
    #		{
    #			pRegister->AddFuelUsage(FU_SPACE_HEATING, FUS_ANCILLARY_REQUIREMENT, _elecFuel, (_waterPumpElec * onPeakFraction), this, "central heating - water pump (high rate)");
    #			pRegister->AddFuelUsage(FU_SPACE_HEATING, FUS_ANCILLARY_REQUIREMENT, offpeakFuel, (_waterPumpElec * offPeakFraction), this, "central heating - water pump (low rate)");
    #			result = true;
    #		}
    return (_waterPumpElec)
  end

  def CheckAncillaryOilPumpElectricity(pRegister)
    result = false
    offpeakFuel = Table12.GetOffPeakEquivalent(_elecFuel)
    onPeakFraction = Table12a.GetLightingOnPeakFraction(_elecFuel)
    offPeakFraction = 1.0 - onPeakFraction
    if _pSystem.IsFromProductDatabase() and (_pSystem.IsMicrogenSystem() or _pSystem.IsHeatpump()) then
      _oilPumpElec = 0.0
    else
      _oilPumpElec = Table4f.GetOilPumpElectricty(_pSystem.IsProvidingSpaceHeating(), _pSystem)
    end
    if _oilPumpElec > 0.0 then
      pRegister.AddFuelUsage(FU_SPACE_HEATING, FUS_ANCILLARY_REQUIREMENT, _elecFuel, (_oilPumpElec * onPeakFraction), self, "oil boiler - fuel pump (high rate)")
      pRegister.AddFuelUsage(FU_SPACE_HEATING, FUS_ANCILLARY_REQUIREMENT, offpeakFuel, (_oilPumpElec * offPeakFraction), self, "oil boiler - fuel pump (low rate)")
      result = true
    end
    return (result)
  end

  def CheckAncillaryFanElectricity(pRegister)
    #Added on peak and off peak for this fan to fix rdsap example 43
    offpeakFuel = Table12.GetOffPeakEquivalent(_elecFuel)
    onPeakFraction = Table12a.GetLightingOnPeakFraction(_elecFuel)
    offPeakFraction = 1.0 - onPeakFraction
    _fanFuelElec = Table4f.GetFanFlueElectricity(_pSystem)
    if _fanFuelElec > 0.0 then
      pRegister.AddFuelUsage(FU_SPACE_HEATING, FUS_ANCILLARY_REQUIREMENT, _elecFuel, (_fanFuelElec * onPeakFraction), self, "boiler - fan flue (high rate)")
      pRegister.AddFuelUsage(FU_SPACE_HEATING, FUS_ANCILLARY_REQUIREMENT, offpeakFuel, (_fanFuelElec * offPeakFraction), self, "boiler - fan flue (low rate)")
    end
  end

end
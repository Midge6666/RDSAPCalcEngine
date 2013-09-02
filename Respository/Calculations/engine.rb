class Engine
  def initialize()
    self.@_fuelDataRecord =  < type
    # engine context needs setting 1st so it can be passed into other classes
    _pContext = EngineContext.new()
    _pContext.Mode.SetEngineCalcMode(EM_SAP_CALC)
    _fuelUsageRegister = FuelUsageRegister.new(_fuelDataRecord, _pContext)
    # these shouldn't be new'ed imo - should be attributes
    _pDimensions = DwellingDimensions.new(_pContext)
    _pDwellingInfo = DwellingInfo.new()
    _pVentilationData = VentilationData.new()
    _pStructuralData = StructuralData.new()
    _pHeatingData = HeatingSystemData.new()
    _pfeedInTariffTable = FeedInTariffTable.new()
    _pTotalHeatLosses = nil
    _pTotalGains = nil
    _pWaterHeatingRequirement = nil
    _pSpaceHeatingRequirements = nil
    _pSpaceCoolingRequirements = nil
    _pAppendixD = nil
    _pAppendixF = nil
    _pAppendixL = nil
    _pAppendixM = nil
    _pAppendixN = nil
    _pTable12c = nil
    _pPrimaryProviderA = nil
    _pPrimaryProviderB = nil
    _pSecondaryProvider = nil
    _pWaterProvider = nil
    _pSapCalculation = nil
    _pCo2Calculation = nil
    _pOccupancy = nil
    _validationController.RegisterComponent(_pHeatingData)
    _validationController.RegisterComponent(_pStructuralData)
    self.SetEngineLinks(true)
  end

  def Dispose()
    self.ClearResults()
    self.CleanEngine()
  end

  def SetEngineMode(mode)
    _pContext.Mode = mode
  end

  def GetEngineResultsArray(Link)
    return _pContext.EngineLink.RetrieveArrayLink(Link)
  end

  def GetEngineResultsSingle(Link)
    return _pContext.EngineLink.RetrieveSingleLink(Link)
  end

  def GetEngineResultsSingleNullable(Link)
    return _pContext.EngineLink.RetrieveSingleNullableLink(Link)
  end

  def GetEngineResultsSingle(Link, Index)
    return _pContext.EngineLink.RetrieveSingleLink(Link, Index)
  end

  def GetEngineResultsSingle(Link, Element, Index)
    return _pContext.EngineLink.RetrieveSingleLink(Link, Element, Index)
  end

  def GetEngineResultsGlazingSingle(Link, Element, Index)
    return _pContext.EngineLink.RetrieveSingleLink(Link, Element, Index)
  end

  def GetEngineResultsGlazingArray(Link, Orientation, Index)
    return _pContext.EngineLink.RetrieveArrayLink(Link, Orientation, Index)
  end

  def PerformCalc(useStandardOccupancy)
    self.ClearResults()
    # first validate that the input data is correct
    if self.ValidateEngineInputs(nil) == false then
      _headlineResults.IsValid = SEE_UNSPECIFIED_ERROR
      return
    end
    self.SetPCodeRhiRegion()
    # If nothing has passing in occupancy data then the object will not have been constructed, do it now and let it use defaults
    if _pOccupancy == nil then
      # move the table1b paramter to the class constructor
      _pOccupancy = Occupancy.new(Table1b.Lookup(_pDimensions.GetTotalFloorArea()))
    else
      _pOccupancy.SetStandardOccupants(Table1b.Lookup(_pDimensions.GetTotalFloorArea()))
    end
    # determine which tariff to use for any ancillary or water heating electricity...
    elecTariff = _pHeatingData.GetOnPeakElectricTariff()
    if _pOccupancy != nil and _pOccupancy.IsGreenDealOccupancy(BILL_RECONCILIATION) then
      if not useStandardOccupancy then
        _fuelDataRecord.SetOccupancy(_pOccupancy, useStandardOccupancy)
      else
        #GreenDealOccProvider* pGreenDealOccProvider = new GreenDealOccProvider(_pContext);
        #elecTariff = pGreenDealOccProvider->GetTariffFromBills(_pOccupancy, elecTariff);
        _fuelDataRecord.SetOccupancy(_pOccupancy, useStandardOccupancy)
      end
    end
    #_fuelDataRecord.UnsetOccupancy(_pOccupancy);
    #When doing occupancy calcs we need to keep the use the RdSAP chimney/Flue counts and not substitued systems
    primary1Flue = 0
    primary2Flue = 0
    secondaryFlue = 0
    totalFlues = 0
    if _pOccupancy != nil and _pOccupancy.GetFluesSet() then
      _pOccupancy.GetFlues(primary1Flue, primary2Flue, secondaryFlue)
    else
      _pHeatingData.GetFlues(primary1Flue, primary2Flue, secondaryFlue)
    end
    totalFlues = primary1Flue + primary2Flue + secondaryFlue
    _primary1FlueCount = primary1Flue
    _primary2FlueCount = primary2Flue
    _secondaryFlueCount = secondaryFlue
    # now the engine is ready to start the calculations - first define the heat losses
    _pTotalHeatLosses = TotalHeatLoss.new(_pContext)
    _pTotalHeatLosses.Calculate(_pVentilationData, _pDimensions, _pStructuralData, _pHeatingData, totalFlues, _pHeatingData.GetChimneyCount())
    _pAppendixN = AppendixN.CreateAppendixN(_pHeatingData, _pTotalHeatLosses, _pDimensions, _pVentilationData, _pDwellingInfo)
    if _pAppendixN != nil and _pAppendixN.IsValid() == false then
      # engine failure - specified heatpump or mCHP unit is incapable of providing sufficienct output
      # for this dwelling
      _headlineResults.IsValid = SEE_INVALID_PSR_RATIO
      return
    end
    WWHRSIndex1 = _pDwellingInfo.GetWWHRSIndex(0)
    WWHRSIndex2 = _pDwellingInfo.GetWWHRSIndex(1)
    if WWHRSIndex1.TestValue() or WWHRSIndex2.TestValue() then
      if _pAppendixG == nil then
        _pAppendixG.reset(AppendixG.new(_pContext))
      end
      _pAppendixG.SetWWHRSIndex(WWHRSIndex1, WWHRSIndex2)
      _pAppendixG.CalculateWWHRS(_pDwellingInfo.GetNumBathAndShower(), _pDwellingInfo.GetNumShowersWithWWHRS1AndBath(), _pDwellingInfo.GetNumShowersWithWWHRS1NoBath(), _pDwellingInfo.GetNumShowersWithWWHRS2AndBath(), _pDwellingInfo.GetNumShowersWithWWHRS2NoBath(), _pOccupancy)
    end
    _pWaterHeatingRequirement = WaterHeatingEnergyRequirement.new(_pContext)
    _pWaterHeatingRequirement.Calculate(_pDimensions, _pHeatingData.GetWaterHeatingSystemData(), _pAppendixN, _pOccupancy, _pAppendixG.get(), _pDwellingInfo)
    if _pAppendixN != nil then
      _pAppendixN.SetVesselHeatLoss(_pWaterHeatingRequirement.GetDailyStorageLossFactor())
    end
    _pAppendixL = AppendixL.new(_pOccupancy, _pDimensions, _pDwellingInfo, _pStructuralData, _pContext)
    _pAppendixM = AppendixM.new(_pDwellingInfo, _pContext, _pfeedInTariffTable)
    _pTotalGains = TotalGains.new(_pContext)
    _pTotalGains.Calculate(_pDimensions, _pStructuralData, _pOccupancy, _pVentilationData.GetMechanicalVentilationInfo(), _pHeatingData, _pAppendixL, _pWaterHeatingRequirement, _pDwellingInfo)
    _pSpaceHeatingRequirements = SpaceHeatingRequirement.new(_pContext, _pOccupancy)
    _validationController.RegisterComponent(_pSpaceHeatingRequirements)
    _pSpaceHeatingRequirements.Calculate(_pTotalHeatLosses, _pTotalGains.GetTotalGains(), _pDimensions, _pDwellingInfo, _pHeatingData, (_pContext.Mode.GetEngineCalcMode() == EM_RHI_CALC or _pContext.Mode.GetRuleSet() == ERS_CENTRICA or _pContext.Mode.GetEngineCalcMode() == EM_REGIONAL_CALC) ? Table8.Instance().GetValues(_pDwellingInfo.GetRhiRegion().GetValue()) : Table8.Instance().GetValues(), _pAppendixN, _pTotalGains.GetTotalSolarGains()) # For external temperatures the values from table 8 change depending on which calc type you use
    _pSpaceCoolingRequirements = SpaceCoolingRequirement.new(_pContext)
    _pSpaceCoolingRequirements.Calculate()
    pElectricCPSU = _pHeatingData.GetElectricCPSUSystem()
    if pElectricCPSU != nil then
      # there is a electric CPSU in the property delivering space heating and hot water
      _pAppendixF = AppendixF.new(_pContext)
      _pAppendixF.Calculate(_pTotalHeatLosses, _pSpaceHeatingRequirements, _pWaterHeatingRequirement, _pHeatingData.GetWaterHeatingSystemData(), (_pContext.Mode.GetEngineCalcMode() == EM_RHI_CALC or _pContext.Mode.GetRuleSet() == ERS_CENTRICA or _pContext.Mode.GetEngineCalcMode() == EM_REGIONAL_CALC) ? Table8.Instance().GetValues(_pDwellingInfo.GetRhiRegion().GetValue()) : Table8.Instance().GetValues())
    end
    # Now up to section 9a/b
    pSecondary = _pHeatingData.GetSecondarySystemData()
    # for each space heating system create a space heating provider - this space heating provider will do three things
    #		1) calculate the fuel requirements for providing the specified heat
    #		2) calculate any additional electricity requirements for providing the heat
    #		3) calculate any additional electricity production for providing the heat (CHP)
    # In the case of MicroCHP/Heatpump systems the PSR can be used to determine whether a secondary system is required
    # BOX(201)
    if _pAppendixN != nil then
      # Note: This is done for Occupancy assessment for both - Standard occupancy and using OA Data.
      # if (_pOccupancy != NULL && _pOccupancy->IsGreenDealOccupancy((int)ENERGY_FOR_WATER_HEATING))
      # {
      # _secondayFraction = _pOccupancy->CalculateOccAssessmentSecondaryHeatingFraction(_pHeatingData, _pAppendixN);
      # }
      # else
      # {
      # _secondayFraction = _pAppendixN->GetSecondaryFraction(_pHeatingData);
      # }
      _secondayFraction = _pAppendixN.GetSecondaryFraction(_pHeatingData)
      if _secondayFraction > 0.0 and _pHeatingData.GetSecondarySystemData() == nil then
        # no secondary system but appendix N has determined that the heatpump / microCHP system
        # is not powerful enough to provide all heating requirement by itself... therefore the
        # engine needs to add portable electric heating
        _pHeatingData.SetCalculationForcedElectricSecondary()
      end
    else
      if _pOccupancy != nil and _pOccupancy.IsGreenDealOccupancy(ENERGY_FOR_WATER_HEATING) then
        _secondayFraction = _pOccupancy.CalculateOccAssessmentSecondaryHeatingFraction(_pHeatingData, _pAppendixN)
      else
        _secondayFraction = Table11.GetSecondaryFraction(_pHeatingData.GetPrimarySystemData(0), _pHeatingData.GetSecondarySystemData())
      end
    end
    # BOX(202)
    _mainFraction = (1.0 - _secondayFraction)
    # create water heating link here, if the water heating is processed as part of the heating system loop (i.e. water
    # heating is coming from space heater then <pEfficiencyCalculator> will be non-NULL, otherwise it should be calculated
    # independatly
    pEfficiencyCalculator = nil
    # Initiliazing all these now so they can be accumulated during the calc
    _waterPumpElec = 0.0
    _oilPumpElec = 0.0
    _fanFuelElec = 0.0
    # how much electricity is the CH pump using
    chPumpElec = 0.0
    oilPumpIsSet = false
    waterHeatingFromBoiler = false
    communityDistLossFactorSH = 1.0
    communityDistLossFactorWH = 1.0
    cHPElectricalEfficiency = 0.0
    systemIndex = 0
    while systemIndex < _pHeatingData.GetPrimarySystemCount()
      pSystem = _pHeatingData.GetPrimarySystemData(systemIndex)
      # BOX(204-205)
      fraction = 0
      # Note if OA - we do this for both Standard Occupancy and using OA Data.
      if (_pOccupancy != nil and _pOccupancy.IsGreenDealOccupancy(ENERGY_FOR_WATER_HEATING) and _pAppendixN == nil) then #appendix N rules all
        fraction = _pOccupancy.CalculateOccAssessmentMainHeatingFraction(systemIndex, _pHeatingData, _pAppendixN, false)
      else
        fraction = _pHeatingData.GetPrimarySystemFraction(systemIndex) * _mainFraction
      end
      systemIndex == 0 ? _fractionFromMainSystem1 = fraction : _fractionFromMainSystem2 = fraction
      AppendixNToUse = systemIndex == 0 ? _pAppendixN : nil
      if AppendixNToUse != nil then
        # Appendix N needs stuff setup based on space heating requirement
        it = Year.Begin()
        while it != Year.End()
          _pAppendixN.SetQSpace((), _pSpaceHeatingRequirements.GetSpaceHeatingRequirement() * fraction)
          it += 1
        end
      end
      # Determine whether a FGHRS system has been selected and is attached to this system
      FGHRSIndex = N[System::String].new()
      if _pDwellingInfo.GetFGHRSIndex().TestValue() then
        whichSystem = _pDwellingInfo.GetFGHRSWhichSystem()
        if whichSystem == systemIndex then
          FGHRSIndex = _pDwellingInfo.GetFGHRSIndex()
        end
      end
      if FGHRSIndex.TestValue() then
        if _pAppendixG == nil then
          _pAppendixG.reset(AppendixG.new(_pContext))
        end
        _pAppendixG.SetFGHRSIndex(FGHRSIndex)
        PVData = _pDwellingInfo.FGHRSPhotoVoltaicSpecification()
        if PVData.GetPeakPower() > 0 then
          _pAppendixG.SetPVSettings(PVData.GetPeakPower(), PVData.GetCollectorTilt(), PVData.GetCollectorOrientation(), PVData.GetOvershading())
        end
      end
      if _pAppendixG != nil then
        if FGHRSIndex.TestValue() then
          KeepHotFacility = false
          if pSystem.GetKeepHotFacility().TestValue() and (pSystem.GetKeepHotFacility().GetValue() == KHF_NO_TIME_CONTROL or pSystem.GetKeepHotFacility().GetValue() == KHF_WITH_TIME_CONTROL) then
            KeepHotFacility = true
          end
          _pAppendixG.Calculate(_pWaterHeatingRequirement, _pSpaceHeatingRequirements, fraction, _pHeatingData.IsAppendixGCombiUnit(systemIndex), KeepHotFacility, pSystem)
          _pWaterHeatingRequirement.ApplyAppendixGEffectToWaterHeater(_pAppendixG.GetSmResult())
        end
      end
      pProvider = nil
      if pSystem.IsElectricCPSU() then
        # special constructor for CPSUs
        pProvider = SpaceHeatingProvider.new(pSystem, fraction, _pSpaceHeatingRequirements, _pWaterHeatingRequirement, _pAppendixF, elecTariff)
      elsif _pHeatingData.IsProvidingWaterHeating(pSystem) then
        # use the space and water heating constructor
        waterHeatingFromBoiler = true
        pProvider = SpaceHeatingProvider.new(pSystem, fraction, _pSpaceHeatingRequirements, _pWaterHeatingRequirement, AppendixNToUse, elecTariff, true)
      else
        # use the space heating only constructor
        pProvider = SpaceHeatingProvider.new(pSystem, fraction, _pSpaceHeatingRequirements, AppendixNToUse, elecTariff, true)
      end
      if pSystem.IsClass(HSC_COMMUNITY_HEATING) then
        self.CreateTable12c()
        pProvider.ApplyTable12c(_pTable12c)
        communityDistLossFactorSH = _pTable12c.GetLossFactor()
      end
      pProvider.Calculate(_fuelUsageRegister, _pOccupancy)
      _calculators.push_back(pProvider)
      cHPElectricalEfficiency = pProvider.GetCHPElectricalEfficiency()
      # only one central heating pump should be counted in the dwelling even if two boilers, however (see TC19 after improvement G)
      # always use the worst case of the electricity demand for CH pump (i.e. if one sys has roomstat it's not good enough)
      elec = pProvider.CheckAncillaryCHPumpElectricity()
      if elec > chPumpElec then
        chPumpElec = elec
      end
      # NOTE: It appears that unlike multiple oil pumps can be present though looking at rdsap2009 example 17
      oilPumpIsSet = pProvider.CheckAncillaryOilPumpElectricity(_fuelUsageRegister)
      if _pHeatingData.IsProvidingWaterHeating(pSystem) then
        # as heating system is providing how water store the efficiency calculator used during space heating
        # in local variable - this will then be re-used by the water heating provider
        pEfficiencyCalculator = pProvider.GetEfficiencyCalculator()
      end
      # I don't want these efficiencies being linked as decimals since the worksheet displays the full precent value.
      systemIndex == 0 ? _efficiencyMainSystem1 = pProvider.GetEfficiencyCalculator().GetSpaceHeatingEfficiency() * 100.0 : _efficiencyMainSystem2 = pProvider.GetEfficiencyCalculator().GetSpaceHeatingEfficiency() * 100.0
      systemIndex == 0 ? _mainSystem1SpaceFuelUseage = pProvider.GetRequiredFuel() : _mainSystem2SpaceFuelUseage = pProvider.GetRequiredFuel()
      #_waterPumpElec.SetValue(_waterPumpElec.GetValue() + pProvider->GetWaterPumpElec());
      _waterPumpElec.SetValue(chPumpElec)
      _oilPumpElec.SetValue(_oilPumpElec.GetValue() + pProvider.GetOilPumpElec())
      _fanFuelElec.SetValue(_fanFuelElec.GetValue() + pProvider.GetFanFuelElec())
      if _pPrimaryProviderA == nil then
        _pPrimaryProviderA = pProvider
      else
        _pPrimaryProviderB = pProvider
      end
      systemIndex += 1
    end
    # now add in the CH pump elec
    if chPumpElec > 0.0 then
      if Table12.IsSplitTariffFuel(elecTariff) then
        offpeakFuel = Table12.GetOffPeakEquivalent(elecTariff)
        onPeakFraction = Table12a.GetLightingOnPeakFraction(elecTariff)
        offPeakFraction = 1.0 - onPeakFraction
        _fuelUsageRegister.AddFuelUsage(FU_SPACE_HEATING, FUS_ANCILLARY_REQUIREMENT, elecTariff, (chPumpElec * onPeakFraction), nil, "central heating - water pump (high rate)")
        _fuelUsageRegister.AddFuelUsage(FU_SPACE_HEATING, FUS_ANCILLARY_REQUIREMENT, offpeakFuel, (chPumpElec * offPeakFraction), nil, "central heating - water pump (low rate)")
      else
        _fuelUsageRegister.AddFuelUsage(FU_SPACE_HEATING, FUS_ANCILLARY_REQUIREMENT, elecTariff, chPumpElec, nil, "central heating - water pump")
      end
    end
    # **************************************
    # sort out secondary heating system
    # **************************************
    if _secondayFraction > 0.0 then
      pSystem = _pHeatingData.GetSecondarySystemData()
      pProvider = nil
      if _pHeatingData.IsProvidingWaterHeating(pSystem) then
        pProvider = SpaceHeatingProvider.new(pSystem, _secondayFraction, _pSpaceHeatingRequirements, _pWaterHeatingRequirement, _pAppendixN, elecTariff, false)
        pProvider.Calculate(_fuelUsageRegister, _pOccupancy)
        # can't have two heating systems - both providing hot water!
        self._ASSERT(pEfficiencyCalculator == nil)
        pEfficiencyCalculator = pProvider.GetEfficiencyCalculator()
      else #if (useStandardOccupancy)
        pProvider = SpaceHeatingProvider.new(pSystem, _secondayFraction, _pSpaceHeatingRequirements, nil, elecTariff, false)
        pProvider.Calculate(_fuelUsageRegister, _pOccupancy)
      end
      if pProvider != nil then
        _calculators.push_back(pProvider)
        _secondaryEfficiency = pProvider.GetEfficiencyCalculator().GetSpaceHeatingEfficiency() * 100.0
        _secondarySpaceFuelUseage = pProvider.GetRequiredFuel()
        _pSecondaryProvider = pProvider
      end
    else
      # if secondary heating has no fraction then it may be redundant, if this is the case add a zero entry into the fuel register as it may still have a standing charge if its present
      pSystem = _pHeatingData.GetSecondarySystemData()
      if pSystem != nil and pSystem.GetHeatingCode() != HC_NONE and pSystem.GetHeatingCode() != HC_UNKNOWN then
        _fuelUsageRegister.AddFuelUsage(FU_SPACE_HEATING_SECONDARY, FUS_PRIMARY_PROVISION, pSystem.GetFuel(), 0.0, nil, "Provision of space heating")
      end
    end
    pWaterProvider = WaterHeatingProvider.new(_pContext)
    pWaterSys = _pHeatingData.GetWaterHeatingSystemData()
    pWaterProvider.PrepareForCalculation(pWaterSys, _pWaterHeatingRequirement, pEfficiencyCalculator, _pAppendixF, _pAppendixN, _pOccupancy, elecTariff)
    if pWaterSys.IsFromCommunityHeating() then
      self.CreateTable12c()
      pWaterProvider.ApplyTable12c(_pTable12c)
      communityDistLossFactorWH = _pTable12c.GetLossFactor()
    end
    pWaterProvider.Calculate(_fuelUsageRegister)
    _calculators.push_back(pWaterProvider)
    averageWaterEfficiency = 0.0
    _waterEfficiencyByMonth = pWaterProvider.GetEfficiencyCalculator().GetWaterHeatingEfficiency()
    # The efficiencies are stored as decimals but worksheet wants real numbers so each month needs to be converted
    enumerator = .GetEnumerator()
    while enumerator.MoveNext()
      = enumerator.Current
    end

    averageWaterEfficiency += _waterEfficiencyByMonth.GetMonthResult(month)
  end

  def CreateTable12c()
    if _pTable12c == nil then
      if _pHeatingData.IsUsingCalculatedDistributionLossFactor() then
        _pTable12c = Table12c.new(_pHeatingData.GetCalculatedDistributionLossFactor())
      else
        _pTable12c = Table12c.new(_pHeatingData.GetHeatDistributionSystem())
      end
    end
  end

  def CalculateSHDeliveredEnergy()
    SHEnergy = 0.0
    SHEnergy += _fuelUsageRegister.GetProviderAmount(FU_SPACE_HEATING)
    SHEnergy += _fuelUsageRegister.GetProviderAmount(FU_SPACE_HEATING_SECONDARY)
    #SHEnergy += _oilPumpElec + _fanFuelElec + _waterPumpElec;
    return SHEnergy
  end

  def CalculateWHDeliveredEnergy()
    WHEnergy = 0.0
    WHEnergy += _fuelUsageRegister.GetProviderAmount(FU_WATER_HEATING)
    WHEnergy += _fuelUsageRegister.GetProviderAmount(FU_SHOWERS)
    return WHEnergy
  end

  def CalculateTotalDeliveredEnergy()
    totalEnergy = 0.0
    totalEnergy += _fuelUsageRegister.GetProviderAmount(FU_SPACE_HEATING)
    totalEnergy += _fuelUsageRegister.GetProviderAmount(FU_SPACE_HEATING_SECONDARY)
    totalEnergy += _fuelUsageRegister.GetProviderAmount(FU_WATER_HEATING)
    totalEnergy += _fuelUsageRegister.GetProviderAmount(FU_SHOWERS)
    totalEnergy += _fuelUsageRegister.GetProviderAmount(FU_APPLIANCES)
    totalEnergy += _fuelUsageRegister.GetProviderAmount(FU_COOKING)
    totalEnergy += _fuelUsageRegister.GetProviderAmount(FU_LIGHTING)
    totalEnergy += _fuelUsageRegister.GetProviderAmount(FU_VENTILATION)
    totalEnergy += _fuelUsageRegister.GetProviderAmount(FU_GENERATED)
    totalEnergy += 0.00001
    return totalEnergy
  end

  def CalculateNetEnergyDelivered(pWaterProvider, pMechVentProvider, isCommunitySystem)
    netEnergyDelivered = 0.0
    #Heating energy
    netEnergyDelivered += _mainSystem1SpaceFuelUseage.GetYearResult()
    netEnergyDelivered += _mainSystem2SpaceFuelUseage.GetYearResult()
    netEnergyDelivered += _secondarySpaceFuelUseage.GetYearResult()
    netEnergyDelivered += isCommunitySystem == true ? pWaterProvider.GetCommunityDeliveredEnergy() : _waterFuelUseage.GetYearResult()
    netEnergyDelivered += _oilPumpElec + _fanFuelElec + _waterPumpElec
    #HF combi, Warm Air Fans, MVHR fans, solar water pump
    netEnergyDelivered += pWaterProvider.GetSolarPumpElectricity() + pWaterProvider.GetKeepHotElectricity()
    netEnergyDelivered += pMechVentProvider.GetMechVentElectricity() + pMechVentProvider.GetWarmAirElectricity()
    #Lights
    netEnergyDelivered += _pAppendixL.GetAnnualLightingEnergyUse()
    #PV + WT
    netEnergyDelivered += _pAppendixM.GetPhotoVoltaicResult() + _pAppendixM.GetMicroTurbineResult()
    #mCHP
    if _pAppendixN != nil then
      netEnergyDelivered += _pAppendixN.CalcElectricityConsumed()
    end
    return (netEnergyDelivered / _pDimensions.GetTotalFloorArea())
  end

  def GetHeadlineResults(results)
    results = _headlineResults
    return (results.IsValid != 0)
  end

  def GetFlueCounts(primary1, primary2, secondary)
    primary1 = _primary1FlueCount
    primary2 = _primary2FlueCount
    secondary = _secondaryFlueCount
  end

  def GetDesignHeatLoss()
    DesignHeatLoss = (_pTotalHeatLosses.GetHeatTransferCoefficient().GetYearResult() / 12.0) * 24.2
    return (DesignHeatLoss)
  end

  def HasDemontedPrimarySystemToSecondary()
    return _pHeatingData.AssumedPrimaryHeating()
  end

  def HasAssumedPortableElectricHeating()
    return _pHeatingData.AssumedSecondaryHeating()
  end

  def ClearResults()
    if _pTotalHeatLosses != nil then
      _pTotalHeatLosses = nil
      _pTotalHeatLosses = nil
    end
    if _pTotalGains != nil then
      _pTotalGains = nil
      _pTotalGains = nil
    end
    if _pWaterHeatingRequirement != nil then
      _pWaterHeatingRequirement = nil
      _pWaterHeatingRequirement = nil
    end
    if _pSpaceHeatingRequirements != nil then
      _pSpaceHeatingRequirements = nil
      _pSpaceHeatingRequirements = nil
    end
    if _pSpaceCoolingRequirements != nil then
      _pSpaceCoolingRequirements = nil
      _pSpaceCoolingRequirements = nil
    end
    if _pSapCalculation != nil then
      _pSapCalculation = nil
      _pSapCalculation = nil
    end
    if _pCo2Calculation != nil then
      _pCo2Calculation = nil
      _pCo2Calculation = nil
    end
    if _pAppendixD != nil then
      _pAppendixD = nil
      _pAppendixD = nil
    end
    if _pAppendixL != nil then
      _pAppendixL = nil
      _pAppendixL = nil
    end
    if _pAppendixF != nil then
      _pAppendixF = nil
      _pAppendixF = nil
    end
    if _pAppendixN != nil then
      _pAppendixN = nil
      _pAppendixN = nil
    end
    if _pAppendixM != nil then
      _pAppendixM = nil
      _pAppendixM = nil
    end
    if _pTable12c != nil then
      _pTable12c = nil
      _pTable12c = nil
    end
    _electricTotal = 0.0
    _gasTotal = 0.0
    _otherTotal = 0.0
    self.DeleteAndClearVector(_calculators)
  end

  def CleanEngine()
    if _pDimensions != nil then
      _pDimensions = nil
      _pDimensions = nil
    end
    if _pDwellingInfo then
      _pDwellingInfo = nil
      _pDwellingInfo = nil
    end
    if _pStructuralData then
      _pStructuralData = nil
      _pStructuralData = nil
    end
    if _pVentilationData then
      _pVentilationData = nil
      _pVentilationData = nil
    end
    if _pHeatingData then
      _pHeatingData = nil
      _pHeatingData = nil
    end
    if _fuelUsageRegister != nil then
      _fuelUsageRegister = nil
      _fuelUsageRegister = nil
    end
    if _pContext then
      self.SetEngineLinks(false)
      _pContext = nil
      _pContext = nil
    end
    if _pOccupancy != nil then
      _pOccupancy = nil
      _pOccupancy = nil
    end
    if _pfeedInTariffTable != nil then
      _pfeedInTariffTable = nil
      _pfeedInTariffTable = nil
    end
  end

  def ValidateEngineInputs(pErrorMsgs)
    # TODO: add validation
    return (true)
  end

  def GetDwellingInfoSpecification()
    return (_pDwellingInfo)
  end

  def AddFloor(Area, Height)
    _pDimensions.AddFloor(self.Floor(Area, Height))
  end

  def SetStoreyCount(count)
    _pDimensions.SetStoreyCount(count)
  end

  def GetFuelScalingFactor(fuelToGet)
    factor = 0.0
    billDataVect = _pOccupancy.GetBillData()
    it = billDataVect.begin()
    while it.MoveNext()
      if (it.Current).GetFuel() == fuelToGet then
        factor = ((it.Current).GetScalingFactor())
      end
    end
    return factor
  end

  def GetAssumedNumberOfOccupants()
    # REMEMBER: number of occupants will be
    return (Table1b.Lookup(_pDimensions.GetTotalFloorArea()).GetAssumedOccupants())
  end

  def GetTotalFloorArea()
    return _pDimensions.GetTotalFloorArea()
  end

  def GetStoreyCount()
    return (_pDimensions.GetStoreyCount())
  end

  def GetLivingAreaFraction()
    return (_pDwellingInfo.GetLivingAreaFraction())
  end

  def CheckVentilationData()
    if _pVentilationData == nil then
      raise EngineException.new("Ventilation data supplied before engine initialised")
    end
  end

  def SetVentilationData(chimneyCount, flueCount, fanCount, ventCount, fluelessFireCount)
    self.CheckVentilationData()
    _pVentilationData.SetChimneyCount(chimneyCount)
    _pVentilationData.SetFlueCount(flueCount)
    _pVentilationData.SetFanCount(fanCount)
    _pVentilationData.SetPassiveVentCount(ventCount)
    _pVentilationData.SetFluelessFireCount(fluelessFireCount)
  end

  def SetL50TestResult(l50Result)
    self.CheckVentilationData()
    _pVentilationData.SetL50TestResult(l50Result)
  end

  def SetL50TestEstimationParameters(hasDraughtLobby, walls, floors, draughtStrippingFraction)
    self.CheckVentilationData()
    _pVentilationData.SetL50EstimationParameters(hasDraughtLobby, walls, floors, draughtStrippingFraction)
  end

  def SetShelteredSidesCount(sides)
    self.CheckVentilationData()
    _pVentilationData.SetShelteredSidesCount(sides)
  end

  def SetVentilationType(method)
    self.CheckVentilationData()
    _pVentilationData.GetMechanicalVentiationSpecification().SetMethod(method)
  end

  def SetMechanicalVentilationParameters(sfp, heatRecoveryEfficiency)
    self.CheckVentilationData()
    pSFP = (sfp > 0.0) ?  : nil
    pHRE = (heatRecoveryEfficiency > 0.0) ?  : nil
    return (_pVentilationData.GetMechanicalVentiationSpecification().SetMechanicalVentilationParameters(pSFP, pHRE))
  end

  def SetApprovedInstallation(inUseFactorSFP, inUseFactorEff)
    self.CheckVentilationData()
    pEffFactor = (inUseFactorEff > 0.0) ?  : nil
    return (_pVentilationData.GetMechanicalVentiationSpecification().SetApprovedInstallation(inUseFactorSFP, pEffFactor))
  end

  def SetNonApprovedInstallation(config, insulation)
    self.CheckVentilationData()
    return (_pVentilationData.GetMechanicalVentiationSpecification().SetNonApprovedInstallation(config, insulation))
  end

  def SetNonApprovedInstallation()
    self.CheckVentilationData()
    return (_pVentilationData.GetMechanicalVentiationSpecification().SetNonApprovedInstallation(nil, nil))
  end

  def AddGlazedElement(type, opening)
    pNewElement = GlazedElement.new(type, opening.area)
    pNewElement.SetGlazing(opening.glazing)
    pNewElement.SetGlazingExtent((opening.glazing == GT_SOLID) ? GE_SOLID : GE_FULL_GLAZED) # This should be passed in as part of the definition structure soon
    pNewElement.SetOvershading(opening.overshading)
    pNewElement.SetOrientation(opening.orientation)
    pNewElement.SetGlazingGap(opening.gap)
    pNewElement.SetISBFRCApproved(opening.IsBFRCApproved)
    pNewElement.SetThermalBreak(opening.thermalBreak)
    if opening.userDefinedUvalue then
      pNewElement.SetUvalue(opening.uvalue, (opening.rooflightSpecficUvalue) != 0)
    end
    if opening.useFrameFactor then
      pNewElement.SetFrameFactor(opening.frameFactor)
    else
      pNewElement.SetFrame(opening.frameType)
    end
    if opening.useSolarFactor then
      pNewElement.SetSolarEnergyTransmittance(opening.solarFactor, (opening.solarFactorForGlazingOnly) != 0)
    end
    _pStructuralData.AddElement(pNewElement)
  end

  def AddFabricElement(type, area, uvalue, kvalue)
    pNewElement = FabricElement.new(type, area, uvalue, kvalue)
    _pStructuralData.AddElement(pNewElement)
  end

  def AddFabricElement(type, area, kvalue)
    pNewElement = FabricElement.new(type, area, kvalue)
    _pStructuralData.AddElement(pNewElement)
  end

  def SetThermalMass(thermalMass)
    _pStructuralData.SetThermalMass(thermalMass)
  end

  def ClearThermalBridges()
    _pStructuralData.ClearThermalBridges()
  end

  def AddThermalBridges(thermalTransmittence, length)
    _pStructuralData.AddThermalBridge(thermalTransmittence * length)
  end

  def SetPrimarySystem(system, fuel, controls)
    _pHeatingData.SetPrimarySystem(system, fuel, controls)
  end

  def SetPrimarySystem(id, fuel, controls)
    _pHeatingData.SetPrimarySystem(id, fuel, controls)
  end

  def AddSupplementarySystem(system, fuel, controls, fraction)
    return (_pHeatingData.AddSupplementalPrimarySystem(system, fuel, controls, fraction))
  end

  def AddSupplementarySystem(id, fuel, controls, fraction)
    return _pHeatingData.AddSupplementalPrimarySystem(id, fuel, controls, fraction)
  end

  def SetOnPeakElectricTariff(fuel)
    return (_pHeatingData.SetOnPeakElectricTariff(fuel))
  end

  def SetFlueType(systemIndex, type)
    return (_pHeatingData.SetFlueType(systemIndex, type))
  end

  def SetHeatingSystemControlFeatures(systemIndex, delayedStartThermostat, loadCompensation, weatherCompensation)
    _pHeatingData.SetControlFeatures(systemIndex, delayedStartThermostat, loadCompensation, weatherCompensation)
  end

  def SetSecondaryHeatingSystem(code, fuel, hetasApproved)
    _pHeatingData.SetSecondaryHeating(code, fuel, hetasApproved)
  end

  def SetSystemEmitters(systemIndex, emitters, pipeConfig)
    return (_pHeatingData.SetSystemEmitters(systemIndex, emitters, pipeConfig))
  end

  def SetWaterHeatingSystem(system, independantTimeControl, doubleSummerImmersion)
    _pHeatingData.SetWaterHeatingSystem(system, doubleSummerImmersion)
    _pHeatingData.WaterHeatingSpecification().SetIndependantTimeControl(independantTimeControl)
  end

  def SetWaterHeatingFuel(fuel)
    _pHeatingData.WaterHeatingSpecification().SetFuel(fuel)
  end

  def SetImmersionType(type)
    _pHeatingData.WaterHeatingSpecification().SetImmersionType(type)
  end

  def SetKeepHotFacility(facility, source)
    _pHeatingData.WaterHeatingSpecification().SetKeepHotFacility(facility)
    _pHeatingData.WaterHeatingSpecification().SetKeepHotSource(source)
  end

  def SetWarmAirParameters(systemIndex, fanCount, hasBoilerInterlock)
    _pHeatingData.SetWarmAirFanCount(systemIndex, fanCount)
    _pHeatingData.SetBoilerInterlock(systemIndex, hasBoilerInterlock)
  end

  def SetDeclaredEfficiency(systemIndex, declaredEfficiency, isModulating)
    if declaredEfficiency > 0.0 then
      _pHeatingData.SetDeclaredEfficiency(systemIndex, declaredEfficiency, isModulating)
    else
      _pHeatingData.ClearDeclaredEfficiency(systemIndex)
    end
  end

  def SetBoilerParamaters(systemIndex, waterPumpInHeatedSpace, fuelPump, hasBoilerInterlock)
    _pHeatingData.SetBoilerEquipmentLocation(systemIndex, waterPumpInHeatedSpace, fuelPump)
    _pHeatingData.SetBoilerInterlock(systemIndex, hasBoilerInterlock)
  end

  def SetHeatPumpParameters(systemIndex, includesOffPeakImmersion)
    _pHeatingData.WaterHeatingSpecification().SetIncludesOffPeakImmersion(includesOffPeakImmersion)
  end

  def SetCommunityDistributionLossFactor(factor)
    _pHeatingData.SetCommunityDistributionLossFactor(factor)
  end

  def SetHeatDistributionSystem(heatDistribution)
    _pHeatingData.SetHeatDistributionSystem(heatDistribution)
  end

  def ConfigureMainHeatSource(fuel, efficiency)
    _pHeatingData.ConfigureMainHeatSource(fuel, efficiency)
  end

  def AddAdditionalHeatSource(fuel, fraction, efficiency, isCHP, heatToPowerRatio)
    return (_pHeatingData.AddAdditionalHeatSource(fuel, fraction, efficiency, isCHP, heatToPowerRatio))
  end

  def ClearAdditionalHeatSources()
    return (_pHeatingData.ClearAdditionalHeatSources())
  end

  def SetCylinderConfiguration(config)
    _pHeatingData.CylinderSpecification().SetCylinderConfiguration(config)
  end

  def SetCylinderVolume(volume)
    _pHeatingData.CylinderSpecification().SetCylinderVolume(volume)
  end

  def SetCylinderThermostat(hasThermostat)
    _pHeatingData.CylinderSpecification().SetCylinderThermostat(hasThermostat)
  end

  def SetCylinderInsulation(insulation, thickness)
    _pHeatingData.CylinderSpecification().SetCylinderInsulation(insulation, thickness)
  end

  def SetCylinderInsulation(declaredLoss)
    _pHeatingData.CylinderSpecification().SetDeclaredCylinderLoss(declaredLoss)
  end

  def SetPrimaryPipeworkConfiguration(insulation, length)
    _pHeatingData.CylinderSpecification().SetPrimaryPipeworkInfo(insulation, length)
  end

  def SetCylinderHeatExchangerArea(Area)
    _pHeatingData.CylinderSpecification().SetCylinderHeatExchangerArea(Area)
  end

  def SetWinterOperartingTemperature(temperature)
    return (_pHeatingData.WaterHeatingSpecification().SetWinterOperatingTemperature(temperature))
  end

  def SetUnderheatingDefinition(definition)
    _pHeatingData.SetUnderheatingDefinition(definition)
  end

  def SetEngineLinks(State)
    if State then
      _pContext.EngineLink.AddLink(LD_EnergyRequirementsSecondaryFraction, _secondayFraction, "Secondary Fraction")
      _pContext.EngineLink.AddLink(LD_EnergyRequirementsMainFraction, _mainFraction, "Main Fraction")
      _pContext.EngineLink.AddLink(LD_EnergyRequirementsFractionFromMainSystem1, _fractionFromMainSystem1, "Fraction From Main System 1")
      _pContext.EngineLink.AddLink(LD_EnergyRequirementsFractionFromMainSystem2, _fractionFromMainSystem2, "Fraction From Main System 2")
      _pContext.EngineLink.AddLink(LD_EnergyRequirementsEfficiencyMainSystem1, _efficiencyMainSystem1, "Efficiency Of Main System 1")
      _pContext.EngineLink.AddLink(LD_EnergyRequirementsEfficiencyMainSystem2, _efficiencyMainSystem2, "Efficiency Of Main System 2")
      _pContext.EngineLink.AddLink(LD_EnergyRequirementsSecondaryEfficiency, _secondaryEfficiency, "Secondary Efficiency")
      _pContext.EngineLink.AddLink(LD_EnergyRequirementsMainSystem1SpaceFuelUseage, _mainSystem1SpaceFuelUseage, "Main System 1 Space Fuel Useage")
      _pContext.EngineLink.AddLink(LD_EnergyRequirementsMainSystem2SpaceFuelUseage, _mainSystem2SpaceFuelUseage, "Main System 2 Space Fuel Useage")
      _pContext.EngineLink.AddLink(LD_EnergyRequirementsSecondarySpaceFuelUseage, _secondarySpaceFuelUseage, "Secondary Space Fuel Useage")
      _pContext.EngineLink.AddLink(LD_EnergyRequirementsWaterEfficiencyByMonth, _waterEfficiencyByMonth, "Water Efficiency By Month")
      _pContext.EngineLink.AddLink(LD_EnergyRequirementsWaterFuelUseage, _waterFuelUseage, "Water Fuel useage")
      _pContext.EngineLink.AddLink(LD_EnergyRequirementsWaterPumpElec, _waterPumpElec, "Water Pump Elec")
      _pContext.EngineLink.AddLink(LD_EnergyRequirementsOilPumpElec, _oilPumpElec, "Oil Pump Elec")
      _pContext.EngineLink.AddLink(LD_EnergyRequirementsFanFuelElec, _fanFuelElec, "Fan Fuel Elec")
    else
      Links = LD_EnergyRequirementsSecondaryFractionLD_EnergyRequirementsMainFractionLD_EnergyRequirementsFractionFromMainSystem1LD_EnergyRequirementsFractionFromMainSystem2LD_EnergyRequirementsEfficiencyMainSystem1LD_EnergyRequirementsEfficiencyMainSystem2LD_EnergyRequirementsSecondaryEfficiencyLD_EnergyRequirementsMainSystem1SpaceFuelUseageLD_EnergyRequirementsMainSystem2SpaceFuelUseageLD_EnergyRequirementsSecondarySpaceFuelUseageLD_EnergyRequirementsWaterEfficiencyByMonthLD_EnergyRequirementsWaterFuelUseageLD_EnergyRequirementsWaterPumpElecLD_EnergyRequirementsOilPumpElecLD_EnergyRequirementsFanFuelElec
      _pContext.EngineLink.RemoveLinks(List[LinkData].new(Links, Links + (Links.Length)))
    end
  end

  def SolarWaterSpecification()
    return _pHeatingData.SolarWaterSpecification()
  end

  def OccupancySpecification()
    if _pOccupancy == nil then
      _pOccupancy = Occupancy.new()
    end
    return _pOccupancy
  end

  def OccupancySpecificationOccupantCount()
    if _pOccupancy == nil then
      _pOccupancy = Occupancy.new()
    end
    return _pOccupancy.GetStandardOccupantCount()
  end

  def OccupancySpecificationOvenFuel()
    if _pOccupancy == nil then
      _pOccupancy = Occupancy.new()
    end
    return _pOccupancy.GetOvenFuel()
  end

  def SetFuelSpotPrice(Fuel, UnitPrice, StandingCharge)
    _fuelDataRecord.SetSpotCostData(Fuel, UnitPrice, StandingCharge)
  end

  def SetPCodeRhiRegion()
    # For RHI calc we need to make sure Dwelling region is setup
    if _pContext.Mode.GetEngineCalcMode() == EM_RHI_CALC or _pContext.Mode.GetRuleSet() == ERS_CENTRICA or _pContext.Mode.GetEngineCalcMode() == EM_REGIONAL_CALC then
      if _pDwellingInfo.GetPostcode().TestValue() then
        Postcode = _pDwellingInfo.GetPostcode().GetValue()
      else
        # TODO: raise validation error for trying to obtain a region without setting postcode - defaulting to a Leeds postcode to continue
        Postcode = "LS1"
      end
      _pDwellingInfo.SetRhiRegion(Table10.CalcRhiRegion(Postcode))
    end
  end

  def GetRHIRegionCode()
    return _pDwellingInfo.GetRhiRegion().TestValue() ? _pDwellingInfo.GetRhiRegion().GetValue() : -1
  end

  def SetDemandTemperature(Temp)
    _pHeatingData.SetDemandTemperature(Temp)
  end

  def SetZoneHeatingHours(Zone, WeekdayOff1, WeekdayOff2, WeekdayOff3, WeekdayOff4, WeekendOff1, WeekendOff2, WeekendOff3, WeekendOff4)
    _pHeatingData.SetZoneHeatingHours(Zone, WeekdayOff1, WeekdayOff2, WeekdayOff3, WeekdayOff4, WeekendOff1, WeekendOff2, WeekendOff3, WeekendOff4)
  end

  def AddFeedinTariff(Type, LowerRange, UpperRange, Tariff)
    record = FeedInTariff.new(Type, LowerRange, UpperRange, Tariff)
    self.GetFeedInTariffTable().AddRecord(record)
  end

  def SetCurrentFeedinTariff(Type, LowerRange, UpperRange, Tariff)
    record = FeedInTariff.new(Type, LowerRange, UpperRange, Tariff)
    self.GetFeedInTariffTable().SetCurrentTariff(record)
  end

  def GetElectricCostTotal()
    return (_electricTotal)
  end

  def GetGasCostTotal()
    return (_gasTotal)
  end

  def GetOtherCostTotal()
    return (_otherTotal)
  end

  def GetOAFuelKwhTotal(sapFuel)
    return _fuelUsageRegister.GetAmountByFuelNoCHMapping(sapFuel)
  end

  def GetOAFuelSC(sapFuel)
    sc = _fuelUsageRegister.GetSCForFuel(CV_AVERAGE, sapFuel)
    summary = _fuelUsageRegister.GetSummary(sapFuel)
    #For community fuels if only suppling DHW then the SC is halved.
    if sapFuel >= 41 and sapFuel <= 55 then
      if summary.usedWhere[FU_WATER_HEATING] == true and summary.usedWhere[FU_SPACE_HEATING] == false then
        sc *= 0.5
      end
    end
    return sc
  end

  def GetOAFuelSummary(index)
    #return (_fuelUsageRegister->GetOAFuelSummary());
    fuelSummaryVector = _fuelUsageRegister.GetOAFuelSummary()
    if index < 0 or index >= fuelSummaryVector.size() then
      return (nil)
    end
    return (fuelSummaryVector[index])
  end

  def GetOAFuelSummaryForPrimary()
    return (_fuelUsageRegister.GetOAFuelSummaryForPrimary())
  end
end
class SpaceHeatingRequirement
  def initialize(pContext, pOccupancy)
    self.RegisterEngineContext(pContext)
    _pOccupancy = pOccupancy
    _pTable4eA = nil
    _pTable4eB = nil
    _validator = Validator.new(self)
    self.SetEngineLinks(true)
  end

  def Dispose()
    self.Clear()
    self.SetEngineLinks(false)
    _validator = nil
  end

  def Clear()
    if _pTable4eA != nil then
      _pTable4eA = nil
      _pTable4eA = nil
    end
    if _pTable4eB != nil then
      _pTable4eB = nil
      _pTable4eB = nil
    end
  end

  def Calculate(pHeatloss, gainRates, pDimensions, pInfo, pHeatingSystemData, pExternalTemperatures, pAppendixN, solarGains)
    self.Clear()
    pSysA = pHeatingSystemData.GetPrimarySystemData(0)
    pSysB = (pHeatingSystemData.GetPrimarySystemCount() > 1) ? pHeatingSystemData.GetPrimarySystemData(1) : nil
    _pExternalTemperatures = pExternalTemperatures
    _pTable4eA = Table4e.Lookup(pSysA.GetHeatingControls(), (pSysA.IsCPSUSystem() or pSysA.GetThermalStoreType() == TST_INTEGRATED), pSysA.HasDelayedStartThermostat())
    isRoomHeater = false
    if pSysA.IsClass(HSC_ROOM_HEATERS) then
      isRoomHeater = true
    end
    R = pSysA.GetResponsiveness() # responsiveness of main system
    primarySysFraction = (_pOccupancy != nil and _pOccupancy.IsGreenDealOccupancy(INTERNAL_TEMPERATURES)) ? _pOccupancy.CalculateOccAssessmentMainHeatingFraction(0, pHeatingSystemData, pAppendixN, false) : pHeatingSystemData.GetPrimarySystemFraction(0)
    if pSysB != nil and primarySysFraction < 1 then #OA - iif the main heatin sys has been substituted then pSysB will be a water system only.
                                                    # perform a weighted average of responsiveness and then treat as a
                                                    # single system (see R calc in 9b - this logic came from BA on 14/02/2011)
      alternateSystemFraction = (_pOccupancy != nil and _pOccupancy.IsGreenDealOccupancy(INTERNAL_TEMPERATURES)) ? _pOccupancy.CalculateOccAssessmentMainHeatingFraction(1, pHeatingSystemData, pAppendixN, true) : 1.0 - primarySysFraction
      # use reduced scope var for responsiveness rather than function level scope "RB" to reduce confusion
      altR = pSysB.GetResponsiveness()
      R = (alternateSystemFraction * altR) + ((1.0 - alternateSystemFraction) * R)
      _pTable4eB = Table4e.Lookup(pSysB.GetHeatingControls(), (pSysB.IsCPSUSystem() or pSysB.GetThermalStoreType() == TST_INTEGRATED), pSysB.HasDelayedStartThermostat())
      if _pTable4eA.GetControlLevel() == _pTable4eB.GetControlLevel() then
        # control level is the same -
        # clear up memory associated with table4e for system B - this being NULL will
        # cause the calc to only evaluate one MIT2 using the averaged responsiveness (above)
        _pTable4eB = nil
        _pTable4eB = nil
      end
    end
                                  # set Ti to demand temp (default 21) - note always using
    pHeatingPattern = pHeatingSystemData.GetHeatingPattern()
    _zone1DemandTemp = pHeatingPattern.GetDemandTemperature()
    zone1 = HeatingZone.new(_zone1DemandTemp, R)
                                  # set heating pattern
    zone1.SetHeatingHours(pHeatingPattern.GetZone1Pattern())
    _zn1frac = pInfo.GetLivingAreaFraction().GetValue()
                                  # case loss factor for cooker boilers needs to be applied here... (Fixed TC11)
    caseLossFactor = 1.0
    systemIndex = 0
    while systemIndex < pHeatingSystemData.GetPrimarySystemCount()
      pPrimary = pHeatingSystemData.GetPrimarySystemData(systemIndex)
      # if range cooker then apply case heat loss to fuel usage of this system
      caseLoss = pPrimary.GetCookerCaseLossAtFullOutput()
      fullOutput = pPrimary.GetCookerFullOutput()
      if caseLoss.TestValue() and fullOutput.TestValue() and caseLoss > 0.0 and fullOutput > 0.0 then
        caseLossFactor = caseLossFactor - (caseLoss / fullOutput)
      end
      systemIndex += 1
    end
    enumerator = .GetEnumerator()
    while enumerator.MoveNext()
      = enumerator.Current
    end

    G = gainRates.GetMonthResult(month)
    Te = _pExternalTemperatures.GetMonthResult(month)
    hlp = pHeatloss.GetHeatLossParameter(month)
    tmp = pHeatloss.GetThermalMassParameter()
    SG = solarGains.GetMonthResult(month)
    controlLevel = _pTable4eA.GetControlLevel()
                                  # BOX(87) - mean internal temperature (zone 1)
    _mitZone1.SetMonthResult(month, zone1.Calculate(month, H, G, Te, hlp, tmp, pAppendixN, _pOccupancy, SG))
                                  # zone 1 has done it's calc so can grab utilization factor out now
    _utilisationFactorZone1 = zone1.GetUtilisationFactors()
    _zone2demandTemperature.SetMonthResult(month, Table9.GetZone2DemandTemperature(controlLevel, _zone1DemandTemp, hlp))
    zone2 = HeatingZone.new(_zone2demandTemperature.GetMonthResult(month), R)
    isOccupancyAssessment = _pOccupancy != nil and _pOccupancy.IsGreenDealOccupancy(INTERNAL_TEMPERATURES) ? true : false
    zone2.SetHeatingHours(pHeatingPattern.GetZone2Pattern(controlLevel, isOccupancyAssessment))
                                  # mean zone 2 temperature for system A
    t2A = zone2.Calculate(month, H, G, Te, hlp, tmp, pAppendixN, _pOccupancy, SG)
    _utilisationFactorZone2 = zone2.GetUtilisationFactors()
    if _pTable4eB != nil then
      controlLevelB = _pTable4eB.GetControlLevel()
      zone2demandTemperatureB = Table9.GetZone2DemandTemperature(controlLevelB, _zone1DemandTemp, hlp)
      zone2B = HeatingZone.new(zone2demandTemperatureB, R)
      zone2B.SetHeatingHours(pHeatingPattern.GetZone2Pattern(controlLevelB, isOccupancyAssessment))
      # mean zone 2 temperature for system B
      # Change here to prevent system B using AppendixN rule when it is isn't an Appendix N system
      if pSysB.IsHeatpump() or pSysB.IsMicrogenSystem() then
        t2B = zone2B.Calculate(month, H, G, Te, hlp, tmp, pAppendixN, _pOccupancy, SG)
      else
        t2B = zone2B.Calculate(month, H, G, Te, hlp, tmp, nil, _pOccupancy, SG)
      end
      fractionB = (_pOccupancy != nil and _pOccupancy.IsGreenDealOccupancy(INTERNAL_TEMPERATURES)) ? _pOccupancy.CalculateOccAssessmentMainHeatingFraction(1, pHeatingSystemData, pAppendixN, true) : pHeatingSystemData.GetPrimarySystemFraction(1)
      #table 9 - if main heating B fraction is greater then zone2 fraction then only use main heating for rest of house
      zn2frac = 1 - _zn1frac
      if fractionB <= zn2frac then
        # apply weighted average of two systems' zone 2
        wtA = (1.0 - fractionB - _zn1frac) / (1.0 - _zn1frac)
        wtB = fractionB / (1.0 - _zn1frac)
        t2 = (wtA * t2A) + (wtB * t2B)
      else
        t2 = t2B
      end
    else
      # one system - simple
      t2 = t2A
    end
                                  # t2 is now BOX(90)m
    _mitZone2.SetMonthResult(month, t2)
                                  # step 10...
    mit = (_zn1frac * _mitZone1.GetMonthResult(month)) + ((1.0 - _zn1frac) * _mitZone2.GetMonthResult(month))
                                  # BOX(92)m
    _baseMIT.SetMonthResult(month, mit)
                                  # adjust mit (table 4e)
    adjustedMIT = (mit + _pTable4eA.GetTemperatureAdjustment())
    numUnheated = 0
    numPartially = 0
    numHeatedBySecondaryOnly = 0
    numTotal = 0
    _pOccupancy.GetHabitableRoomFigures(numUnheated, numPartially, numHeatedBySecondaryOnly, numTotal)
    if (numUnheated + numPartially + numHeatedBySecondaryOnly) > 0 then
      Fu = (numUnheated + (0.5 * numPartially) + (0.5 * numHeatedBySecondaryOnly)) / numTotal
      H2 = H * Fu
      G2 = SG * Fu
      H3 = 100
      MITu = ((adjustedMIT * H3) + (Te * H2) + G2) / (H3 + H2)
      adjustedMIT = ((1 - Fu) * adjustedMIT) + (Fu * MITu)
    end
                                  # BOX(93)
    _meanInternalTemperature.SetMonthResult(month, adjustedMIT)
                                  # recalc table9a
    result = Table9a.Lookup(H, G, Te, hlp, adjustedMIT, tmp)
    _utilisationFactor.SetMonthResult(month, result.utilisationFactor)
    usefulGains = result.utilisationFactor * G
    _usefulGains.SetMonthResult(month, usefulGains)
    _lostHeat.SetMonthResult(month, result.lostHeat)
                                  # calc heat req
    if month == Year.Jun() or month == Year.Jul() or month == Year.Aug() or month == Year.Sep() then # summer months
      Qheat = 0.0
    else
      Qheat = 0.024 * (result.lostHeat - usefulGains) * month.GetNumDays() * caseLossFactor
      if Qheat < 0.0 then
        Qheat = 0.0
      end
    end
                                  # BOX(98)
    _spaceHeatingRequirement.SetMonthResult(month, Qheat)
  end

  def SetEngineLinks(State)
    if State then
      _pContext.EngineLink.AddLink(LD_SpaceHeatingZone1DemandTemp, _zone1DemandTemp, "Zone 1 demand temperature")
      _pContext.EngineLink.AddLink(LD_SpaceHeatingBaseMIT, _baseMIT, "Base mean internal temperature")
      _pContext.EngineLink.AddLink(LD_SpaceHeatingMeanInternalTemp, _meanInternalTemperature, "Mean internal Temperature")
      _pContext.EngineLink.AddLink(LD_SpaceHeatingMITZone1, _mitZone1, "MIT Zone 1")
      _pContext.EngineLink.AddLink(LD_SpaceHeatingUtilFactorZone1, _utilisationFactorZone1, "Utilization Factor Zone 1")
      _pContext.EngineLink.AddLink(LD_SpaceHeatingUtilFactorZone2, _utilisationFactorZone2, "Utilization Factor Zone 2")
      _pContext.EngineLink.AddLink(LD_SpaceHeatingZone2DemandTemp, _zone2demandTemperature, "Zone 2 demand temp")
      _pContext.EngineLink.AddLink(LD_SpaceHeatingMITZone2, _mitZone2, "MIT Zone 2")
      _pContext.EngineLink.AddLink(LD_SpaceHeatingLivingAreaFraction, _zn1frac, "Living Area Fraction")
      _pContext.EngineLink.AddLink(LD_SpaceHeatingRequirement, _spaceHeatingRequirement, "Space heating requirement")
      _pContext.EngineLink.AddLink(LD_SpaceHeatingExtTemp, _pExternalTemperatures, "External temperatures")
      _pContext.EngineLink.AddLink(LD_SpaceHeatingUtilFactor, _utilisationFactor, "Utilisation Factor")
      _pContext.EngineLink.AddLink(LD_SpaceHeatingUsefulGains, _usefulGains, "Useful Gains")
      _pContext.EngineLink.AddLink(LD_SpaceHeatingKWhourm2Year, _kWh_m2_year, "Space Heating Requirement in KWh/year")
      _pContext.EngineLink.AddLink(LD_SpaceHeatingLostHeat, _lostHeat, "Lost Heat")
    else
      Links = LD_SpaceHeatingZone1DemandTempLD_SpaceHeatingBaseMITLD_SpaceHeatingMeanInternalTempLD_SpaceHeatingMITZone1LD_SpaceHeatingUtilFactorZone1LD_SpaceHeatingUtilFactorZone2LD_SpaceHeatingZone2DemandTempLD_SpaceHeatingMITZone2LD_SpaceHeatingLivingAreaFractionLD_SpaceHeatingRequirementLD_SpaceHeatingExtTempLD_SpaceHeatingUtilFactorLD_SpaceHeatingUsefulGainsLD_SpaceHeatingKWhourm2YearLD_SpaceHeatingLostHeat
      _pContext.EngineLink.RemoveLinks(List[LinkData].new(Links, Links + (Links.Length)))
    end
  end
end
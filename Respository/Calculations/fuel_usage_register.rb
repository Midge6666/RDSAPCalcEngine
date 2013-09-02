class FuelUsageRegister
  def initialize(fuels, pContext)
    self.RegisterEngineContext(pContext)
    limit = Table12.GetTableSize()
    _pFuelSummary = Array.CreateInstance(FUEL_SUMMARY, limit)
    index = 0
    while index < limit
      pRecord = (_pFuelSummary + index)
      pRecord.code = Table12.GetFuelByIndex(index)
      pRecord.quantity = 0.0
      pRecord.used = false
      pRecord.usedWhere.insert(self.pair(FU_SPACE_HEATING, false))
      pRecord.usedWhere.insert(self.pair(FU_WATER_HEATING, false))
      pRecord.usedWhere.insert(self.pair(FU_LIGHTING, false))
      pRecord.usedWhere.insert(self.pair(FU_SPACE_COOLING, false))
      pRecord.usedWhere.insert(self.pair(FU_VENTILATION, false))
      pRecord.usedWhere.insert(self.pair(FU_SHOWERS, false))
      pRecord.usedWhere.insert(self.pair(FU_APPLIANCES, false))
      pRecord.usedWhere.insert(self.pair(FU_COOKING, false))
      pRecord.pFuelSpec = fuels.GetFuelSpecification(pRecord.code)
      if pRecord.code == F_ELEC_DISPLACED then
        _pDisplacedElectricityRecord = pRecord
      end
      index += 1
    end
    self.SetEngineLinks(true)
  end

  def Dispose()
    _pFuelSummary = nil
    _pDisplacedElectricityRecord = nil
    it = _rollcall.begin()
    while it.MoveNext()
      self.delete(it.Current)
    end
    _rollcall.clear()
    self.SetEngineLinks(false)
  end

  def AddFuelUsage(category, spec, fuel, amount, pProvider, pContext)
    pSummary = self.GetSummary(fuel)
    pSummary.quantity { self.amount() }
    pSummary.used = true
    if spec == FUS_PRIMARY_PROVISION or spec == FUS_SECONDARY_PROVISION then
      pSummary.usedWhere[category] = true
    end
    pFuelUsage = FuelUsage.new(category, spec, fuel, amount, pSummary, pProvider, pContext)
    _rollcall.push_back(pFuelUsage)
    self.AllocateLink(category, spec, pSummary, pFuelUsage)
    return (pFuelUsage)
  end

  def AddFuelUsage(category, spec, fuel, emissionsFuel, amount, pProvider, pContext)
    pSummary = self.GetSummary(fuel)
    pEmissionsFuel = self.GetSummary(emissionsFuel)
    pFuelUsage = FuelUsage.new(category, spec, fuel, pEmissionsFuel.pFuelSpec.GetEmissionsFactor(), pEmissionsFuel.pFuelSpec.GetPrimaryEnergyFactor(), amount, pSummary, pProvider, pContext)
    _rollcall.push_back(pFuelUsage)
    self.AllocateLink(category, spec, pSummary, pFuelUsage)
    return (pFuelUsage)
  end

  def AllocateLink(category, spec, pSummary, pFuelUsage)
    CostYear = pSummary.pFuelSpec.GetCostPerUnit(CV_STANDARD, pFuelUsage.GetAmount()) * pFuelUsage.GetAmount() * 0.01
    FuelPrice = pSummary.pFuelSpec.GetCostPerUnit(CV_STANDARD, pFuelUsage.GetAmount())
    EmissionFactor = pSummary.pFuelSpec.GetEmissionsFactor()
    Emissions = pFuelUsage.GetAmount() * EmissionFactor
    if spec == FUS_PRIMARY_PROVISION then
      case category
        when FU_SPACE_HEATING
          _mainSystem1FuelCostYear = CostYear
          _mainSystem1FuelPrice = FuelPrice
          _mainSystem1EmissionFactor = EmissionFactor
          _mainSystem1EmissionsYear = Emissions
        when FU_WATER_HEATING
          _waterFuelHighCostYear = CostYear
          _waterFuelHighPrice = FuelPrice
          _waterEmissionFactor = EmissionFactor
          _waterEmissionsYear = Emissions
        when FU_LIGHTING
          _lightingCostYear = CostYear
          _lightingPrice = FuelPrice
          _lightingEmissionFactor = EmissionFactor
          _lightingEmissionsYear = Emissions
        when FU_SHOWERS
          _showerCostYear = CostYear
          _showerPrice = FuelPrice
          _showerEmissionFactor = EmissionFactor
          _showerEmissionsYear = Emissions
        when FU_APPLIANCES
          _applianceCostYear = CostYear
          _appliancePrice = FuelPrice
          _applianceEmissionFactor = EmissionFactor
          _applianceEmissionsYear = Emissions
        when FU_COOKING
          _cookingCostYear = CostYear
          _cookingPrice = FuelPrice
          _cookingEmissionFactor = EmissionFactor
          _cookingEmissionsYear = Emissions
      end
    elsif spec == FUS_SECONDARY_PROVISION then
      case category
        when FU_SPACE_HEATING
          _mainSystem2FuelCostYear = CostYear
          _mainSystem2FuelPrice = FuelPrice
          _mainSystem2EmissionFactor = EmissionFactor
          _mainSystem2EmissionsYear = Emissions
        when FU_WATER_HEATING, FU_LIGHTING
      end
    elsif spec == FUS_ANCILLARY_REQUIREMENT then
      # get the current value or set to 0 if not previously set
      cYear = _pumpsFansKeephotFuelCostYear.TestValue() ? _pumpsFansKeephotFuelCostYear.GetValue() : 0.0
      _pumpsFansKeephotFuelCostYear.SetValue(cYear + CostYear)
      _pumpsFansKeephotFuelPrice.SetValue(FuelPrice)
      _pumpsFansKeephotEmissionFactor = EmissionFactor
      cEmissions = _pumpsFansKeephotEmissionsYear.TestValue() ? _pumpsFansKeephotEmissionsYear.GetValue() : 0.0
      _pumpsFansKeephotEmissionsYear.SetValue(cEmissions + Emissions)
    end
  end

  def GetSummary(fuel)
    limit = Table12.GetTableSize() # why can't we use the table12 limit the array was created with in the 1st place?
                                   #int limit = sizeof(_pFuelSummary) / sizeof(*_pFuelSummary); // this wont work because the sizeof a point is always going to be 4.
    pRecord = _pFuelSummary
    index = 0
    while index < limit
      if pRecord.pFuelSpec.GetFuelCode() == fuel then
        return (pRecord)
      end
      pRecord += 1
      index += 1
    end
    return (nil)
  end

  def GetStandingChargeUtilisation(fuelToGet)
    return (_standingChargeUtilisation[fuelToGet])
  end

  def GetOAFuelSummary()
    it = FuelUseIterator.new(_rollcall)
    return (it.GetOAFuelSummary())
  end

  def GetOAFuelSummaryForPrimary()
    it = FuelUseIterator.new(_rollcall)
    return (it.GetOAFuelSummaryForPrimary())
  end

  def GetHeatingCosts(cv)
    total = 0.0
    it = FuelUseIterator.new(_rollcall)
    cat = FU_SPACE_HEATING
    total = it.GetCost(cv, cat, true)
    cat = FU_SPACE_HEATING_SECONDARY
    total += it.GetCost(cv, cat, true)
    cat = FU_VENTILATION
    total += it.GetCost(cv, cat, true)
    return (total)
  end

  def GetWaterHeatingCosts(cv)
    it = FuelUseIterator.new(_rollcall)
    cat = FU_WATER_HEATING
    return (it.GetCost(cv, cat, true, nil))
  end

  def GetLightingCosts(cv)
    it = FuelUseIterator.new(_rollcall)
    cat = FU_LIGHTING
    return (it.GetCost(cv, cat, true))
  end

  def GetShowerCosts(cv)
    it = FuelUseIterator.new(_rollcall)
    cat = FU_SHOWERS
    return (it.GetCost(cv, cat, true))
  end

  def GetApplianceCosts(cv)
    it = FuelUseIterator.new(_rollcall)
    cat = FU_APPLIANCES
    return (it.GetCost(cv, cat, true))
  end

  def GetCookingCosts(cv)
    it = FuelUseIterator.new(_rollcall)
    cat = FU_COOKING
    return (it.GetCost(cv, cat, true))
  end

  def GetCoolingCosts(cv)
    it = FuelUseIterator.new(_rollcall)
    cat = FU_SPACE_COOLING
    return (it.GetCost(cv, cat, true))
  end

  def GetTotalCosts(cv)
    it = FuelUseIterator.new(_rollcall)
    sc = 0.0
    _totalCost = it.GetCost(cv, nil, true, sc)
    _additionalStandingCharges.SetValue(sc)
    _standingChargeUtilisation = it.GetStandingChargeUtilisation()
    return (_totalCost)
  end

  def GetTotalCostsNoSC(cv)
    it = FuelUseIterator.new(_rollcall)
    sc = 0.0
    _totalCost = it.GetCost(cv, nil, false, sc)
    _additionalStandingCharges.SetValue(sc)
    return (_totalCost)
  end

  def GetAmountByFuel(fuelToGet)
    it = FuelUseIterator.new(_rollcall)
    ammount = it.GetAmountByFuel(fuelToGet)
    return (ammount)
  end

  def GetAmountByFuelNoCHMapping(fuelToGet)
    it = FuelUseIterator.new(_rollcall)
    ammount = it.GetAmountByFuelNoCHMapping(fuelToGet)
    return (ammount)
  end

  def AdjustAmountByFuel(fuelToGet, correctionFactor, noSHScaling, noHWScaling)
    it = FuelUseIterator.new(_rollcall)
    it.AdjustAmountByFuel(fuelToGet, correctionFactor, noSHScaling, noHWScaling)
  end

  def GetOAScalingFactor(fuelToGet)
    it = FuelUseIterator.new(_rollcall)
    return (it.GetOAScalingFactor(fuelToGet))
  end

  def SetOAScalingFactor(fuelToGet, oaScalingFactor)
    it = FuelUseIterator.new(_rollcall)
    it.SetOAScalingFactor(fuelToGet, oaScalingFactor)
  end

  def GetCostForFuel(cv, fuelToGet)
    it = FuelUseIterator.new(_rollcall)
    sc = 0.0
    _totalCost = it.GetCostByFuel(cv, fuelToGet)
    return (_totalCost)
  end

  def GetSCForFuel(cv, fuelToGet)
    it = FuelUseIterator.new(_rollcall)
    sc = 0.0
    _totalCost = it.GetSCByFuel(cv, fuelToGet)
    return (_totalCost)
  end

  def GetProviderCostPerUnit(cv, pProvider, spec, pCommunityDistLossFactor)
    it = FuelUseIterator.new(_rollcall)
    total = 0.0
    total = it.GetUnitCostByProvider(cv, pProvider, spec, pCommunityDistLossFactor)
    return total
  end

  def GetProviderAmount(spec)
    it = FuelUseIterator.new(_rollcall)
    return (it.GetProviderAmount(spec))
  end

  def GetProviderAmount(spec, pProvider)
    it = FuelUseIterator.new(_rollcall)
    return (it.GetProviderAmount(spec, pProvider))
  end

  def GetProviderEmissionsFactor(pProvider, pCommunityDistLossFactor)
    it = FuelUseIterator.new(_rollcall)
    return (it.GetEmissionsFactorByProvider(pProvider, pCommunityDistLossFactor))
  end

  def GetTotalPrimaryEnergyConsumption()
    totalConsumption = 0.0
    it = FuelUseIterator.new(_rollcall)
    totalConsumption = it.GetPrimeEnergyConsumption()
    return (totalConsumption)
  end

  def GetTotalEmissions()
    it = FuelUseIterator.new(_rollcall)
    _totalEmissions = it.GetEmissions(_pDisplacedElectricityRecord.pFuelSpec.GetEmissionsFactor())
    return (_totalEmissions)
  end

  def GetTotalConsumption()
    limit = Table12.GetTableSize() # why can't we use the table12 limit the array was created with in the 1st place?
                                   #int limit = sizeof(_pFuelSummary) / sizeof(*_pFuelSummary); // this wont work because the sizeof a point is always going to be 4.
    pRecord = _pFuelSummary
    totalConsumption = 0.0
    index = 0
    while index < limit
      if pRecord.used then
        totalConsumption += pRecord.quantity
      end
      pRecord += 1
      index += 1
    end
    return (totalConsumption)
  end

  def SetEngineLinks(State)
    if State then
      # Section 10
      _pContext.EngineLink.AddLink(LD_FuelCostMainSystem1FuelCostYear, _mainSystem1FuelCostYear, "Main System 1 Fuel Cost Per Year")
      _pContext.EngineLink.AddLink(LD_FuelCostMainSystem1FuelPrice, _mainSystem1FuelPrice, "Main System 1 Fuel Price")
      _pContext.EngineLink.AddLink(LD_FuelCostMainSystem2FuelCostYear, _mainSystem2FuelCostYear, "Main System 2 Fuel Cost Per Year")
      _pContext.EngineLink.AddLink(LD_FuelCostMainSystem2FuelPrice, _mainSystem2FuelPrice, "Main System 2 Fuel Price")
      _pContext.EngineLink.AddLink(LD_FuelCostSecondaryFuelCostYear, _secondaryFuelCostYear, "Secondary Fuel Cost Per Year")
      _pContext.EngineLink.AddLink(LD_FuelCostSecondaryFuelPrice, _secondaryFuelPrice, "Secondary Fuel Price")
      _pContext.EngineLink.AddLink(LD_FuelCostWaterFuelHighCostYear, _waterFuelHighCostYear, "Water Fuel High Cost Per Year")
      _pContext.EngineLink.AddLink(LD_FuelCostWaterFuelHighPrice, _waterFuelHighPrice, "Water Fuel High Price")
      _pContext.EngineLink.AddLink(LD_FuelCostWaterFuelLowCostYear, _waterFuelLowCostYear, "Water Fuel Low Cost Per Year")
      _pContext.EngineLink.AddLink(LD_FuelCostWaterFuelLowPrice, _waterFuelLowPrice, "Water Fuel Low Price")
      _pContext.EngineLink.AddLink(LD_FuelCostPumpsFansKeephotFuelCostYear, _pumpsFansKeephotFuelCostYear, "Pumps Fans Keep hot Fuel Cost Per Year")
      _pContext.EngineLink.AddLink(LD_FuelCostPumpsFansKeephotFuelPrice, _pumpsFansKeephotFuelPrice, "Pumps Fans Keep hot Fuel Price")
      _pContext.EngineLink.AddLink(LD_FuelCostLightingCostYear, _lightingCostYear, "Lighting Cost Per Year")
      _pContext.EngineLink.AddLink(LD_FuelCostLightingPrice, _lightingPrice, "Lighting Price")
      _pContext.EngineLink.AddLink(LD_FuelCostShowerCostYear, _lightingCostYear, "Shower Cost Per Year")
      _pContext.EngineLink.AddLink(LD_FuelCostShowerPrice, _lightingPrice, "Shower Price")
      _pContext.EngineLink.AddLink(LD_FuelCostApplianceCostYear, _lightingCostYear, "Appliance Cost Per Year")
      _pContext.EngineLink.AddLink(LD_FuelCostAppliancePrice, _lightingPrice, "Appliance Price")
      _pContext.EngineLink.AddLink(LD_FuelCostCookingCostYear, _lightingCostYear, "Cooking Cost Per Year")
      _pContext.EngineLink.AddLink(LD_FuelCostCookingPrice, _lightingPrice, "Cooking Price")
      _pContext.EngineLink.AddLink(LD_FuelCostAdditionalStandingCharges, _additionalStandingCharges, "Additional Standing Charges")
      _pContext.EngineLink.AddLink(LD_FuelCostTotalCost, _totalCost, "Total Cost")
      # Section 12
      _pContext.EngineLink.AddLink(LD_FuelCostMainSystem1EmissionFactor, _mainSystem1EmissionFactor, "Main System 1 Emission Factor")
      _pContext.EngineLink.AddLink(LD_FuelCostMainSystem1EmissionsYear, _mainSystem1EmissionsYear, "Main System 1 Emissions Year")
      _pContext.EngineLink.AddLink(LD_FuelCostMainSystem2EmissionFactor, _mainSystem2EmissionFactor, "Main System 2 Emission Factor")
      _pContext.EngineLink.AddLink(LD_FuelCostMainSystem2EmissionsYear, _mainSystem2EmissionsYear, "Main System 2 Emissions Year")
      _pContext.EngineLink.AddLink(LD_FuelCostSecondaryEmissionFactor, _secondaryEmissionFactor, "Secondary Emission Factor")
      _pContext.EngineLink.AddLink(LD_FuelCostSecondaryEmissionsYear, _secondaryEmissionsYear, "Secondary Emissions Year")
      _pContext.EngineLink.AddLink(LD_FuelCostWaterEmissionFactor, _waterEmissionFactor, "Water Emission Factor")
      _pContext.EngineLink.AddLink(LD_FuelCostWaterEmissionsYear, _waterEmissionsYear, "Water Emissions Year")
      _pContext.EngineLink.AddLink(LD_FuelCostPumpsFansKeephotEmissionFactor, _pumpsFansKeephotEmissionFactor, "Pumps Fans Keep hot Emission Factor")
      _pContext.EngineLink.AddLink(LD_FuelCostPumpsFansKeephotEmissionsYear, _pumpsFansKeephotEmissionsYear, "Pumps Fans Keep hot Emissions Year")
      _pContext.EngineLink.AddLink(LD_FuelCostLightingEmissionFactor, _lightingEmissionFactor, "Lighting Emission Factor")
      _pContext.EngineLink.AddLink(LD_FuelCostLightingEmissionsYear, _lightingEmissionsYear, "Lighting Emissions Year")
      _pContext.EngineLink.AddLink(LD_FuelCostShowerEmissionFactor, _showerEmissionFactor, "Shower Emission Factor")
      _pContext.EngineLink.AddLink(LD_FuelCostShowerEmissionsYear, _showerEmissionsYear, "Shower Emissions Year")
      _pContext.EngineLink.AddLink(LD_FuelCostApplianceEmissionFactor, _applianceEmissionFactor, "Appliance Emission Factor")
      _pContext.EngineLink.AddLink(LD_FuelCostApplianceEmissionsYear, _applianceEmissionsYear, "Appliance Emissions Year")
      _pContext.EngineLink.AddLink(LD_FuelCostCookingEmissionFactor, _cookingEmissionFactor, "Cooking Emission Factor")
      _pContext.EngineLink.AddLink(LD_FuelCostCookingEmissionsYear, _cookingEmissionsYear, "Cooking Emissions Year")
    else
      Links = LD_FuelCostMainSystem1FuelCostYearLD_FuelCostMainSystem1FuelPriceLD_FuelCostMainSystem2FuelCostYearLD_FuelCostMainSystem2FuelPriceLD_FuelCostSecondaryFuelCostYearLD_FuelCostSecondaryFuelPriceLD_FuelCostWaterFuelHighCostYearLD_FuelCostWaterFuelHighPriceLD_FuelCostWaterFuelLowCostYearLD_FuelCostWaterFuelLowPriceLD_FuelCostPumpsFansKeephotFuelCostYearLD_FuelCostPumpsFansKeephotFuelPriceLD_FuelCostLightingCostYearLD_FuelCostLightingPriceLD_FuelCostShowerCostYearLD_FuelCostShowerPriceLD_FuelCostApplianceCostYearLD_FuelCostAppliancePriceLD_FuelCostCookingCostYearLD_FuelCostCookingPriceLD_FuelCostTotalCostLD_FuelCostAdditionalStandingChargesLD_FuelCostMainSystem1EmissionFactorLD_FuelCostMainSystem1EmissionsYearLD_FuelCostMainSystem2EmissionFactorLD_FuelCostMainSystem2EmissionsYearLD_FuelCostSecondaryEmissionFactorLD_FuelCostSecondaryEmissionsYearLD_FuelCostWaterEmissionFactorLD_FuelCostWaterEmissionsYearLD_FuelCostPumpsFansKeephotEmissionFactorLD_FuelCostPumpsFansKeephotEmissionsYearLD_FuelCostLightingEmissionFactorLD_FuelCostLightingEmissionsYearLD_FuelCostShowerEmissionFactorLD_FuelCostShowerEmissionsYearLD_FuelCostApplianceEmissionFactorLD_FuelCostApplianceEmissionsYearLD_FuelCostCookingEmissionFactorLD_FuelCostCookingEmissionsYear
      _pContext.EngineLink.RemoveLinks(List[LinkData].new(Links, Links + (Links.Length)))
    end
  end
end

class FuelUsage
  def initialize(cat, spec, fuel, co2EmissionsFactor, primaryFactor, amount, pSummary, pProvider, pContext)
    self.@_category = cat
    self.@_specification = spec
    self.@_fuelCode = fuel
    self.@_amount = amount
    self.@_context = pContext
    self.@_pProvider = pProvider
    self.@_pSummary = pSummary
    _pSummary.quantity { self.amount() }
    _pSummary.used = true
    _pSummary.usedWhere[_category] = true
    _pAdjustedEmissionsFactor = System.Double.new(co2EmissionsFactor)
    _pAdjustedPrimaryFactor = System.Double.new(primaryFactor)
    _oaScalingFactor = 0.0
  end

  def initialize(cat, spec, fuel, co2EmissionsFactor, primaryFactor, amount, pSummary, pProvider, pContext)
    self.@_category = cat
    self.@_specification = spec
    self.@_fuelCode = fuel
    self.@_amount = amount
    self.@_context = pContext
    self.@_pProvider = pProvider
    self.@_pSummary = pSummary
    _pSummary.quantity { self.amount() }
    _pSummary.used = true
    _pSummary.usedWhere[_category] = true
    _pAdjustedEmissionsFactor = System.Double.new(co2EmissionsFactor)
    _pAdjustedPrimaryFactor = System.Double.new(primaryFactor)
    _oaScalingFactor = 0.0
  end

  def GetCost(cv)
    return (_amount * _pSummary.pFuelSpec.GetCostPerUnit(cv, _amount) * 0.01)
  end

  def GetUnitCost(cv)
    return (_pSummary.pFuelSpec.GetCostPerUnit(cv, _amount))
  end

  def GetEmissionsFactor()
    return ((_pAdjustedEmissionsFactor == nil) ? _pSummary.pFuelSpec.GetEmissionsFactor() : )
  end

  def GetEmissions()
    return (_amount * self.GetEmissionsFactor())
  end

  def GetPrimaryEnergy()
    return (_amount * ((_pAdjustedPrimaryFactor == nil) ? _pSummary.pFuelSpec.GetPrimaryEnergyFactor() : ))
  end

  def CompareProvider(pProvider)
    if _pProvider == pProvider then
      return (true)
    end
    return (false)
  end

  def GetCategory()
    return (_category)
  end

  def IsSpaceOrWaterHeating()
    case _category
      when FU_SPACE_HEATING, FU_WATER_HEATING
        # added secondary provision to fix TC18 - this is used for alternative summer water heating
        result = (_specification == FUS_PRIMARY_PROVISION or _specification == FUS_SECONDARY_PROVISION)
        break
      when FU_SPACE_HEATING_SECONDARY
        if Table12.GetFuelCategory(_fuelCode) == FC_ELECTRIC then
          result = false
        else
          result = (_specification == FUS_PRIMARY_PROVISION or _specification == FUS_SECONDARY_PROVISION)
        end
        break
      else
        result = false
        break
    end
    return (result)
  end

  def IsExcludedFromCosts()
    result = false
    case _specification
      when FUS_CARBON_CREDIT, FUS_CH_CARBON_LOAD
        result = true
        break
    end
    return (result)
  end

  def GetAmount()
    return (_amount)
  end

  def AdjustAmount(correctionFactor)
    _amount = _amount * correctionFactor
  end

  def GetStandingCharge(cv)
    return (_pSummary.pFuelSpec.GetStandingCharge(cv, _amount))
  end

  def Dispose()
    if _pAdjustedEmissionsFactor != nil then
      _pAdjustedEmissionsFactor = nil
      _pAdjustedEmissionsFactor = nil
    end
    if _pAdjustedPrimaryFactor != nil then
      _pAdjustedPrimaryFactor = nil
      _pAdjustedPrimaryFactor = nil
    end
  end
end

class FuelUseIterator
  def initialize(?)
  @FuelUsage =  > pList
  end
end
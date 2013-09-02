class FuelSpecification
  def initialize(fuel)
    self.@_code = fuel
    pData = Table12.GetTableEntry(_code)
    if pData == nil then
      raise EngineException.new("Unsupported fuel code used to construction a FuelSpecification")
    end
    _pBillData = nil
    _code = fuel
    _primaryEnergyFactor = pData.primaryEnergy
    _co2EmissionFactor = pData.emissionsCO2
    _standardPrice.costPerUnit = pData.unitPrice
    _standardPrice.standingCharge = pData.stdCharge
  end

  def Dispose()
  end

  def SetSpotPriceData(unitPrice, standingCharge)
    _spotPrice.SetValue(self.FUEL_COST(standingCharge, unitPrice))
  end

  def GetCostPerUnit(cv, amount)
    return self.GetCost(cv, FUEL_COST.costPerUnit, amount)
  end

  def GetCost(cv, FUEL_COST)
  end

  def GetAverageCost(FUEL_COST)
  end

  def IsMainsGasOrElectric(fuel)
    isMainsGasOrElectric = false
    if fuel == F_ELEC_STANDARD or fuel == F_ELEC_7HOUR_ONPEAK or fuel == F_ELEC_7HOUR_OFFPEAK or fuel == F_ELEC_10HOUR_ONPEAK or fuel == F_ELEC_10HOUR_OFFPEAK or fuel == F_ELEC_24HOUR or fuel == F_ELEC_SOLD or fuel == F_ELEC_DISPLACED or fuel == F_ELEC_UNSPECIFIED or fuel == F_GAS_MAINS or fuel == F_GAS_LPG_SC18 then #Special Condition 18 LPG behaves like mains gas
                                                                                                                                                                                                                                                                                                                               #fuel == F_GAS_BOTTLED_LPG		||
      isMainsGasOrElectric = true
    end
    return isMainsGasOrElectric
  end

  def IsCommunityHeating(fuel)
    isCommunity = false
    if fuel == F_COMMUNITY_MAINS_GAS or fuel == F_COMMUNITY_LPG or fuel == F_COMMUNITY_OIL or fuel == F_COMMUNITY_B30D or fuel == F_COMMUNITY_COAL or fuel == F_COMMUNITY_ELEC_HEATPUMP or fuel == F_COMMUNITY_WASTE_COMBUSTION or fuel == F_COMMUNITY_BIOMASS or fuel == F_COMMUNITY_BIOGAS or fuel == F_COMMUNITY_POWERSTATION_WASTE or fuel == F_COMMUNITY_GEOTHERMAL or fuel == F_COMMUNITY_CHP_HEAT or fuel == F_COMMUNITY_CHP_ELEC or fuel == F_COMMUNITY_ELEC_DNET then
      isCommunity = true
    end
    return isCommunity
  end

  def GetStandingCharge(cv, amount)
    return self.GetCost(cv, FUEL_COST.standingCharge, amount)
  end

  def GetEmissionsFactor()
    return (_co2EmissionFactor)
  end

  def GetPrimaryEnergyFactor()
    return (_primaryEnergyFactor)
  end

end
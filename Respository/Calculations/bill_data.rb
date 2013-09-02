class BillData
  def initialize(fuel, chargingBasis, billingUnit, billingPeriod, quantity, fuelBillDataSource, unitPrice, initialUnitsBasisPeriod, secondaryUnitPrice, startQuantitySecondary, standingCharge, standingChargeBasisPeriod, fixedCost, totalCost, elecGenerationPvs, elecGenerationWind, elecGenerationHydro, elecGenerationMicroCHP, includesVAT, scalingFactor, unUsualEnergyItem)
    _fuel = fuel
    _chargingBasis = chargingBasis
    _billingUnit = billingUnit
    _billingPeriod = billingPeriod
    _quantity = quantity
    _fuelBillDataSource = fuelBillDataSource
    _unitPrice = unitPrice
    _initialUnitsBasisPeriod = initialUnitsBasisPeriod
    _secondaryUnitPrice = secondaryUnitPrice
    _startQuantitySecondary = startQuantitySecondary
    _standingCharge = standingCharge
    _standingChargeBasisPeriod = standingChargeBasisPeriod
    _fixedCost = fixedCost
    _totalCost = totalCost
    _elecGenerationPvs = elecGenerationPvs
    _elecGenerationWind = elecGenerationWind
    _elecGenerationHydro = elecGenerationHydro
    _elecGenerationMicroCHP = elecGenerationMicroCHP
    _includesVAT = includesVAT
    _scalingFactor = scalingFactor
    _unusualEnergyItem = unUsualEnergyItem
  end

  def GetStandingChargeBasisFactor()
    periodFactor = 1.0
    if self.GetStandingChargeBasisPeriod() == SCBP_PENCE_PERDAY then
      periodFactor = 365
    elsif self.GetStandingChargeBasisPeriod() == SCBP_POUNDS_PERMONTH then
      periodFactor = 12.0
    elsif self.GetStandingChargeBasisPeriod() == SCBP_POUNDS_PERQUARTER then
      periodFactor = 4.0
    end
    return periodFactor
  end

  def GetTwoUnitChargeBasisFactor()
    periodFactor = 1.0
    if self.GetInitialUnitsBasisPeriod() == IUBP_PERMONTH then
      periodFactor = 12.0
    elsif self.GetInitialUnitsBasisPeriod() == IUBP_PERQUARTER then
      periodFactor = 4.0
    end
    return periodFactor
  end

  def GetFuelFactor()
    fuelFactor = 1.0
    if self.GetFuel() == F_ELEC_10HOUR_OFFPEAK or self.GetFuel() == F_ELEC_10HOUR_ONPEAK or self.GetFuel() == F_ELEC_24HOUR or self.GetFuel() == F_ELEC_7HOUR_OFFPEAK or self.GetFuel() == F_ELEC_7HOUR_ONPEAK or self.GetFuel() == F_ELEC_DISPLACED or self.GetFuel() == F_ELEC_STANDARD or self.GetFuel() == F_ELEC_UNSPECIFIED or self.GetFuel() == F_COMMUNITY_CHP_ELEC or self.GetFuel() == F_COMMUNITY_ELEC_DNET or self.GetFuel() == F_COMMUNITY_ELEC_HEATPUMP then
      fuelFactor = 1.0
    elsif self.GetFuel() == F_GAS_BULK_LPG then
      fuelFactor = 7.11
    elsif self.GetFuel() == F_GAS_BOTTLED_LPG then
      fuelFactor = 13.89
    elsif self.GetFuel() == F_BIOETHANOL then
      fuelFactor = 5.9
    elsif self.GetFuel() == F_HOUSECOAL then
      fuelFactor = 8.34
    elsif self.GetFuel() == F_SMOKELESS then
      fuelFactor = 8.90
    elsif self.GetFuel() == F_ANTHRACITE then
      fuelFactor = 9.66
    elsif self.GetFuel() == F_WOOD_PELLETS_BAGGED or self.GetFuel() == F_WOOD_PELLETS_BULK then
      fuelFactor = 4.7
    elsif self.GetFuel() == F_WOOD_CHIPS then
      fuelFactor = 3.5
    elsif self.GetFuel() == F_WOOD_LOGS and self.GetBillingUnit() == BU_KG then
      fuelFactor = 4.1
    elsif self.GetFuel() == F_WOOD_LOGS and self.GetBillingUnit() == BU_CUBICMETRES then
      fuelFactor = 1400
    else # liquid fuels
      fuelFactor = 10.35
    end
    return fuelFactor
  end

  def GetBillingUnitFactor()
    billingUnitFactor = 1.0
    # Note: Wood Logs are supplied in £ per m3. ALl other units are in pence
    if self.GetBillingUnit() == BU_CUBICMETRES then
    end
    #billingUnitFactor = 100.0;
    return billingUnitFactor
  end

  def GetSplitUnitsSC()
    firstUnitPrice = self.GetUnitPrice() * (_includesVAT == 0 ? 1.05 : 1)
    secondUnitPrice = self.GetSecondaryUnitPrice() * (_includesVAT == 0 ? 1.05 : 1)
    if self.GetChargingBasis() == CB_TWOUNITPRICES then
      return (0.01 * self.GetStartQuantitySecondary() * (firstUnitPrice - secondUnitPrice) * self.GetTwoUnitChargeBasisFactor())
    else
      return (0.0)
    end
  end

  def GetStandingCharge()
    sc = _standingCharge * self.GetStandingChargeBasisFactor() * (_includesVAT == 0 ? 1.05 : 1)
    if self.GetStandingChargeBasisPeriod() == SCBP_PENCE_PERDAY then
      #convert to pounds
      sc = sc / 100
    end
    if _fuel == F_COMMUNITY_MAINS_GAS or _fuel == F_COMMUNITY_LPG or _fuel == F_COMMUNITY_OIL or _fuel == F_COMMUNITY_B30D or _fuel == F_COMMUNITY_COAL or _fuel == F_COMMUNITY_ELEC_HEATPUMP or _fuel == F_COMMUNITY_WASTE_COMBUSTION or _fuel == F_COMMUNITY_BIOMASS or _fuel == F_COMMUNITY_BIOGAS or _fuel == F_COMMUNITY_POWERSTATION_WASTE or _fuel == F_COMMUNITY_GEOTHERMAL or _fuel == F_COMMUNITY_CHP_HEAT or _fuel == F_COMMUNITY_CHP_ELEC or _fuel == F_COMMUNITY_ELEC_DNET then
      #Community standing charges are missed when adding the SH/HW charges so return here
      sc = _fixedCost * (_includesVAT == 0 ? 1.05 : 1)
    end
    return (sc + 0.5)
  end

  def GetQuantityKwh()
    kWh = (_quantity / _billingPeriod) * 12
    return kWh
  end
end
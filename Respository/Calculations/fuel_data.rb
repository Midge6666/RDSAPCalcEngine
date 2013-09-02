class FuelData
  def initialize()
    fuelCount = Table12.GetTableSize()
    index = 0
    while index < fuelCount
      fuel = Table12.GetFuelByIndex(index)
      _fuelMap.insert(self.pair(fuel, FuelSpecification.new(fuel)))
      index += 1
    end
  end

  def SetSpotCostData(fuel, unitPrice, standingCharge)
    _fuelMap[fuel].SetSpotPriceData(unitPrice, standingCharge)
  end

  def SetOccupancy(pOccupancy, isStandardOccupancy)
    communityBillData = nil
    if pOccupancy != nil and pOccupancy.IsGreenDealOccupancy(BILL_RECONCILIATION) then
      it = _fuelMap.begin()
      while it.MoveNext()
        fuelCode = it.Current.Value.GetFuelCode()
        billData = pOccupancy.GetBillForFuel(fuelCode)
        if billData != nil then
          #If there is bill data for any community scheme, set the same data for CHP too.
          if fuelCode == F_COMMUNITY_B30D or fuelCode == F_COMMUNITY_BIOGAS or fuelCode == F_COMMUNITY_BIOMASS or fuelCode == F_COMMUNITY_COAL or fuelCode == F_COMMUNITY_ELEC_DNET or fuelCode == F_COMMUNITY_ELEC_HEATPUMP or fuelCode == F_COMMUNITY_GEOTHERMAL or fuelCode == F_COMMUNITY_LPG or fuelCode == F_COMMUNITY_MAINS_GAS or fuelCode == F_COMMUNITY_OIL or fuelCode == F_COMMUNITY_POWERSTATION_WASTE or fuelCode == F_COMMUNITY_WASTE_COMBUSTION then
            communityBillData = billData
          end
          it.Current.Value.SetBillData(billData)
          it.Current.Value.SetIsStandardOccupancy(isStandardOccupancy)
        end
      end
      if communityBillData != nil then
        it = _fuelMap.begin()
        while it.MoveNext()
          if it.Current.Value.GetFuelCode() == F_COMMUNITY_CHP_HEAT then
            it.Current.Value.SetBillData(communityBillData)
          end
        end
      end
    end
  end

  def UnsetOccupancy(pOccupancy)
    if pOccupancy != nil then
      it = _fuelMap.begin()
      while it.MoveNext()
        fuelCode = it.Current.Value.GetFuelCode()
        billData = pOccupancy.GetBillForFuel(fuelCode)
        if billData != nil then
          it.Current.Value.SetBillData(nil)
        end
      end
    end
  end

  def GetFuelSpecification(fuel)
    return (_fuelMap.find(fuel).second)
  end

  def Dispose()
    it = _fuelMap.begin()
    while it.MoveNext()
      self.delete(it.Current.Value)
    end
    _fuelMap.clear()
  end
end
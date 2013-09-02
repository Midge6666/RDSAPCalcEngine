class Occupancy
  def initialize(pTable1b)
    _stdOccupancy = true
    _occupants.SetValue(pTable1b.GetAssumedOccupants(), DS_TABLE, "table1b")
    _OAOccupants.SetValue(0, DS_SUPPLIED)
    _ovenFuel.SetValue(F_NO_FUEL, DS_SUPPLIED)
    _isGreenDealOccupancy.SetValue(false, DS_TABLE)
    _chimneyFlueCountSet = false
  end

  def initialize(pTable1b)
    _stdOccupancy = true
    _occupants.SetValue(pTable1b.GetAssumedOccupants(), DS_TABLE, "table1b")
    _OAOccupants.SetValue(0, DS_SUPPLIED)
    _ovenFuel.SetValue(F_NO_FUEL, DS_SUPPLIED)
    _isGreenDealOccupancy.SetValue(false, DS_TABLE)
    _chimneyFlueCountSet = false
  end

  def initialize(pTable1b)
    _stdOccupancy = true
    _occupants.SetValue(pTable1b.GetAssumedOccupants(), DS_TABLE, "table1b")
    _OAOccupants.SetValue(0, DS_SUPPLIED)
    _ovenFuel.SetValue(F_NO_FUEL, DS_SUPPLIED)
    _isGreenDealOccupancy.SetValue(false, DS_TABLE)
    _chimneyFlueCountSet = false
  end

  def Dispose()
    it = _habitableRooms.begin()
    while it != _habitableRooms.end()
      self.delete()
      it += 1
    end
    _habitableRooms.clear()
    bit = _billData.begin()
    while bit != _billData.end()
      self.delete()
      bit += 1
    end
    _billData.clear()
  end

  def IsGreenDealOccupancy(calcSection)
    return _isGreenDealOccupancy and _calcSections > 0 and ((_calcSections & calcSection) == calcSection)
  end

  def SetIsGreenDealOccupancy(isGreenDealOccupancy)
    _isGreenDealOccupancy.SetValue(isGreenDealOccupancy, DS_SUPPLIED)
  end

  def SetUseStandardOccupancy(useStandardOccupancy)
    _stdOccupancy = useStandardOccupancy
  end

  def SetMainsGasAvailable(mainsGasAvailable)
    _mainsGasAvailable = mainsGasAvailable
  end

  def SetCalcSections(calcSections)
    _calcSections.SetValue(calcSections, DS_SUPPLIED)
  end

  def GetIsStandardOccupancy()
    return _stdOccupancy
  end

  def GetOccupantCount()
    return _stdOccupancy ? _occupants : _OAOccupants
  end

  def GetStandardOccupantCount()
    return _occupants
  end

  def SetNumberOccupants(Occupants)
    _OAOccupants.SetValue(Occupants, DS_SUPPLIED)
  end

  def SetStandardOccupants(pTable1b)
    _occupants.SetValue(pTable1b.GetAssumedOccupants(), DS_TABLE, "table1b")
  end

  def GetUnoccupied()
    return _unoccupied
  end

  def SetUnoccupied(unoccupied)
    _unoccupied.SetValue(unoccupied, DS_SUPPLIED)
  end

  def GetLivingAreaTemperature()
    # When standard occupancy unknown the living rooom temp is set to 0. In this case 21 deg C should be used.
    return _stdOccupancy or _livingAreaTemp == 0 ? 21 : _livingAreaTemp
  end

  def GetNumberAlternateDays()
    return _stdOccupancy ? 2 : _numberAlternateDays
  end

  def SetLivingAreaTemperature(livingAreaTemp)
    _livingAreaTemp.SetValue(livingAreaTemp, DS_SUPPLIED)
  end

  def SetNumberAlternateDays(numberAlternateDays)
    _numberAlternateDays.SetValue(numberAlternateDays, DS_SUPPLIED)
  end

  def GetTypeOfShower()
    return _stdOccupancy ? SHOWER_UNKNOWN : _typeOfShower
  end

  def SetTypeOfShower(typeOfShower)
    _typeOfShower.SetValue(typeOfShower, DS_SUPPLIED)
  end

  def GetShowersPerDayKnown()
    return _stdOccupancy ? NO : _showersPerDayKnown
  end

  def SetShowersPerDayKnown(showersPerDayKnown)
    _showersPerDayKnown.SetValue(showersPerDayKnown, DS_SUPPLIED)
  end

  def GetShowersPerDay()
    return _stdOccupancy ? (0.45 * Occupancy.GetOccupantCount()) + 0.65 : self.GetShowersPerDayKnown() == NO ? (0.45 * Occupancy.GetOccupantCount()) + 0.65 : _showersPerDay
  end

  def SetShowersPerDay(showersPerDay)
    _showersPerDay.SetValue(showersPerDay, DS_SUPPLIED)
  end

  def GetBathsPerDayKnown()
    return _stdOccupancy ? NO : _bathsPerDayKnown
  end

  def SetBathsPerDayKnown(bathsPerDayKnown)
    _bathsPerDayKnown.SetValue(bathsPerDayKnown, DS_SUPPLIED)
  end

  def GetBathsPerDay()
    if _stdOccupancy then
      return 1.0
    else
      if self.GetBathsPerDayKnown() == YES then
        return _bathsPerDay
      else
        if self.GetTypeOfShower() == SHOWER_NONE then
          return (0.35 * Occupancy.GetOccupantCount()) + 0.5
        else
          return (0.13 * Occupancy.GetOccupantCount()) + 0.19
        end
      end
    end
  end

  def SetBathsPerDay(bathsPerDay)
    _bathsPerDay.SetValue(bathsPerDay, DS_SUPPLIED)
  end

  def GetHobType()
    if _stdOccupancy then
      if _mainsGasAvailable then
        return CRF_GASELECTRIC
      else
        return CRF_ELECTRIC
      end
    end
    return _hobType
  end

  def SetHobType(hobType)
    _hobType.SetValue(hobType, DS_SUPPLIED)
  end

  def GetOvenType()
    return _stdOccupancy ? COOKING_NORMAL : _ovenType
  end

  def SetOvenType(ovenType)
    _ovenType.SetValue(ovenType, DS_SUPPLIED)
  end

  def GetOvenFuel()
    return _ovenFuel
  end

  def SetOvenFuel(ovenFuel)
    _ovenFuel.SetValue(ovenFuel, DS_SUPPLIED)
  end

  def GetTumbleDryerFraction()
    return _stdOccupancy ? 25.0 / 100.0 : _tumbleDryerFraction
  end

  def SetTumbleDryerFraction(tumbleDryerPerc)
    val = tumbleDryerPerc / 100.0
    _tumbleDryerFraction.SetValue(val, DS_SUPPLIED)
  end

  def GetStandaloneFridgeCount()
    return _stdOccupancy ? 1 : _standaloneFridgeCount
  end

  def SetStandaloneFridgeCount(standalongFridgeCount)
    _standaloneFridgeCount.SetValue(standalongFridgeCount, DS_SUPPLIED)
  end

  def GetStandalongFreezerCount()
    return _stdOccupancy ? 1 : _standalongFreezerCount
  end

  def SetStandaloneFreezerCount(standaloneFreezerCount)
    _standalongFreezerCount.SetValue(standaloneFreezerCount, DS_SUPPLIED)
  end

  def GetFridgeFreezerCount()
    return _stdOccupancy ? 0 : _fridgeFreezerCount
  end

  def SetFridgeFreezerCount(fridgeFreezerCount)
    _fridgeFreezerCount.SetValue(fridgeFreezerCount, DS_SUPPLIED)
  end

  def AddHabitableRoom(isLivingRoom, heatedByPrimaryA, heatedByPrimaryB, heatedBySecondary, partiallyHeated)
    habitableRoom = HabitableRoom.new(isLivingRoom, heatedByPrimaryA, heatedByPrimaryB, heatedBySecondary, partiallyHeated)
    _habitableRooms.push_back(habitableRoom)
  end

  def AddBillData(fuel, chargingBasis, billingUnit, billingPeriod, quantity, fuelBillDataSource, unitPrice, initialUnitsBasisPeriod, secondaryUnitPrice, startQuantitySecondary, standingCharge, standingChargeBasisPeriod, fixedCost, totalCost, elecGenerationPvs, elecGenerationWind, elecGenerationHydro, elecGenerationMicroCHP, includesVAT, scalingFactor, unUsualEnergyItem)
    billData = BillData.new(fuel, chargingBasis, billingUnit, billingPeriod, quantity, fuelBillDataSource, unitPrice, initialUnitsBasisPeriod, secondaryUnitPrice, startQuantitySecondary, standingCharge, standingChargeBasisPeriod, fixedCost, totalCost, elecGenerationPvs, elecGenerationWind, elecGenerationHydro, elecGenerationMicroCHP, includesVAT, scalingFactor, unUsualEnergyItem)
    _billData.push_back(billData)
  end

  def GetHabitableRoomFigures(numUnheated, numPartially, numHeatedBySecondaryOnly, numTotal)
    pHabitableRoom = nil
    habitableRoomVect = self.GetHabitableRooms()
    it = habitableRoomVect.begin()
    while it.MoveNext()
      if not (it.Current).GetHeatedByPrimaryA() and not (it.Current).GetHeatedByPrimaryB() and not (it.Current).GetHeatedBySecondary() and not (it.Current).GetPartiallyHeated() then
        numUnheated += 1
      end
      if (it.Current).GetPartiallyHeated() then
        numPartially += 1
      end
      if not (it.Current).GetHeatedByPrimaryA() and not (it.Current).GetHeatedByPrimaryB() and (it.Current).GetHeatedBySecondary() then
        numHeatedBySecondaryOnly += 1
      end
      numTotal += 1
    end
    numTotal += 0.5
  end

  def GetBillForFuel(fuel)
    pBillData = nil
    billDataVect = self.GetBillData()
    it = billDataVect.begin()
    while it.MoveNext()
      # Fuel Factor as per Table V7 - Calorific values
      fuelFactor = 1.0
      if (it.Current).GetFuel() == fuel then
        pBillData = (it.Current)
        break
      end
    end
    return pBillData
  end

  def CalculateOccAssessmentSecondaryHeatingFraction(pHeatingSystemData, pAppendixN)
    fraction = 0
    habitableRoomVect = self.GetHabitableRooms()
    if pAppendixN != nil then
      return Round2 < System::Double
    end
    firstC = true
    it = habitableRoomVect.begin()
    while it.MoveNext()
      if (it.Current).GetIsLivingRoom() and (it.Current).GetHeatedBySecondary() then
        if pHeatingSystemData.GetPrimarySystemData(0).IsMicrogenSystem() or (pHeatingSystemData.GetPrimarySystemData(0).IsHeatpump() and pHeatingSystemData.GetPrimarySystemData(0).IsFromProductDatabase()) then
          fraction += pAppendixN.GetSecondaryFraction(self.const_cast(pHeatingSystemData))
        else
          fraction += Table11.GetSecondaryFraction(pHeatingSystemData.GetPrimarySystemData(0), pHeatingSystemData.GetSecondarySystemData())
        end
      end
      if not (it.Current).GetIsLivingRoom() and ((it.Current).GetHeatedByPrimaryA() or (it.Current).GetHeatedByPrimaryB()) and (it.Current).GetHeatedBySecondary() then
        next
      end
      if not (it.Current).GetIsLivingRoom() and not (it.Current).GetHeatedByPrimaryA() and not (it.Current).GetHeatedByPrimaryB() and (it.Current).GetHeatedBySecondary() and firstC then
        fraction += 0.25 / (habitableRoomVect.size() - 1)
        firstC = false
      end
    end
    return Round2 < System::Double
  end

  def CalculateOccAssessmentMainHeatingFraction(systemIndex, pHeatingSystemData, pAppendixN, ignoreSecondary)
    mainFractionA = 0
    mainFractionB = 0
    secondaryFraction = self.CalculateOccAssessmentSecondaryHeatingFraction(pHeatingSystemData, pAppendixN)
    heatedByBothAandBFactor = 0.5
    roomFactor = 1
    heatedFactor = 1
    habitableRoomVect = self.GetHabitableRooms()
    it = habitableRoomVect.begin()
    while it.MoveNext()
      roomFactor = (it.Current).GetIsLivingRoom() ? 1.5 : 1.0
      heatedFactor = (it.Current).GetPartiallyHeated() ? 0.5 : 1.0
      if (it.Current).GetHeatedByPrimaryA() and (it.Current).GetHeatedByPrimaryB() then
        mainFractionA += roomFactor * heatedByBothAandBFactor * heatedFactor
        mainFractionB += roomFactor * heatedByBothAandBFactor * heatedFactor
      elsif (it.Current).GetHeatedByPrimaryA() then
        mainFractionA += roomFactor * heatedFactor
      elsif (it.Current).GetHeatedByPrimaryB() then
        mainFractionB += roomFactor * heatedFactor
      end
    end
    # Now Proportion and return the system required.
    overallMainSystems = ignoreSecondary ? 1 : 1 - secondaryFraction
    main2Fraction = Round2 < System::Double
    2 > ((mainFractionB / (mainFractionA + mainFractionB)))
    mainFractionB = overallMainSystems * main2Fraction
    mainFractionA = overallMainSystems * (1 - main2Fraction)
    return systemIndex == 0 ? mainFractionA : mainFractionB
  end

  def GetIsMinus1()
    return _isMinus1
  end

  def SetIsMinus1(isMinus1)
    _isMinus1 = isMinus1
  end

  def SetFlues(primary1, primary2, secondary)
    _primary1Flue = primary1
    _primary2Flue = primary2
    _secondaryFlue = secondary
    _chimneyFlueCountSet = true
  end

  def GetFlues(primary1, primary2, secondary)
    primary1 = _primary1Flue
    primary2 = _primary2Flue
    secondary = _secondaryFlue
  end

  def GetFluesSet()
    return (_chimneyFlueCountSet)
  end
end
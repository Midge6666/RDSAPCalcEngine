class GreenDealOccProvider
  def initialize(pContext, pCHPProvider, pPVProvider, pWindProvider)
    self.RegisterEngineContext(pContext)
    _pCHPProvider = pCHPProvider
    _pPVProvider = pPVProvider
    _pWindProvider = pWindProvider
  end

  def initialize(pContext, pCHPProvider, pPVProvider, pWindProvider)
    self.RegisterEngineContext(pContext)
    _pCHPProvider = pCHPProvider
    _pPVProvider = pPVProvider
    _pWindProvider = pWindProvider
  end

  def Dispose()
  end

  def GetTariffFromBills(pOccupancy, currentTariff)
    tariff = currentTariff
    billDataVect = pOccupancy.GetBillData()
    it = billDataVect.begin()
    while it.MoveNext()
      # Fuel Factor as per Table V7 - Calorific values
      fuelFactor = 1.0
      if (it.Current).GetFuel() == F_ELEC_10HOUR_OFFPEAK or (it.Current).GetFuel() == F_ELEC_10HOUR_ONPEAK or (it.Current).GetFuel() == F_ELEC_24HOUR or (it.Current).GetFuel() == F_ELEC_7HOUR_OFFPEAK or (it.Current).GetFuel() == F_ELEC_7HOUR_ONPEAK or (it.Current).GetFuel() == F_ELEC_DISPLACED or (it.Current).GetFuel() == F_ELEC_STANDARD or (it.Current).GetFuel() == F_ELEC_UNSPECIFIED or (it.Current).GetFuel() == F_COMMUNITY_CHP_ELEC or (it.Current).GetFuel() == F_COMMUNITY_ELEC_DNET or (it.Current).GetFuel() == F_COMMUNITY_ELEC_HEATPUMP then
        tariff = (it.Current).GetFuel()
        break
      end
    end
    return tariff
  end

  def Calculate(pRegister, pAppendixL, onPeakFraction, elecTariff, pOccupancy)
    if elecTariff == F_ELEC_24HOUR then
      # 24 hour tariff is for heating only (use standard tariff for green deal occ additional items)
      elecTariff = F_ELEC_STANDARD
    end
    # V6.1 Add the additionally Calculated Fuel usage for OA for electric
    self.AddElectricFuelUsage(pRegister, pAppendixL, onPeakFraction, elecTariff, pOccupancy)
    # V6.1 Add the additionally Calculated Fuel usage for OA for Cooking if other fuel used.
    self.AddOtherCookingFuelUsage(pRegister, pAppendixL, onPeakFraction, pOccupancy)
    # V6.3 Adjustment of calculated fuel.
    self.AdjustCalculatedFuelUsage(pRegister, pOccupancy, onPeakFraction)
  end

  def AddElectricFuelUsage(pRegister, pAppendixL, onPeakFraction, elecTariff, pOccupancy)
    # Now get the calculated Green Deal Occupancy - new energy uses for electric including prop of Cooking electric
    isCookerEnergyElectric = false
    lightingUse = pAppendixL.GetAnnualLightingEnergyUse()
    showerUse = pAppendixL.GetAnnualShowerEnergyUse()
    applianceUse = pAppendixL.GetAnnualApplianceEnergyUse()
    cookingUse = pAppendixL.GetAnnualCookingElectricEnergyUse()
    cookingOnPeakFraction = onPeakFraction
    if onPeakFraction < 1.0 then
      if pOccupancy.GetOvenType() == COOKING_ALWAYSHOTALLYEAR or pOccupancy.GetOvenType() == COOKING_ALWAYSHOTWINTER then
        cookingOnPeakFraction = elecTariff == F_ELEC_7HOUR_ONPEAK ? 0.71 : 0.58
      end
    end
    isCookerEnergyElectric = (pOccupancy.GetOvenFuel() == F_ELEC_10HOUR_OFFPEAK or pOccupancy.GetOvenFuel() == F_ELEC_10HOUR_ONPEAK or pOccupancy.GetOvenFuel() == F_ELEC_24HOUR or pOccupancy.GetOvenFuel() == F_ELEC_7HOUR_OFFPEAK or pOccupancy.GetOvenFuel() == F_ELEC_7HOUR_ONPEAK or pOccupancy.GetOvenFuel() == F_ELEC_STANDARD) ? true : false
    pRegister.AddFuelUsage(FU_LIGHTING, FUS_PRIMARY_PROVISION, elecTariff, lightingUse * onPeakFraction, self, "Electricity for lighting (high rate)")
    pRegister.AddFuelUsage(FU_SHOWERS, FUS_PRIMARY_PROVISION, elecTariff, showerUse * onPeakFraction, self, "Electricity for showers (high rate)")
    pRegister.AddFuelUsage(FU_APPLIANCES, FUS_PRIMARY_PROVISION, elecTariff, applianceUse * onPeakFraction, self, "Electricity for appliances (high rate)")
    pRegister.AddFuelUsage(FU_COOKING, FUS_PRIMARY_PROVISION, elecTariff, cookingUse * cookingOnPeakFraction, self, "Electricity for cooking (high rate)")
    if onPeakFraction < 1.0 then
      pRegister.AddFuelUsage(FU_LIGHTING, FUS_PRIMARY_PROVISION, Table12.GetOffPeakEquivalent(elecTariff), lightingUse * (1.0 - onPeakFraction), self, "Electricity for lighting (low rate)")
      pRegister.AddFuelUsage(FU_SHOWERS, FUS_PRIMARY_PROVISION, Table12.GetOffPeakEquivalent(elecTariff), showerUse * (1.0 - onPeakFraction), self, "Electricity for showers (low rate)")
      pRegister.AddFuelUsage(FU_APPLIANCES, FUS_PRIMARY_PROVISION, Table12.GetOffPeakEquivalent(elecTariff), applianceUse * (1.0 - onPeakFraction), self, "Electricity for appliance (low rate)")
      pRegister.AddFuelUsage(FU_COOKING, FUS_PRIMARY_PROVISION, Table12.GetOffPeakEquivalent(elecTariff), cookingUse * (1.0 - cookingOnPeakFraction), self, "Electricity for cooking (low rate)")
    end
  end

  def AddOtherCookingFuelUsage(pRegister, pAppendixL, onPeakFraction, pOccupancy)
    fuel = F_NO_FUEL
    cookingUseByOtherFuels = 0.0
    # Obtain the Fuel usage by fuel used from Bill data for elec Tariff.
    if pAppendixL.GetCookingFuelRatioElectric() != 1.0 then
      if pOccupancy.GetIsStandardOccupancy() then
        #will be gas as electric is already taken care of
        cookingUseByOtherFuels = pAppendixL.GetAnnualCookingOtherEnergyUse()
        fuel = F_GAS_MAINS
      else
        # Get the cooking use by other fuel  ( 1.0 - Proportion electric ).
        cookingUseByOtherFuels = pAppendixL.GetAnnualCookingOtherEnergyUse()
        fuel = pOccupancy.GetOvenFuel()
      end
      pRegister.AddFuelUsage(FU_COOKING, FUS_PRIMARY_PROVISION, fuel, cookingUseByOtherFuels, self, "Other fuel for cooking")
    end
  end

  def AdjustCalculatedFuelUsage(pRegister, pOccupancy, onPeakFraction)
    if not pOccupancy.GetIsStandardOccupancy() then
      billDataVect = pOccupancy.GetBillData()
      shScalingFactor = pOccupancy.GetSHScalingFactor()
      hwScalingFactor = pOccupancy.GetHWScalingFactor()
      it = billDataVect.begin()
      while it.MoveNext()
        if not (it.Current).GetUnusualEnergyItem() then
          scalingFactor = (it.Current).GetScalingFactor()
          if not scalingFactor > 0.0 then
            # Now get the total registered use so far.
            totalCalculated = pRegister.GetAmountByFuel((it.Current).GetFuel())
            #Generated elec is taken out of the totals so we need to add it back in here.
            if (it.Current).GetFuel() == F_ELEC_STANDARD then
              totalCalculated += ((pRegister.GetProviderAmount(FU_GENERATED, _pPVProvider) * -1) * 0.5) #PV
              totalCalculated += ((pRegister.GetProviderAmount(FU_GENERATED, _pCHPProvider) * -1) * 0.4) #CHP
              totalCalculated += ((pRegister.GetProviderAmount(FU_GENERATED, _pWindProvider) * -1) * 0.7)
            end #Wind
            if (it.Current).GetFuel() == F_ELEC_10HOUR_OFFPEAK or (it.Current).GetFuel() == F_ELEC_7HOUR_OFFPEAK then
              totalCalculated += (((pRegister.GetProviderAmount(FU_GENERATED, _pPVProvider) * -1) * (1.0 - onPeakFraction)) * 0.5)
              totalCalculated += (((pRegister.GetProviderAmount(FU_GENERATED, _pCHPProvider) * -1) * (1.0 - onPeakFraction)) * 0.5)
              totalCalculated += (((pRegister.GetProviderAmount(FU_GENERATED, _pWindProvider) * -1) * (1.0 - onPeakFraction)) * 0.5)
            end
            if (it.Current).GetFuel() == F_ELEC_10HOUR_ONPEAK or (it.Current).GetFuel() == F_ELEC_7HOUR_ONPEAK then
              totalCalculated += (((pRegister.GetProviderAmount(FU_GENERATED, _pPVProvider) * -1) * onPeakFraction) * 0.5)
              totalCalculated += (((pRegister.GetProviderAmount(FU_GENERATED, _pCHPProvider) * -1) * onPeakFraction) * 0.5)
              totalCalculated += (((pRegister.GetProviderAmount(FU_GENERATED, _pWindProvider) * -1) * onPeakFraction) * 0.5)
            end
            # V6.3 - Adjustment of Other Fuel use.
            totalBilled = self.ObtainEnergyUsedFromFuelBills(pOccupancy, (it.Current).GetFuel())
            #if nothing on the bills then include the SAP calculated elec gen
            #Appendix V, page OA-8 footnote.
            if self.GetGeneratedElectric((it.Current)) > 0 then
              totalBilled += self.GetGeneratedElectric((it.Current))
            else
              if (it.Current).GetFuel() == F_ELEC_10HOUR_OFFPEAK or (it.Current).GetFuel() == F_ELEC_7HOUR_OFFPEAK then
                totalBilled += ((pRegister.GetProviderAmount(FU_GENERATED) * -1) * (1.0 - onPeakFraction))
              elsif (it.Current).GetFuel() == F_ELEC_10HOUR_ONPEAK or (it.Current).GetFuel() == F_ELEC_7HOUR_ONPEAK then
                totalBilled += ((pRegister.GetProviderAmount(FU_GENERATED) * -1) * onPeakFraction)
              elsif (it.Current).GetFuel() == F_ELEC_STANDARD then
                totalBilled += (pRegister.GetProviderAmount(FU_GENERATED) * -1)
              end
            end
            # Check total billed fuel against total used + Occupancy assesment additional Energy use and adjust if necesssary.
            correctionFactor = totalBilled / totalCalculated
            if correctionFactor > 0 then
              scalingFactor = correctionFactor
              (it.Current).SetScalingFactor(scalingFactor)
            end
          end
          if scalingFactor > 0 then #If the elect tarrif has been changed we still use the on peak factor
            if ((it.Current).GetFuel() == F_ELEC_10HOUR_ONPEAK or (it.Current).GetFuel() == F_ELEC_7HOUR_ONPEAK) and pRegister.GetAmountByFuel((it.Current).GetFuel()) == 0.0 then
              #scale the standard charge
              pRegister.AdjustAmountByFuel(F_ELEC_STANDARD, scalingFactor, (shScalingFactor == 1), (hwScalingFactor == 1))
            else
              #Don't scale if there has been a fuel swtich
              pRegister.AdjustAmountByFuel((it.Current).GetFuel(), scalingFactor, (shScalingFactor == 1), (hwScalingFactor == 1))
            end
          end
        end
      end
    end
  end

  def GetGeneratedPVElectric(pOccupancy)
    totalkWh = 0
    billDataVect = pOccupancy.GetBillData()
    it = billDataVect.begin()
    while it.MoveNext()
      totalkWh += (it.Current).GetElecGenerationPvs()
    end
    return totalkWh
  end

  def GetGeneratedCHPElectric(pOccupancy)
    totalkWh = 0
    billDataVect = pOccupancy.GetBillData()
    it = billDataVect.begin()
    while it.MoveNext()
      totalkWh += ((it.Current).GetElecGenerationMicroCHP() / (it.Current).GetBillingPeriod()) * 12
    end
    return totalkWh
  end

  def GetGeneratedWindElectric(pOccupancy)
    totalkWh = 0
    billDataVect = pOccupancy.GetBillData()
    it = billDataVect.begin()
    while it.MoveNext()
      totalkWh += ((it.Current).GetElecGenerationWind() / (it.Current).GetBillingPeriod()) * 12
    end
    return totalkWh
  end

  def GetGeneratedElectric(bill)
    genElec = 0.0
    genElec += bill.GetElecGenerationPvs()
    genElec += bill.GetElecGenerationWind()
    genElec += bill.GetElecGenerationHydro()
    genElec += (bill.GetElecGenerationMicroCHP() / bill.GetBillingPeriod()) * 12
    return (genElec)
  end

  def ObtainEnergyUsedFromFuelBills(pOccupancy, sapFuel)
    totalUnits = 0
    billDataVect = pOccupancy.GetBillData()
    it = billDataVect.begin()
    while it.MoveNext()
      # Fuel Factor as per Table V7 - Calorific values
      if sapFuel == (it.Current).GetFuel() then
        if (it.Current).GetBillingUnit() == BU_KWH then
          totalUnits += (it.Current).GetQuantityKwh()
        else
          totalUnits += (it.Current).GetQuantityKwh() * (it.Current).GetFuelFactor()
        end
      end
    end
    return totalUnits
  end
end
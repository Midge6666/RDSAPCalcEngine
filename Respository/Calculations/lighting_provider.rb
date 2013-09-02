class LightingProvider
  def initialize(pContext)
    self.RegisterEngineContext(pContext)
  end

  def Dispose()
  end

  def Calculate(pRegister, pAppendixL, onPeakFraction, elecTariff)
    if elecTariff == F_ELEC_24HOUR then
      # 24 hour tariff is for heating only (use standard tariff for lighting)
      elecTariff = F_ELEC_STANDARD
    end
    luse = pAppendixL.GetAnnualLightingEnergyUse()
    pRegister.AddFuelUsage(FU_LIGHTING, FUS_PRIMARY_PROVISION, elecTariff, (luse * onPeakFraction), self, "Electricity for lighting (high rate)")
    if onPeakFraction < 1.0 then
      pRegister.AddFuelUsage(FU_LIGHTING, FUS_PRIMARY_PROVISION, Table12.GetOffPeakEquivalent(elecTariff), (luse * (1.0 - onPeakFraction)), self, "Electricity for lighting (low rate)")
    end
  end
end
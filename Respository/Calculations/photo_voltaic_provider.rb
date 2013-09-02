class PhotoVoltaicProvider
  def initialize(pContext)
    self.RegisterEngineContext(pContext)
  end

  def Dispose()
  end

  def Calculate(pRegister, pAppendixM, elecTariff, onPeakFraction, amountGenerated, generatedFromBillData)
    if elecTariff == F_ELEC_24HOUR then
      # 24 hour tariff is for heating only (use standard tariff for PV)
      elecTariff = F_ELEC_STANDARD
    end
    GeneratedElecAppendixM = 0.0
    GeneratedToUse = 0.0
    if pAppendixM.GetPhotoVoltaicResult() < 0 then
      GeneratedElecAppendixM = pAppendixM.GetPhotoVoltaicResult()
      amountGenerated = GeneratedElecAppendixM * onPeakFraction * AppendixM.PVUTILISATION_FACTOR #always use the appendix M result to pass back out for fuel bill scaling
      if generatedFromBillData > 0.0 then
        GeneratedToUse = (generatedFromBillData * -1)
      else
        GeneratedToUse = GeneratedElecAppendixM
      end
      pRegister.AddFuelUsage(FU_GENERATED, FUS_GENERATED, elecTariff, GeneratedToUse * onPeakFraction * AppendixM.PVUTILISATION_FACTOR, self, "Photovoltaic - savings (high rate)")
      if onPeakFraction < 1.0 then
        pRegister.AddFuelUsage(FU_GENERATED, FUS_GENERATED, Table12.GetOffPeakEquivalent(elecTariff), GeneratedToUse * (1.0 - onPeakFraction) * AppendixM.PVUTILISATION_FACTOR, self, "Photovoltaic Savings (low rate)")
      end
      pRegister.AddFuelUsage(FU_GENERATED, FUS_GENERATED, F_ELEC_SOLD, GeneratedToUse * (1.0 - AppendixM.PVUTILISATION_FACTOR), self, "Photovoltaic - sold back")
    end
  end
end
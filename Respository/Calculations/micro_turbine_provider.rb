class MicroTurbineProvider
  def initialize(pContext)
    self.RegisterEngineContext(pContext)
  end

  def Dispose()
  end

  def Calculate(pRegister, pAppendixM, elecTariff, onPeakFraction, generatedFromBills)
    if elecTariff == F_ELEC_24HOUR then
      # 24 hour tariff is for heating only (use standard tariff for generation)
      elecTariff = F_ELEC_STANDARD
    end
    GeneratedElecAppendixM = 0.0
    GeneratedToUse = 0.0
    if pAppendixM.GetMicroTurbineResult() < 0 then
      GeneratedElecAppendixM = pAppendixM.GetMicroTurbineResult()
      if generatedFromBills > 0.0 then
        GeneratedToUse = (generatedFromBills * -1)
      else
        GeneratedToUse = GeneratedElecAppendixM
      end
      pRegister.AddFuelUsage(FU_GENERATED, FUS_GENERATED, elecTariff, GeneratedToUse * onPeakFraction * AppendixM.WTUTILISATION_FACTOR, self, "Micro turbine - savings (high rate)")
      if onPeakFraction < 1.0 then
        pRegister.AddFuelUsage(FU_GENERATED, FUS_GENERATED, Table12.GetOffPeakEquivalent(elecTariff), GeneratedToUse * (1.0 - onPeakFraction) * AppendixM.WTUTILISATION_FACTOR, self, "Micrto Turbine  Savings (low rate)")
      end
      pRegister.AddFuelUsage(FU_GENERATED, FUS_GENERATED, F_ELEC_SOLD, GeneratedToUse * (1.0 - AppendixM.WTUTILISATION_FACTOR), self, "Micro turbine - sold back")
    end
  end
end
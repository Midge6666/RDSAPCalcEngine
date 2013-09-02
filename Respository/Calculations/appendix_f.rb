class AppendixF
  def initialize(pContext)
    self.RegisterEngineContext(pContext)
  end

  def dispose()
  end

  def calculate(pHeatloss, pHeatingReq, pWaterReq, pSystem, pExternalTemperatures)
    # box 39 - heat transfer coefficient 			(TotalHeatLoss)
    # box 93 - mean internal temperarture			(SpaceHeatingRequirement)
    # box 45 - energy content of hot water used	(HotWaterEnergyRequirement)
    # box 95 - useful gains						(SpaceHeatingRequirement)
    # Vcs	  - volume of CPSU						(SpaceHeatingData)
    # Tw	  - winter operating temperature		(SpaceHeatingData)
    # Te	  - external temperature				(Table 8)
    # box 98 - monthly space heating requirement	(SpaceHeatingRequirement)
    @pHeatloss = pHeatloss
    @pHeatingReq = pHeatingReq
    @pWaterReq = pWaterReq
    @pSystem = pSystem
    @pExternalTemperatures = pExternalTemperatures
    cMax = 0.1456 * _pSystem.GetCylinderInfo().GetCylinderVolume() * (_pSystem.GetWinterOperatingTemperature() - 48.0) # (F2)
    enumerator = .GetEnumerator()
    while enumerator.MoveNext()
      = enumerator.Current
    end

    box39 = pHeatloss.GetHeatTransferCoefficient(month)
    a = (box39 * pHeatingReq.BOX93(month))
    b = (1000.0 * pWaterReq.BOX45(month) / (24.0 * nm))
    tMin = (a - Cmax + b - pHeatingReq.GetUsefulGains(month)) / (box39) # (F1)
    @tMin.SetMonthResult(month, tMin)
    if month.IsSummerMonth() then
      # only hot water in summer (all off peak)
      @onpeakFraction.SetMonthResult(month, 0.0)
    else
      te = _pExternalTemperatures.GetMonthResult(month)
      deltaT = (tMin - te)
      if deltaT == 0.0 then
        eOnPeak = 0.024 * box39 * nm
      else # (F3)
        eOnPeak = (0.024 * box39 * nm * deltaT) / (1.0 - Math.Exp(-deltaT))
      end # (F3)
      onPeakFraction = eOnPeak / (pHeatingReq.BOX98(month) + @pWaterReq.BOX45(month)) # (F4)
      @onpeakFraction.SetMonthResult(month, onPeakFraction)
    end
  end
end
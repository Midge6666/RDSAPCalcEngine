class EffectiveAirChangeRate
  def initialize(pExhaustAirAlgorithm)
    # this pointer is set to non-NULL if there is an exhaust air heat pump system in place (full SAP only)
    self.EffectiveAirChangeRate()
    self.SetExhaustAirHeatPumpAlgorithm(pExhaustAirAlgorithm)
  end

  def initialize(pExhaustAirAlgorithm)
    self.EffectiveAirChangeRate()
    self.SetExhaustAirHeatPumpAlgorithm(pExhaustAirAlgorithm)
  end

  def NaturalVentilationCalc(infiltrationRates)
    effectiveACRs = ResultData[System::Double].new()
    enumerator = .GetEnumerator()
    while enumerator.MoveNext()
      = enumerator.Current
    end

    if inf < 1.0 then
      inf = (0.5 + (Math.Pow(inf, 2.0) * 0.5))
    end
    effectiveACRs.SetMonthResult(month, inf)
  end
end
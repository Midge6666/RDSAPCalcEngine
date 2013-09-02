class FabricLoss
  def initialize(pEngineContext)
    self.@HeatLoss = pEngineContext
    self.ClearResults()
    self.SetEngineLinks(true)
  end

  def Dispose()
    self.SetEngineLinks(false)
    self.ClearResults()
  end

  def Calculate(pStructuralData, tfa)
    self.ClearResults()
    _pStructuralData = pStructuralData
    it = pStructuralData.FirstElement()
    while it != pStructuralData.LastElement()
      pElement = (it)
      pResult = HeatLossLine.new()
      pResult.Type = pElement.GetType()
      # every element should have an area
      pResult.NetArea = pElement.GetArea()
      pResult.Uvalue = pElement.GetUvalue()
      pResult.AxU = pResult.NetArea * pResult.Uvalue
      pResult.Kvalue = pElement.GetHeatCapacity()
      pResult.AxK = pResult.NetArea * pResult.Kvalue
      self.AddElementToEngineLink(pResult)
      _results.push_back(pResult)
      it += 1
    end
    _externalElementArea = self.CalcTotalExternalElements()
    _totalFabricLoss = self.CalcTotalFabricHeatloss()
    _heatCapacity = self.CalcHeatCapacity(tfa)
  end

  def ClearResults()
    self.DeleteAndClearVector(_results)
  end

  def CalcTotalExternalElements()
    result = 0.0
    enumerator = .GetEnumerator()
    while enumerator.MoveNext()
      = enumerator.Current
    end

  end

  def CalcTotalFabricHeatloss()
    result = 0.0
    enumerator = .GetEnumerator()
    while enumerator.MoveNext()
      = enumerator.Current
    end

  end

  def CalcHeatCapacity(tfa)
    result = 0.0
    if _pStructuralData.UsingDefaultThermalMass() then
      return (_pStructuralData.GetDefaultThermalMass() * tfa)
    end
    enumerator = .GetEnumerator()
    while enumerator.MoveNext()
      = enumerator.Current
    end

  end
end
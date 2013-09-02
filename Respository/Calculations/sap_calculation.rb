class SapCalculation
  def initialize(pContext)
    self.@_energyCostDeflator = 0.47
    self.RegisterEngineContext(pContext)
    self.SetEngineLinks(true)
  end

  def Dispose()
    self.SetEngineLinks(false)
  end

  def Calculate(totalAnnualCost, tfa)
    _energyCostFactor = (totalAnnualCost * _energyCostDeflator) / (tfa + 45.0)
    if _energyCostFactor < 3.5 then
      _sapRating = 100.0 - (13.95 * _energyCostFactor)
    else
      _sapRating = 117.0 - (121.0 * Math.Log10(_energyCostFactor))
    end
  end

  def GetSapRating()
    return (_sapRating)
  end

  def GetRoundedSapRating()
    rating = (_sapRating + 0.5)
    # apply lower ceiling
    if rating < 1 then
      rating = 1
    end
    # note - no longer cap at 100 (see SAP2009 specification section 11)
    return (rating)
  end

  def GetSapRatingBand()
    return (BandEvaluator.GetBand(self.GetRoundedSapRating()))
  end

  def SetEngineLinks(State)
    if State then
      _pContext.EngineLink.AddLink(LD_SAPRating, _sapRating, "Sap Rating")
      _pContext.EngineLink.AddLink(LD_SAPEnergyCostFactor, _energyCostFactor, "Energy Cost Factor")
    else
      Links = LD_SAPRatingLD_SAPEnergyCostFactor
      _pContext.EngineLink.RemoveLinks(List[LinkData].new(Links, Links + (Links.Length)))
    end
  end
end
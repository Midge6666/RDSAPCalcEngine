class CO2Calculation
  def initialize(pContext)
    self.RegisterEngineContext(pContext)
    self.SetEngineLinks(true)
  end

  def dispose()
    self.SetEngineLinks(false)
  end

  def calculate(totalCarbonEmissions, tfa)
    @carbonFactor = totalCarbonEmissions / (tfa + 45.0)
    @co2Emissionsm2 = totalCarbonEmissions / tfa
    if _carbonFactor < 28.3 then
      @environmentalImpactRating = 100.0 - (1.34 * @carbonFactor)
    else
      @environmentalImpactRating = 200.0 - (95.0 * Math.Log10(@carbonFactor))
    end
  end

  def get_emissions_rating()
    return (@environmentalImpactRating)
  end

  def get_rounded_emissions_rating()
    rating = (@environmentalImpactRating + 0.5)
    # apply lower ceiling
    if rating < 1 then
      rating = 1
    end
    # note - no longer cap at 100 (see SAP2009 specification section 12)
    return (rating)
  end

  def get_emissions_rating_band()
    return (BandEvaluator.GetBand(self.GetRoundedEmissionsRating()))
  end

  def set_engine_links(state)
    if state then
      @pContext.EngineLink.AddLink(LD_CO2Rating, @environmentalImpactRating, "Environmental Impact Rating")
      @pContext.EngineLink.AddLink(LD_CO2CarbonFactor, @carbonFactor, "Carbon Factor")
      @pContext.EngineLink.AddLink(LD_CO2EmissionsM2, @co2Emissionsm2, "Co2 Emissions m2")
    else
      Links = LD_CO2RatingLD_CO2CarbonFactorLD_CO2EmissionsM2
      _pContext.EngineLink.RemoveLinks(List[LinkData].new(Links, Links + (Links.Length)))
    end
  end
end
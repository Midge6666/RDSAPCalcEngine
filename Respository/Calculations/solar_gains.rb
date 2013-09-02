class SolarGains
  def GetSolarRadiation(month)
    if _pContext.Mode.GetEngineCalcMode() == EM_RHI_CALC or _pContext.Mode.GetRuleSet() == ERS_CENTRICA or _pContext.Mode.GetEngineCalcMode() == EM_REGIONAL_CALC then
      return Table6a.Instance().GetSolarRadiation(month, _pDwellingInfo.GetRhiRegion())
    else
      return Table6a.Instance().GetSolarRadiation(month)
    end
  end

  def SetEngineLinks(State)
    if State then
      _pContext.EngineLink.AddLink(LD_SolarGainTotal, _totalSolarGains, "Total Solar Gains")
    else
      Links = LD_SolarGainTotal
      _pContext.EngineLink.RemoveLinks(List[LinkData].new(Links, Links + (Links.Length)))
    end
  end

  def AddElementToEngineLink(pLine)
  end
end
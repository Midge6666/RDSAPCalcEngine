class EfficiencyCalculator
  def initialize(pContext)
    self.@_pTable4c = nil
    self.@_pAppendixD = nil
    self.RegisterEngineContext(pContext)
  end

  def Dispose()
    self.Clear()
  end

  def Clear()
    if _pTable4c != nil then
      _pTable4c = nil
      _pTable4c = nil
    end
    if _pAppendixD != nil then
      _pAppendixD = nil
      _pAppendixD = nil
    end
  end

  def Calculate(pHeatInfo, pSpaceRequirement, pWaterRequirement, isPrimary)
    self.Clear()
    # SAP Reference - see section 9.2.1. of the SAP2009 documentation
    _pSystemInfo = pHeatInfo
    _winterEfficiency = _pSystemInfo.GetWinterEfficiency()
    _summerEfficiency = _pSystemInfo.GetSummerEfficiency()
    if _pSystemInfo.IsFromSedbuk2005() then
      # this is a SEDBUK 2005 boiler - apply appendix D modifications to get SAP2009 equivalent efficiencies
      _pAppendixD = AppendixD.new(_pSystemInfo, _pContext)
      _winterEfficiency = _pAppendixD.ModifyEfficiency(_winterEfficiency, true)
      _summerEfficiency = _pAppendixD.ModifyEfficiency(_summerEfficiency, false)
    end
    # table 4c calculates efficiency adjustments
    if pWaterRequirement == nil then
      _pTable4c = Table4c.new(false, false, _pSystemInfo)
    else
      _pTable4c = Table4c.new(true, _pSystemInfo.GetLinkedWaterSystem().GetCylinderInfo().HasThermostat(), _pSystemInfo)
    end
    if pSpaceRequirement != nil then
      # (1) work out space heating efficiency - uses winter efficiency adjusted by table 4c
      _spaceHeatingEfficiency = _pTable4c.GetAdjustedEfficiencySH(_winterEfficiency)
    end
    if pWaterRequirement != nil then
      # (2) work out water heating efficiency - if coming from a primary system that is also providing
      #     space heating then the efficiency is modified to represent
      if pSpaceRequirement != nil and isPrimary then
        if _pSystemInfo.IsHeatpump() then
          #efficiencys are a fraction not a percentage
          efficiency = _pSystemInfo.GetEfficiency()
          waterEfficiency = (100.0 / (0.5 / efficiency + 0.5)) / 100.0
          _waterHeatingEfficiency.SetAllMonths(waterEfficiency)
        else
          if _pSystemInfo.IsClass(HSC_WARM_AIR) then
            if _pSystemInfo.IsPre98System() then
              _winterEfficiency = 0.65
              _summerEfficiency = 0.65
            else
              #This is coming from OA-14, it doesn't make sense but I am sick of raising this shit with BRE
              #Apparently we can now have DHW from an OIL warm air system but the efficency stays the same as the main system
              if _pSystemInfo.GetFuel() != F_OIL then
                _winterEfficiency = 0.73
                _summerEfficiency = 0.73
              end
            end
          elsif _pSystemInfo.IsClass(HSC_ROOM_HEATERS) then
            _winterEfficiency = 0.65
            _summerEfficiency = 0.65
          end
          # system is providing primary space heating as well
          it = Year.Begin()
          while it != Year.End()
            sh = pSpaceRequirement.GetMonthResult()
            wh = pWaterRequirement.GetMonthResult()
            winterEff = _pTable4c.GetAdjustedEfficiencyWH(_winterEfficiency)
            summerEff = _pTable4c.GetAdjustedEfficiencyWH(_summerEfficiency)
            eff = (sh + wh) / ((sh / winterEff) + (wh / summerEff))
            _waterHeatingEfficiency.SetMonthResult(, eff)
            it += 1
          end
        end
      else # hot water only or secondary system providing WH as well
        _waterHeatingEfficiency.SetAllMonths(_pTable4c.GetAdjustedEfficiencyWH(_summerEfficiency))
      end
    end
  end

  def GetHotWaterPenalty()
    if _pTable4c != nil then
      return (_pTable4c.GetHotWaterPenalty())
    end
    return (0.0)
  end

  def Calculate(pWaterInfo)
    self._ASSERT(pWaterInfo.IsFromHeatingSystem() == false)
    _pWaterInfo = pWaterInfo
    # table 4c adjustments...
    _pTable4c = Table4c.new(pWaterInfo)
    # very simple - static efficiency through year
    _waterHeatingEfficiency.SetAllMonths(_pWaterInfo.GetHeaterEfficiency())
  end
  end
end
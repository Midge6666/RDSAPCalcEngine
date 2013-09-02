# if a configuration hasn't been set then we use None - This means a user doens't have to specify no solar water heating if he doesn't want to
# Default to Horizontal if not set
# Default to East if not set
# Default to None if not set
# Default to 0 if not set
# Default to false if not set
class AppendixH
  def initialize(pSolarWater, pWaterEnergyRequirement, pCylinderInfo, isFromBoiler, pContext, pAppendixG, dwellingInfo)
    self.@pSolarWater = pSolarWater
    self.@pWaterEnergyRequirement = pWaterEnergyRequirement
    self.@pCylinderInfo = pCylinderInfo
    self.@isFromBoiler = isFromBoiler
    self.@pAppendixG = pAppendixG
    self.@pDwellingInfo = dwellingInfo
    self.RegisterEngineContext(pContext)
    self.SetEngineLinks(true)
    self.Calculate()
  end

  def dispose()
    self.SetEngineLinks(false)
  end

  def calculate()
    if @pSolarWater.HasSolarWaterHeating() == false or @pContext.Mode.GetEngineCalcMode() == EM_RHI_CALC then
      _results.SetAllMonths(0.0)
    else
      # apply mod to Aperture size based on table H1
      @H1_Aperture = @pSolarWater.GetApertureSize()
      if @pSolarWater.IsSizeGross() then
        @H1_Aperture *= _tableHx.H1.GetRatioOfApertureToGrossArea(self.GetCollectorType())
      end
      # If this isn't set then it should be set by table H1
      @H2_ZerolossEffy = _pSolarWater.GetZeroLossCollectorEfficiency()
      if not @H2_ZerolossEffy == nil then
        @H2_ZerolossEffy.SetValue(_tableHx.H1.DefaultZeroLossEfficiency(self.GetCollectorType()))
      end
      # If this isn't set then it should be set by table H1
      @H3_CollectorCoeff = _pSolarWater.GetCollectorHeatlossCoeff()
      if not @H3_CollectorCoeff == nil then
        @H3_CollectorCoeff.SetValue(_tableHx.H1.DefaultCollectorHeatlossCoefficient(self.GetCollectorType()))
      end
      @H4_CollectorRatio = @H3_CollectorCoeff / H2_ZerolossEffy
      @H5_AnnualSolarRadiation = @tableHx.H2.GetSolarRadiation(self.GetCollectorTilt(), self.GetCollectorOrientation())
      if @pContext.Mode.GetEngineCalcMode() == EM_REGIONAL_CALC then
        annualRadiationFactor = @tableHx.RegionalSolarFactor.GetRegionalSolarRadiationFactor(_pDwellingInfo.GetRhiRegion())
        @H5_AnnualSolarRadiation = @H5_AnnualSolarRadiation * annualRadiationFactor
      end
      @H6_Overshading = _tableHx.H4.GetOvershadingFactor(self.GetOvershading())
      @H7_SolarEneryAvailable = @H1_Aperture * @H2_ZerolossEffy * @H5_AnnualSolarRadiation * @H6_Overshading
      if _pAppendixG == nil then
        @H8_SolarToLoadRatio = @H7_SolarEneryAvailable / @pWaterEnergyRequirement.GetEnergyContent().GetYearResult()
      else
        @H8_SolarToLoadRatio = @H7_SolarEneryAvailable / (@pWaterEnergyRequirement.GetEnergyContent().GetYearResult() - @pAppendixG.GetWWHRSResult().GetYearResult())
      end
      @H9_UtilizationFactor = @H8_SolarToLoadRatio > 0.0 ? 1 - Math.Exp(-1 / @H8_SolarToLoadRatio) : 0
      if not @pCylinderInfo.IsConfiguration(CCT_NONE) and not @pCylinderInfo.HasThermostat() and @isFromBoiler then
        # fix: penalty applied for boiler systems only (TC10 + SWH)
        @H9_UtilizationFactor *= 0.9
      end
      if @H4_CollectorRatio < 20.0 then
        @H10_CollectorPerformanceFactor = 0.97 - 0.0367 * @H4_CollectorRatio + 0.0006 * self.SQR(@H4_CollectorRatio)
      else
        @H10_CollectorPerformanceFactor = 0.693 - 0.0108 * @H4_CollectorRatio
      end
      @H11_DedicatedSolarStorageVolume = @pSolarWater.GetStorageVolume()
      @H12_CombinedCylinderVolume = self.GetUseExistingCylinder() ? @pCylinderInfo.GetCylinderVolume() : 0.0
      if @H12_CombinedCylinderVolume > 0.0 then
        @H13_EffectiveSolarVolume = @H11_DedicatedSolarStorageVolume + 0.3 * (@H12_CombinedCylinderVolume - @H11_DedicatedSolarStorageVolume)
      else
        @H13_EffectiveSolarVolume = @H11_DedicatedSolarStorageVolume
      end
      @H14_DailyHotwaterDemand = @pWaterEnergyRequirement.GetAverageWaterUsage()
      @H15_VolumeRatio = @H13_EffectiveSolarVolume / @H14_DailyHotwaterDemand
      @H16_SolarStorageVolumeFactor = 1 + 0.2 * Math.Log(@H15_VolumeRatio)
      if @H15_VolumeRatio > 1.0 then
        @H16_SolarStorageVolumeFactor = 1.0
      end
      @H17_AnnualSolarInput = @H7_SolarEneryAvailable * @H9_UtilizationFactor * @H10_CollectorPerformanceFactor * @H16_SolarStorageVolumeFactor
      enumerator = .GetEnumerator()
      while enumerator.MoveNext()
        = enumerator.Current
      end

    end
  end
end
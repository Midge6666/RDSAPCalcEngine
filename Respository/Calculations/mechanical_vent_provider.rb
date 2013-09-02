class MechanicalVentProvider
  def initialize(pContext)
    self.RegisterEngineContext(pContext)
  end

  def Dispose()
  end

  def Calculate(pRegister, pVentilationData, pDimensions, elecTariff, pIsWarmAirSystemInDwelling, onPeakFraction, pAppendixN)
    _mechVentElec = 0.0
    _warmAirElec = 0.0
    pMechVent = pVentilationData.GetMechanicalVentilationInfo()
    vm = pMechVent.GetMethod()
    if vm != VM_NATURAL then
      # there is mechvent
      if pAppendixN != nil and pAppendixN.IsExhaustAirHeatPump() then
        _mechVentElec = pAppendixN.GetFanConsumption()
      else
        _mechVentElec = Table4f.GetMechVentFanElectricty(pMechVent, pDimensions.GetBuildingVolume())
      end
    end
    if pIsWarmAirSystemInDwelling then
      _warmAirElec = Table4f.GetWarmAirFanElectricty(pDimensions.GetBuildingVolume(), vm)
    end
    if _mechVentElec > 0.0 then
      mvOnPeakFraction = Table12a.GetMechanicalVentilationOnPeakFraction(elecTariff)
      mvOffPeakFraction = 1.0 - mvOnPeakFraction
      # TODO: factor out "AddElectricFuelUsage" to do split
      pRegister.AddFuelUsage(FU_VENTILATION, FUS_ANCILLARY_REQUIREMENT, elecTariff, (_mechVentElec * mvOnPeakFraction), self, "Mechanical ventilation fans (high rate)")
      if mvOnPeakFraction < 1.0 then
        pRegister.AddFuelUsage(FU_VENTILATION, FUS_ANCILLARY_REQUIREMENT, Table12.GetOffPeakEquivalent(elecTariff), (_mechVentElec * mvOffPeakFraction), self, "Mechanical ventilation fans (low rate)")
      end
    end
    if _warmAirElec > 0.0 then
      # TODO: factor out "AddElectricFuelUsage" to do split passing in data + on peak frac
      pRegister.AddFuelUsage(FU_SPACE_HEATING, FUS_ANCILLARY_REQUIREMENT, elecTariff, (_warmAirElec * onPeakFraction), self, "Warm air fans (high rate)")
      if onPeakFraction < 1.0 then
        pRegister.AddFuelUsage(FU_SPACE_HEATING, FUS_ANCILLARY_REQUIREMENT, Table12.GetOffPeakEquivalent(elecTariff), (_warmAirElec * (1.0 - onPeakFraction)), self, "Warm air fans (low rate)")
      end
    end
  end
end
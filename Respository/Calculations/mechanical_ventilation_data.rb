class MechanicalVentilationData
  def initialize()
    self.@_emptyN =  < type
    self.@_specificFanPower =  < type
    self.@_inUseFactorSFP =  < type
    self.@_inUseFactorHRE =  < type
    self.@_heatRecoveryEfficiency =  < type
    self.@_ductingConfig =  < type
    self.@_ductingInsulation =  < type
    self.@_approvedInstallationScheme =  < type
    self.@_method =  < type
  end

  def Dispose()
  end

  def Clear()
    _method.Clear()
    _heatRecoveryEfficiency.Clear()
    _approvedInstallationScheme.Clear()
  end

  def SetMethod(method)
    _method = method
    if method == VM_MECHANICAL_WITH_HR and method == VM_RENWABLE_TECH then
      # make sure programmer is aware of override
      self._ASSERT(0)
      _heatRecoveryEfficiency.Clear()
    end
  end

  def SetOrClearField(pField, pValue)
    if pValue != nil then
      pField.SetValue(pValue)
    else
      pField.Clear()
    end
  end

  def SetMechanicalVentilationParameters(pSpecificFanPower, pHeatRecoveryEfficiency)
    if _method.TestValue() and _method.GetValue() == VM_NATURAL then
      if pSpecificFanPower != nil or pHeatRecoveryEfficiency != nil then
        return (SIE50001_MECHANICAL_DATA_SUPPLIED_FOR_NATURAL_VENT)
      end
    end
    self.SetOrClearField(_specificFanPower, pSpecificFanPower)
    self.SetOrClearField(_heatRecoveryEfficiency, pHeatRecoveryEfficiency)
    return (SIE0000_NO_ERROR)
  end

  def SetApprovedInstallation(inUseFactorSPF, pInUseFactorHRE)
    if _method.TestValue() and _method.GetValue() == VM_NATURAL then
      return (SIE50001_MECHANICAL_DATA_SUPPLIED_FOR_NATURAL_VENT)
    end
    self.SetOrClearField(_inUseFactorSFP, inUseFactorSPF)
    self.SetOrClearField(_inUseFactorHRE, pInUseFactorHRE)
    _approvedInstallationScheme = true
    return (SIE0000_NO_ERROR)
  end

  def SetNonApprovedInstallation(pConfiguration, pInsulation)
    if _method.TestValue() and _method.GetValue() == VM_NATURAL then
      if pConfiguration != nil or pInsulation != nil then
        return (SIE50001_MECHANICAL_DATA_SUPPLIED_FOR_NATURAL_VENT)
      end
    end
    if pConfiguration != nil then
      _ductingConfig.SetValue(pConfiguration)
    else
      _ductingConfig.Clear()
    end
    if pInsulation != nil then
      _ductingInsulation.SetValue(pInsulation)
    else
      _ductingInsulation.Clear()
    end
    _approvedInstallationScheme = false
    return (SIE0000_NO_ERROR)
  end

  def GetDuctingConfiguration()
    return (_ductingConfig)
  end

  def GetDuctingInsulation()
    return (_ductingInsulation)
  end

  def GetMethod()
    return (_method.GetValue())
  end

  def GetHeatRecoveryEfficiency()
    if _heatRecoveryEfficiency.TestValue() == true then
      return (_heatRecoveryEfficiency)
    else
      return (_emptyN)
    end
  end

  def IsApprovedInstallation()
    return (_approvedInstallationScheme.GetValue())
  end

  def GetDesignThroughput()
    # TODO: verify if the user should be able to enter this directly
    return (0.5)
  end

  def GetSpecificFanPower()
    return (_specificFanPower)
  end

  def GetInUseFactorSFP()
    if _approvedInstallationScheme == true and _inUseFactorSFP.TestValue() == true then
      return (_inUseFactorSFP)
    else
      _inUseFactorSFP.SetValue(Table4h.GetInUseFactorSPF(_method, _ductingConfig))
      return (_inUseFactorSFP)
    end
  end

  def GetInUseFactorHRE()
    if _approvedInstallationScheme == true and _inUseFactorHRE.TestValue() == true then
      return (_inUseFactorHRE)
    else
      _inUseFactorHRE.SetValue(Table4h.GetInUseFactorHRE(_ductingInsulation))
      return (_inUseFactorHRE)
    end
  end
end
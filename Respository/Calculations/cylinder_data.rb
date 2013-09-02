class CylinderData
  def initialize(pLinkedHeatingSystem)
    self.@_pLinkedHeatingSystem = pLinkedHeatingSystem
  end

  def Dispose()
  end

  def SetCylinderConfiguration(configuration)
    _configuration = configuration
  end

  def SetCylinderVolume(size)
    _volume.SetValue(size)
  end

  def SetCylinderThermostat(hasThermostat)
    _hasThermostat.SetValue(hasThermostat)
  end

  def SetDeclaredCylinderLoss(loss)
    _manufacturesDeclaredLoss = loss
    # using delcared loss factor - should be an integral tank
    _insulationClass.SetValue(CIC_INTEGRAL)
  end

  def SetCylinderInsulation(insulation, thickness)
    _insulationClass = insulation
    _insulationThickness = thickness
  end

  def SetPrimaryPipeworkInfo(ins, length)
    _primaryPipeInsulation = ins
    if length > 0.0 then
      _primaryPipeworkLength = length
    else
      _primaryPipeworkLength.Clear()
    end
  end

  def IsUsingEstimatedLosses()
    if not _manufacturesDeclaredLoss.TestValue() or _manufacturesDeclaredLoss == 0.0 then # Not set so check if in linked record
                                                                                          # no linked system (assumed cylinders are in this state)
      if _pLinkedHeatingSystem == nil then
        # so as no declared loss (above) - must be estimated...
        return (true)
      end
      if () != nil and _pLinkedHeatingSystem.IsFromProductDatabase() then # linked record needs to be from pcdf or the functions will return nulls
        DecLossFactor = _pLinkedHeatingSystem.GetStorageLossFactor()
        if DecLossFactor.TestValue() then
          return false
        end
      end
      return true
    end
    return false
  end

  def GetConfiguration()
    return (_configuration.GetValue())
  end

  def IsConfiguration(cfg)
    return (cfg == _configuration.GetValue())
  end

  def GetDeclaredLossFactor()
    if not _manufacturesDeclaredLoss.TestValue() then # Not set so check if in linked record
      if () != nil and _pLinkedHeatingSystem.IsFromProductDatabase() then # linked record needs to be from pcdf or the functions will return nulls
        DecLossFactor = _pLinkedHeatingSystem.GetStorageLossFactor()
        if DecLossFactor.TestValue() then
          return DecLossFactor.GetValue()
        else
          # TODO: Validation, attempt to grab DecLossFactor which wasn't set and linked heating record cannot retrieve it either, defaulted to 0
          return 0
        end
      else
        # TODO: Raise validation error for trying to retrieve DecLossFactor which isn't set and can't be grabbed from Sap tables - Default to 0
        return 0
      end
    else
      return _manufacturesDeclaredLoss.GetValue()
    end
  end

  def GetCylinderVolume()
    if not _volume.TestValue() then # Not set so check if in linked record
      if () != nil and _pLinkedHeatingSystem.IsFromProductDatabase() then # linked record needs to be from pcdf or the functions will return nulls
        volume = _pLinkedHeatingSystem.GetStoreVolume()
        if volume.TestValue() then
          return volume.GetValue()
        else
          # TODO: Validation, attempt to grab cylinder volume which wasn't set and linked heating record cannot retrieve it either, defaulted to 0
          return 0
        end
      else
        # TODO: Raise validation error for trying to retrieve cylinder volume which isn't set and can't be grabbed from Sap tables - Default to 0
        return 0
      end
    else
      return (_volume.GetValue())
    end
  end

  def GetInsulationClass()
    if not _insulationClass.TestValue() then # Not set so check if in linked record
      if () != nil and _pLinkedHeatingSystem.IsFromProductDatabase() then # linked record needs to be from pcdf or the functions will return nulls
        if _pLinkedHeatingSystem.GetStoreVolume() > 0 then # if there's a store volume then insulation class should be integral
          return CIC_INTEGRAL
        else
          # TODO: Validation, attempt to grab cylinder Insulation class which wasn't set and linked heating record cannot retrieve it either, defaulted to 0
          return CIC_NONE
        end
      else
        # TODO: Raise validation error for trying to retrieve cylinder Insulation class which isn't set and can't be grabbed from Sap tables - Default to 0
        return CIC_NONE
      end
    else
      return _insulationClass.GetValue()
    end
  end

  def GetInsulationThickness()
    if not _insulationThickness.TestValue() then # Not set so check if in linked record
      if () != nil and _pLinkedHeatingSystem.IsFromProductDatabase() then # linked record needs to be from pcdf or the functions will return nulls
        InsThick = _pLinkedHeatingSystem.GetStoreInsThick()
        if InsThick.TestValue() then
          return InsThick.GetValue()
        else
          # TODO: Validation, attempt to grab cylinder volume which wasn't set and linked heating record cannot retrieve it either, defaulted to 0
          return 0
        end
      else
        # TODO: Raise validation error for trying to retrieve cylinder volume which isn't set and can't be grabbed from Sap tables - Default to 0
        return 0
      end
    else
      return _insulationThickness.GetValue()
    end
  end

  def IsPrimaryPipeworkInsulated()
    if _primaryPipeInsulation.TestValue() == false then
      cfg = _configuration.GetValue()
      if cfg == CIC_INTEGRAL then
        return (true)
      elsif cfg == CIC_NONE then
        return (false)
      else
        return false
      end
    end
    return (_primaryPipeInsulation == PPI_FULL_INSULATION)
  end

  def GetPrimaryPipeworkLength()
    if _primaryPipeworkLength.TestValue() then
      cfg = _configuration.GetValue()
      if cfg == CIC_INTEGRAL or cfg == CIC_NONE then
        return (0.0)
      end
    end
    return (_primaryPipeworkLength)
  end

  def HasThermostat()
    if _hasThermostat.TestValue() == false then
      # value not set - could be because there's no cylinder
      cfg = _configuration.GetValue()
      if cfg == CIC_NONE then
        # Even though cylinder config is set to none there might be one in a linked system
        if () != nil and _pLinkedHeatingSystem.IsFromProductDatabase() then # linked record needs to be from pcdf or the functions will return nulls
          return _pLinkedHeatingSystem.GetThermalStoreType() == TST_INTEGRATED ? true : false
        else
          return (false)
        end
      elsif cfg == CIC_INTEGRAL then
        # TODO: raise a warning here -> defaulting cylinder thermostat
        return (true)
      else
        # TODO: raise a error here -> defaulting no cylinder thermostat
        return (false)
      end
    end
    return (_hasThermostat)
  end

  def GetHeatExchangerArea()
    if _heatExchangerArea.TestValue() then
      return _heatExchangerArea.GetValue()
    else
      # TODO: add validation warning
      return 1.0
    end
  end

  def SetCylinderHeatExchangerArea(Area)
    _heatExchangerArea = Area
  end
end
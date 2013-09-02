class DwellingInfo
  def initialize()
  end

  def Dispose()
    self.DeleteAndClearVector(_microTurbines)
  end

  def GetLowEnergyLightsFraction()
    if _lowEnergyLightsFraction.IsSafe() then
      return (_lowEnergyLightsFraction.GetValue())
    else
      frac = _lowEnergyLightCount.GetValue() / _lightingOutletCount.GetValue()
      return (self.DENT(frac, DS_ALGORITHM))
    end
  end

  def GetLowEnergyLightCount()
    return (_lowEnergyLightCount)
  end

  def GetLightOutletCount()
    return (_lightingOutletCount)
  end

  def SetLowEnergyLightFraction(frac)
    _lowEnergyLightsFraction = frac
  end

  def SetLowEnergyLightCount(count)
    _lowEnergyLightCount = count
  end

  def SetLightingOutletCount(count)
    _lightingOutletCount = count
  end

  def GetLivingAreaFraction()
    return (_livingAreaFraction)
  end

  def SetLivingAreaFraction(fraction)
    _livingAreaFraction = fraction
  end

  def GetPhotoVoltaicSpecification(Index)
    if Index < 0 or Index > 2 then
      Debug.Assert(not "An attempt was made to retrieve a photo voltaic data set which was outside the range of 0-2 - Returned Index of 0 instead")
      Index = 0
    end
    return _photoVoltaicData[Index]
  end

  def PhotoVoltaicSpecification(Index)
    if Index < 0 or Index > 2 then
      Debug.Assert(not "An attempt was made to retrieve a photo voltaic data set which was outside the range of 0-2 - Returned Index of 0 instead")
      Index = 0
    end
    return _photoVoltaicData[Index]
  end

  def AddMicroTurbine(Turbine)
    pTurbine = MicroTurbine.new(Turbine)
    _microTurbines.push_back(pTurbine)
  end

  def FGHRSPhotoVoltaicSpecification()
    return _fghrsPV
  end

  def SetWWHRS(NumBathAndShower, NumShowersWithWWHRS1AndBath, NumShowersWithWWHRS1NoBath, NumShowersWithWWHRS2AndBath, NumShowersWithWWHRS2NoBath)
    _numBathAndShower = NumBathAndShower
    _numShowersWithWWHRS1AndBath = NumShowersWithWWHRS1AndBath
    _numShowersWithWWHRS1NoBath = NumShowersWithWWHRS1NoBath
    _numShowersWithWWHRS2AndBath = NumShowersWithWWHRS2AndBath
    _numShowersWithWWHRS2NoBath = NumShowersWithWWHRS2NoBath
  end
end
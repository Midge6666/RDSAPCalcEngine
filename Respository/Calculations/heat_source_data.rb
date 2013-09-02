class HeatSourceData
  def initialize(fuel, requirementProvision, efficiency, heatToPowerRatio)
    self.@_fuel = fuel
    self.@_isCHP = true
    self.@_provision = requirementProvision
    self.@_efficiency = efficiency
    self.@_heatToPowerRatio = heatToPowerRatio
  end

  def initialize(fuel, requirementProvision, efficiency, heatToPowerRatio)
    self.@_fuel = fuel
    self.@_isCHP = true
    self.@_provision = requirementProvision
    self.@_efficiency = efficiency
    self.@_heatToPowerRatio = heatToPowerRatio
  end

  def Dispose()
  end

  def UpdateFraction(fraction)
    #	_ASSERT(fraction >= 0.0 && fraction <= 1.0);
    _provision = fraction
  end
end

class CommunityHeatingData
  def initialize()
    self.@_pPrimaryHeatSource = nil
  end

  def Dispose()
    self.ClearHeatSources()
  end

  def GetHeatSourceCount()
    # +1 if additional primary heat source is present (i.e. not NULL)
    return (_additionalHeatSources.size() + ((_pPrimaryHeatSource == nil) ? 0 : 1))
  end

  def GetHeatSource(index)
    if index == 0 then
      if _pPrimaryHeatSource != nil then
        return (_pPrimaryHeatSource)
      end
    else
      index -= 1
    end
    return (_additionalHeatSources[index])
  end

  def ConfigureMainHeatSource(fuel, efficiency)
    self.ClearPrimaryHeatSource()
    _pPrimaryHeatSource = HeatSourceData.new(fuel, 1.0, efficiency)
    self.UpdatePrimarySourceFraction()
  end

  def CreateAdditionalHeatSource(fuel, fraction, efficiency)
    _additionalHeatSources.push_back(HeatSourceData.new(fuel, fraction, efficiency))
    self.UpdatePrimarySourceFraction()
  end

  def CreateAdditionalHeatSource(fuel, fraction, efficiency, heatToPowerRatio)
    _additionalHeatSources.push_back(HeatSourceData.new(fuel, fraction, efficiency, heatToPowerRatio))
    self.UpdatePrimarySourceFraction()
  end

  def ClearHeatSources()
    it = _additionalHeatSources.begin()
    while it.MoveNext()
      self.delete(it.Current)
    end
    _additionalHeatSources.clear()
    self.ClearPrimaryHeatSource()
  end

  def ClearPrimaryHeatSource()
    if _pPrimaryHeatSource != nil then
      _pPrimaryHeatSource = nil
      _pPrimaryHeatSource = nil
    end
  end

  def GetFractionAssignedToAdditionalSources()
    fraction = 0.0
    enumerator = .GetEnumerator()
    while enumerator.MoveNext()
      = enumerator.Current
    end

  end
end
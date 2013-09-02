class GlazedElement
  def initialize(type, area, uvalue, frame, glazing, os)
    self.@FabricElement =  < type
    self._ASSERT(self.IS_OPENING(type))
    self.Initialise()
    # TODO: allow client to specify part glazed elements
    self.SetGlazingParameters(frame, (type == GT_SOLID) ? GE_SOLID : GE_FULL_GLAZED, glazing, os)
  end

  def Initialise()
    _rooflightSpecificUvalue = false
  end

  def initialize(type, area, uvalue, frame, glazing, os)
    self.@FabricElement =  < type
    self._ASSERT(self.IS_OPENING(type))
    self.Initialise()
    self.SetGlazingParameters(frame, (type == GT_SOLID) ? GE_SOLID : GE_FULL_GLAZED, glazing, os)
  end

  def SetGlazingParameters(frame, extent, type, overshading)
    _frame = frame
    _glazing = type
    _extent = extent
    _overshading = overshading
  end

  def SetGlazingParameters(overshading)
    _overshading = overshading
  end

  def SetISBFRCApproved(isBFRCApproved)
    _isBFRCApproved = isBFRCApproved
  end

  def GetISBFRCApproved()
    return _isBFRCApproved
  end

  def SetGlazingGap(gap)
    _gap = gap
  end

  def SetThermalBreak(tBreak)
    _thermalBreak = tBreak
  end

  def Dispose()
  end

  def GetHeatCapacity()
    # glazed elements have no thermal mass
    return (0.0)
  end

  def GetUvalue()
    # TODO: add windows uvalue lookup
    if _type == FET_WINDOW or _type == FET_ROOFLIGHT then
      # paragraph 3.2 - use effective u-value for windows and rooflights
      return (1.0 / ((1.0 / _uvalue) + 0.04))
    else
      return (_uvalue)
    end
  end

  def SetHeatCapacity(capacity)
    _pValidator.NotifyItem(VSC_WARNING, CVL_GLAZING, SE50002_HEAT_CAPACITY_INVALID_FOR_GLAZED_ELEMENTS, "Heat capacity invalid for glazed elements (ignored)")
  end

  def GetOrientationDegrees()
    result = 90.0 # east
    if _orientation.TestValue() == false then
      _pValidator.NotifyItem(VSC_ERROR, CVL_GLAZING, SE10001_GLAZING_ORIENTATION_MISSING, "Glazing orientation not specified (defaulted to EAST)")
      return (result)
    end
    case _orientation
      when GO_NORTH
        result = 0.0
        break
      when GO_NORTHEAST
        result = 45.0
        break
      when GO_EAST
        result = 90.0
        break
      when GO_SOUTHEAST
        result = 135.0
        break
      when GO_SOUTH
        result = 180.0
        break
      when GO_SOUTHWEST
        result = 225.0
        break
      when GO_WEST
        result = 270.0
        break
      when GO_NORTHWEST
        result = 315.0
        break
      when GO_HORIZONTAL
        result = -1
        break
      else
        _pValidator.NotifyItem(VSC_ERROR, CVL_GLAZING, SE50001_GLAZING_ORIENTATION_INVALID, "Invalid glazing orientation specified (defaulted to EAST)")
        break
    end
    return (result)
  end

  def GetGlazingExtent()
    if _extent.TestValue() then
      return (_extent.GetValue())
    else
      _pValidator.NotifyItem(VSC_ERROR, CVL_GLAZING, SE10005_GLAZING_EXTENT_MISSING, "No glazing extent specified (defaulted to fully glazed)")
      return (GE_FULL_GLAZED)
    end
  end

  def GetFrameFactor()
    if _frameFactor.TestValue() then
      # entered directly...
      return (_frameFactor.GetValue())
    elsif _frame.TestValue() then
      # lookup using frame type specified...
      return (Table6c.GetFrameFactor(_frame))
    else
      _pValidator.NotifyItem(VSC_SERIOUS, CVL_GLAZING, SE10002_GLAZING_FRAME_FACTOR_MISSING, "No frame type or frame factor supplied to engine (defaulted to 1.0)")
      return (1.0)
    end
  end

  def GetLightTransmittance()
    if _glazing.TestValue() == false then
      _pValidator.NotifyItem(VSC_SERIOUS, CVL_GLAZING, SE10003_GLAZING_TYPE_MISSING, "Glazing type not specified (defaulted as opaque)")
      return (0.0)
    end # opaque!
        # light transmittance always comes from table 6b (footnote 3 on table 6b)
    return (Table6b.GetLightTransmittance(_glazing))
  end

  def GetLightAccessFactor()
    if _type == FET_ROOFLIGHT then
      # footnote (2) of table 6d
      return (1.0)
    elsif _glazing.TestValue() then
      return (Table6d.GetLightAccessFactor(_overshading))
    else
      _pValidator.NotifyItem(VSC_SERIOUS, CVL_GLAZING, SE10004_GLAZING_OVERSHADING_MISSING, "Glazing overshading not specified (defaulted as heavy)")
      return (Table6d.GetLightAccessFactor(GOS_HEAVY))
    end
  end

  def GetWinterSolarAccessFactor()
    if _type == FET_ROOFLIGHT then
      # footnote (2) of table 6d
      return (1.0)
    elsif _overshading.TestValue() then
      return (Table6d.GetWinterAccessFactor(_overshading))
    else
      _pValidator.NotifyItem(VSC_SERIOUS, CVL_GLAZING, SE10004_GLAZING_OVERSHADING_MISSING, "Glazing overshading not specified (defaulted as heavy)")
      return (Table6d.GetWinterAccessFactor(GOS_HEAVY))
    end
  end

  def GetSummerSolarAccessFactor()
    if _type == FET_ROOFLIGHT then
      # footnote (2) of table 6d
      return (1.0)
    elsif _overshading.TestValue() then
      return (Table6d.GetSummerAccessFactor(_overshading))
    else
      _pValidator.NotifyItem(VSC_SERIOUS, CVL_GLAZING, SE10004_GLAZING_OVERSHADING_MISSING, "Glazing overshading not specified (defaulted as heavy)")
      return (Table6d.GetSummerAccessFactor(GOS_HEAVY))
    end
  end

  def GetSolarEnergyTramsmittance()
    transmittance = 0.0
    if _solarEnergyTransmittance.TestValue() then
      if _solarTransmittanceForGlazingOnly then
        transmittance = _solarEnergyTransmittance * self.GetFrameFactor()
      else
        transmittance = _solarEnergyTransmittance
      end
    elsif _glazing.TestValue() then
      transmittance = Table6b.GetSolarEnergyTransmittance(_glazing)
    else
      _pValidator.NotifyItem(VSC_SERIOUS, CVL_GLAZING, SE10003_GLAZING_TYPE_MISSING, "Glazing type not specified (defaulted as opaque)")
    end
    return (transmittance)
  end

  def SetUvalue(uvalue, rooflightSpecific)
    _uvalue = uvalue
    _rooflightSpecificUvalue = rooflightSpecific
  end

  def SetFrame(frame)
    _frame = frame
  end

  def SetFrameFactor(frameFactor)
    _frameFactor = frameFactor
  end

  def SetOrientation(orientation)
    _orientation = orientation
  end

  def SetGlazing(type)
    _glazing = type
  end

  def SetSolarEnergyTransmittance(set, forGlazingOnly)
    _solarEnergyTransmittance = set
    _solarTransmittanceForGlazingOnly = forGlazingOnly
  end

  def SetOvershading(os)
    _overshading = os
  end

  def GetFrame()
    return (_frame)
  end

  def GetType()
    return (_glazing)
  end

  def GetFabricElementType()
    return (_type)
  end

  def GetOvershading()
    return (_overshading)
  end

  def SetGlazingExtent(extent)
    _extent = extent
  end

  def GetOrientation()
    return _orientation
  end
end
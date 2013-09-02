class StructuralData
  def initialize()
    _pValidator = Validator.new(self, _validationController)
  end

  def Dispose()
    _pValidator = nil
    _pValidator = nil
    self.DeleteAndClearVector(_elements)
    _openings.clear()
    _structuralItems.clear()
    _walls.clear()
    _floors.clear()
    _roofs.clear()
  end

  def GetThermalBridgeValue()
    if _thermalBridgeValue.TestValue() then
      return (_thermalBridgeValue.GetValue())
    else
      # TODO: fail validation
      return (0.0)
    end
  end

  def SetThermalMass(thermalMass)
    _defaultThermalMassParameter = thermalMass
  end

  def UsingDefaultThermalMass()
    return (_defaultThermalMassParameter.TestValue())
  end

  def GetDefaultThermalMass()
    return (_defaultThermalMassParameter.GetValue())
  end

  def AddThermalBridge(val)
    if not _thermalBridgeValue.TestValue() then # If this is value hasn't been set before then it can't be accumlated without 1st being set to 0
      _thermalBridgeValue.SetValue(0.0)
    end
    _thermalBridgeValue.SetValue(_thermalBridgeValue.GetValue() + val)
  end

  def ClearThermalBridges()
    _thermalBridgeValue.Clear()
  end

  def AddElement(pElement)
    _elements.push_back(pElement)
    _validationController.RegisterComponent(pElement)
    type = pElement.GetType()
    if self.IS_OPENING(type) then
      _openings.push_back(pElement)
    else
      _structuralItems.push_back(pElement)
      if self.IS_WALL(type) then
        _walls.push_back(pElement)
      elsif self.IS_FLOOR(type) then
        _floors.push_back(pElement)
      elsif self.IS_ROOF(type) then
        _roofs.push_back(pElement)
      else
        self._ASSERT("AddElement() - unexpected element type")
      end
    end
  end

  def FirstElement()
    # this allows the vector of non-const pointer to be returned to the outside world as const pointers
    return (reinterpret_cast < List < )
  end

  def LastElement()
    # this allows the vector of non-const pointer to be returned to the outside world as const pointers
    return (reinterpret_cast < List < )
  end

  def FirstOpening()
    # this allows the vector of non-const pointer to be returned to the outside world as const pointers
    return (reinterpret_cast < List < )
  end

  def LastOpening()
    # this allows the vector of non-const pointer to be returned to the outside world as const pointers
    return (reinterpret_cast < List < )
  end
end
class DwellingDimensions
  def initialize(pContext)
    self.RegisterEngineContext(pContext)
    self.SetEngineLinks(true)
  end

  def Dispose()
    self.RemoveAllFloors()
    self.SetEngineLinks(false)
  end

  def RemoveAllFloors()
    # Remove engine links for all floors
    i = 0
    while i < _floors.size()
      _pContext.EngineLink.RemoveLink(LD_DimensionData_Area, i)
      _pContext.EngineLink.RemoveLink(LD_DimensionData_Height, i)
      _pContext.EngineLink.RemoveLink(LD_DimensionData_Volume, i)
      i += 1
    end
    # loop through all floors and delete to clear up object memory
    self.DeleteAndClearVector(_floors)
    # floors have changes so cached calc should be wiped
    self.PerformCalc()
  end

  def CalcTotalFloorArea()
    totalFloorArea = 0
    # sum of each individual floor area
    it = _floors.begin()
    while it.MoveNext()
      totalFloorArea += (it.Current).GetArea()
    end
    return totalFloorArea
  end

  def CalcBuildingVolume()
    buildingVolume = 0
    # sum volume for each floor
    it = _floors.begin()
    while it.MoveNext()
      buildingVolume += (it.Current).GetVolume()
    end
    return (buildingVolume)
  end

  def AddFloor(aFloor)
    aFloorCopy = Floor.new(aFloor)
    _floors.push_back(aFloorCopy)
    # change these to get funcs ()
    _pContext.EngineLink.AddLink(LD_DimensionData_Area, "Floor Area", _floors.size() - 1, aFloorCopy, Floor.GetArea) # the -1 is to keep the index starting from 0
    _pContext.EngineLink.AddLink(LD_DimensionData_Height, "Floor Height", _floors.size() - 1, aFloorCopy, Floor.GetHeight)
    _pContext.EngineLink.AddLink(LD_DimensionData_Volume, "Floor Volume", _floors.size() - 1, aFloorCopy, Floor.GetVolume)
    # floor data has been changed - clear cached calc results
    self.PerformCalc()
  end

  def SetStoreyCount(count)
    _storeyCount = count
  end

  def GetTotalFloorArea()
    if _totalFloorArea.TestValue() then
      return _totalFloorArea.GetValue()
    end
    return 0.0
  end

  def GetBuildingVolume()
    if _buildingVolume.TestValue() then
      return _buildingVolume.GetValue()
    end
    return 0.0
  end

  def GetStoreyCount()
    return _storeyCount.GetValue()
  end

  def PerformCalc()
    _totalFloorArea = self.CalcTotalFloorArea()
    _buildingVolume = self.CalcBuildingVolume()
  end

  def SetEngineLinks(State)
    if State then
      _pContext.EngineLink.AddLink(LD_TotalFloorArea, _totalFloorArea, "Total floor area")
      _pContext.EngineLink.AddLink(LD_DwellingVolume, _buildingVolume, "Dwelling volume")
      _pContext.EngineLink.AddLink(LD_StoreyCount, _storeyCount, "Storey count")
    else
      Links = LD_TotalFloorAreaLD_DwellingVolumeLD_StoreyCount
      _pContext.EngineLink.RemoveLinks(List[LinkData].new(Links, Links + (Links.Length)))
    end
  end
end
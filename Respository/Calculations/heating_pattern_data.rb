class HeatingPatternData
  def initialize()
    _demandTemperature.SetDefault(Table9.GetZone1DemandTemperature(), _pTableName)
    Table9.GetZone1Pattern(wdoff1, wdoff2, weoff1, weoff2)
    _zone1.weekday.offPeriod1.SetDefault(wdoff1, _pTableName)
    _zone1.weekday.offPeriod2.SetDefault(wdoff2, _pTableName)
    _zone1.weekend.offPeriod1.SetDefault(weoff1, _pTableName)
    _zone1.weekend.offPeriod2.SetDefault(weoff2, _pTableName)
    # To give default to new fields required for occupancy
    wdoff3 = 0
    wdoff4 = 0
    weoff3 = 0
    weoff4 = 0
    _zone1.weekday.offPeriod3.SetDefault(wdoff3, _pTableName)
    _zone1.weekday.offPeriod4.SetDefault(wdoff4, _pTableName)
    _zone1.weekend.offPeriod3.SetDefault(weoff3, _pTableName)
    _zone1.weekend.offPeriod4.SetDefault(weoff4, _pTableName)
  end

  # can't do zone 2 here... depends on control level
  def SetZoneHeatingHours(zone, weekdayOff1, weekdayOff2, weekdayOff3, weekdayOff4, weekendOff1, weekendOff2, weekendOff3, weekendOff4)
    if zone == 1 then
      pZone = _zone1
    elsif zone == 2 then
      pZone = _zone2
    end
    pZone.weekday.offPeriod1 = weekdayOff1
    pZone.weekday.offPeriod2 = weekdayOff2
    pZone.weekday.offPeriod3 = weekdayOff3
    pZone.weekday.offPeriod4 = weekdayOff4
    pZone.weekend.offPeriod1 = weekendOff1
    pZone.weekend.offPeriod2 = weekendOff2
    pZone.weekend.offPeriod3 = weekendOff3
    pZone.weekend.offPeriod4 = weekendOff4
  end

  def SetDemandTemperature(demandTemperature)
    _demandTemperature = demandTemperature
  end

  def GetZone1Pattern()
    return (_zone1)
  end

  def GetZone2Pattern(controlLevel, isOccupancyAssessment)
    if isOccupancyAssessment then
      isOneLivingAreaOffPeriod = _zone1.weekday.offPeriod2 == 0 and _zone1.weekday.offPeriod3 == 0 and _zone1.weekday.offPeriod4 == 0
      if controlLevel == 3 then
        if isOneLivingAreaOffPeriod and _zone1.weekday.offPeriod1 < 12 then
          _zone2.weekday.offPeriod1.SetDefault(_zone1.weekday.offPeriod1, _pTableName)
          _zone2.weekday.offPeriod2.SetDefault(9, _pTableName)
          _zone2.weekday.offPeriod3.SetDefault(0, _pTableName)
          _zone2.weekday.offPeriod4.SetDefault(0, _pTableName)
        else
          #Find the shortest period
          #I've changed this from using the MIN function as that wasn't returning doubles
          shortest = _zone1.weekday.offPeriod1
          if _zone1.weekday.offPeriod2 < shortest and _zone1.weekday.offPeriod2 > 0 then
            shortest = _zone1.weekday.offPeriod2
          end
          if _zone1.weekday.offPeriod3 < shortest and _zone1.weekday.offPeriod3 > 0 then
            shortest = _zone1.weekday.offPeriod3
          end
          if _zone1.weekday.offPeriod4 < shortest and _zone1.weekday.offPeriod4 > 0 then
            shortest = _zone1.weekday.offPeriod4
          end
          _zone2.weekday.offPeriod1.SetDefault(_zone1.weekday.offPeriod1 == shortest != 0 ? _zone1.weekday.offPeriod1 + 2 : _zone1.weekday.offPeriod1, _pTableName)
          _zone2.weekday.offPeriod2.SetDefault(_zone1.weekday.offPeriod2 == shortest != 0 ? _zone1.weekday.offPeriod2 + 2 : _zone1.weekday.offPeriod2, _pTableName)
          _zone2.weekday.offPeriod3.SetDefault(_zone1.weekday.offPeriod3 == shortest != 0 ? _zone1.weekday.offPeriod3 + 2 : _zone1.weekday.offPeriod3, _pTableName)
          _zone2.weekday.offPeriod4.SetDefault(_zone1.weekday.offPeriod4 == shortest != 0 ? _zone1.weekday.offPeriod4 + 2 : _zone1.weekday.offPeriod4, _pTableName)
        end
      else
        _zone2.weekday.offPeriod1.SetDefault(_zone1.weekday.offPeriod1, _pTableName)
        _zone2.weekday.offPeriod2.SetDefault(_zone1.weekday.offPeriod2, _pTableName)
        _zone2.weekday.offPeriod3.SetDefault(_zone1.weekday.offPeriod3, _pTableName)
        _zone2.weekday.offPeriod4.SetDefault(_zone1.weekday.offPeriod4, _pTableName)
      end
      isOneLivingAreaOffPeriod = _zone1.weekend.offPeriod2 == 0 and _zone1.weekend.offPeriod3 == 0 and _zone1.weekend.offPeriod4 == 0
      if controlLevel == 3 then
        if isOneLivingAreaOffPeriod and _zone1.weekend.offPeriod1 < 12 then
          _zone2.weekend.offPeriod1.SetDefault(_zone1.weekend.offPeriod1, _pTableName)
          _zone2.weekend.offPeriod2.SetDefault(9, _pTableName)
          _zone2.weekend.offPeriod3.SetDefault(0, _pTableName)
          _zone2.weekend.offPeriod4.SetDefault(0, _pTableName)
        else
          #Find the shortest period
          #I've changed this from using the MIN function as that wasn't returning doubles
          shortest = _zone1.weekend.offPeriod1
          if _zone1.weekend.offPeriod2 < shortest and _zone1.weekend.offPeriod2 > 0 then
            shortest = _zone1.weekend.offPeriod2
          end
          if _zone1.weekend.offPeriod3 < shortest and _zone1.weekend.offPeriod3 > 0 then
            shortest = _zone1.weekend.offPeriod3
          end
          if _zone1.weekend.offPeriod4 < shortest and _zone1.weekend.offPeriod4 > 0 then
            shortest = _zone1.weekend.offPeriod4
          end
          _zone2.weekend.offPeriod1.SetDefault(_zone1.weekend.offPeriod1 == shortest != 0 ? _zone1.weekend.offPeriod1 + 2 : _zone1.weekend.offPeriod1, _pTableName)
          _zone2.weekend.offPeriod2.SetDefault(_zone1.weekend.offPeriod2 == shortest != 0 ? _zone1.weekend.offPeriod2 + 2 : _zone1.weekend.offPeriod2, _pTableName)
          _zone2.weekend.offPeriod3.SetDefault(_zone1.weekend.offPeriod3 == shortest != 0 ? _zone1.weekend.offPeriod3 + 2 : _zone1.weekend.offPeriod3, _pTableName)
          _zone2.weekend.offPeriod4.SetDefault(_zone1.weekend.offPeriod4 == shortest != 0 ? _zone1.weekend.offPeriod4 + 2 : _zone1.weekend.offPeriod4, _pTableName)
        end
      else
        _zone2.weekend.offPeriod1.SetDefault(_zone1.weekend.offPeriod1, _pTableName)
        _zone2.weekend.offPeriod2.SetDefault(_zone1.weekend.offPeriod2, _pTableName)
        _zone2.weekend.offPeriod3.SetDefault(_zone1.weekend.offPeriod3, _pTableName)
        _zone2.weekend.offPeriod4.SetDefault(_zone1.weekend.offPeriod4, _pTableName)
      end
    else
      Table9.GetZone2Pattern(controlLevel, wdoff1, wdoff2, weoff1, weoff2)
      _zone2.weekday.offPeriod1.SetDefault(wdoff1, _pTableName)
      _zone2.weekday.offPeriod2.SetDefault(wdoff2, _pTableName)
      _zone2.weekend.offPeriod1.SetDefault(weoff1, _pTableName)
      _zone2.weekend.offPeriod2.SetDefault(weoff2, _pTableName)
      # To give default to new fields required for occupancy
      wdoff3 = 0
      wdoff4 = 0
      weoff3 = 0
      weoff4 = 0
      _zone2.weekday.offPeriod3.SetDefault(wdoff3, _pTableName)
      _zone2.weekday.offPeriod4.SetDefault(wdoff4, _pTableName)
      _zone2.weekend.offPeriod3.SetDefault(weoff3, _pTableName)
      _zone2.weekend.offPeriod4.SetDefault(weoff4, _pTableName)
    end
    return (_zone2)
  end

  def GetDemandTemperature()
    return (_demandTemperature)
  end

  def Dispose()
  end
end
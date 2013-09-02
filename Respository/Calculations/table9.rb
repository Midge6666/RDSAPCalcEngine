require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

class Table9
  def get_zone1_demand_temperature()
    return (21.0)
  end

  def get_zone2_demand_temperature(controlLevel, z1DemandTemp, hlp)
    # see footnote at bottom of Table9 - max HLP of 6.0 for this calc
    hlp = Math.Min(6.0, hlp)
    case controlLevel
      when 1
        result = z1DemandTemp - (0.5 * hlp)
        break
      when 2, 3
        result = z1DemandTemp - hlp + (0.085 * self.SQR(hlp))
        break
      else
        raise (EngineException.new("Unknown heating control level passed to Table9"))
    end
    return (result)
  end

  def GetZone2Pattern(controlLevel, weekdayOff1, weekdayOff2, weekendOff1, weekendOff2)
    case controlLevel
      when 1, 2
        weekdayOff1 = 7
        weekdayOff2 = 8
        weekendOff1 = 0
        weekendOff2 = 8
        break
      when 3
        weekdayOff1 = 9
        weekdayOff2 = 8
        weekendOff1 = 9
        weekendOff2 = 8
        break
      else
        raise EngineException.new("Invalid heating control level passed to Table9")
    end
  end

  def GetZone1Pattern(weekdayOff1, weekdayOff2, weekendOff1, weekendOff2)
    weekdayOff1 = 7
    weekdayOff2 = 8
    weekendOff1 = 0
    weekendOff2 = 8
  end
end
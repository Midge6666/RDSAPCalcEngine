class Table4a
  # To change this template use File | Settings | File Templates.

  def look_up_efficiency(hws, spaceHeatingInfo = NIL)
    efficiency = 1.0

    if (spaceHeatingInfo != NIL)
      if (spaceHeatingInfo.IsClass(HEATING_SYSTEM_CLASS[:HSC_WARM_AIR]))
        if (spaceHeatingInfo.IsPre98System)
          efficiency = 0.65
        else
          efficiency = 0.73
        end
      else
        efficiency = spaceHeatingInfo.GetEfficiency
      end
    else
      if (hws == SAP_HOT_WATER_SYSTEM[:HWS_NONE_PRESENT])
        efficiency = 1.0
      elsif (hws == SAP_HOT_WATER_SYSTEM[:HWS_FROM_MAIN_SYSTEM] ||
             hws == SAP_HOT_WATER_SYSTEM[:HWS_FROM_ALTERNATE_MAIN_SYSTEM] ||
             hws == SAP_HOT_WATER_SYSTEM[:HWS_FROM_SECONDARY_SYSTEM])
        efficiency = 1.0
      elsif (hws == SAP_HOT_WATER_SYSTEM[:HWS_ELECTRIC_IMMERSION] ||
             hws == SAP_HOT_WATER_SYSTEM[:HWS_ELECTRIC_INSTANT])
        efficiency = 1.0
      elsif (hws == SAP_HOT_WATER_SYSTEM[:HWS_GAS_SINGLE_POINT])
        efficiency = 0.70
      elsif (hws == SAP_HOT_WATER_SYSTEM[:HWS_GAS_MULTI_POINT] ||
             hws == SAP_HOT_WATER_SYSTEM[:HWS_GAS_CIRCULATOR])
        efficiency = 0.65
      elsif (hws == SAP_HOT_WATER_SYSTEM[:HWS_OIL_CIRCULATOR])
        efficiency = 0.70
      elsif (hws == SAP_HOT_WATER_SYSTEM[:HWS_SOLID_CIRCULATOR])
        efficiency = 0.55
      elsif (hws == SAP_HOT_WATER_SYSTEM[:HWS_GAS_RANGE_SINGLE_PILOT])
        efficiency = 0.46
      elsif (hws == SAP_HOT_WATER_SYSTEM[:HWS_GAS_RANGE_SINGLE_AUTO])
        efficiency = 0.50
      elsif (hws == SAP_HOT_WATER_SYSTEM[:HWS_GAS_RANGE_TWIN_PILOT_PRE98])
        efficiency = 0.60
      elsif (hws == SAP_HOT_WATER_SYSTEM[:HWS_GAS_RANGE_TWIN_AUTO_PRE98] ||
             hws == SAP_HOT_WATER_SYSTEM[:HWS_GAS_RANGE_TWIN_PILOT])
        efficiency = 0.65
      elsif (hws == SAP_HOT_WATER_SYSTEM[:HWS_GAS_RANGE_TWIN_AUTO])
        efficiency = 0.70
      elsif (hws == SAP_HOT_WATER_SYSTEM[:HWS_OIL_RANGE_SINGLE])
        efficiency = 0.60
      elsif (hws == SAP_HOT_WATER_SYSTEM[:HWS_OIL_RANGE_TWIN_PRE98])
        efficiency = 0.70
      elsif (hws == SAP_HOT_WATER_SYSTEM[:HWS_OIL_RANGE_TWIN_AUTO])
        efficiency = 0.75
      elsif (hws == SAP_HOT_WATER_SYSTEM[:HWS_SOLID_RANGE_INTEGRAL])
        efficiency = 0.45
      elsif (hws == SAP_HOT_WATER_SYSTEM[:HWS_SOLID_RANGE_INDEPENDENT])
        efficiency = 0.55
      elsif (hws == SAP_HOT_WATER_SYSTEM[:HWS_COMMUNITY_BOILERS])
        efficiency = 0.80
      elsif (hws == SAP_HOT_WATER_SYSTEM[:HWS_COMMUNITY_CHP])
        efficiency = 0.75
      elsif (hws == SAP_HOT_WATER_SYSTEM[:HWS_COMMINUTY_WASTE])
        efficiency = 1.0
      elsif (hws == SAP_HOT_WATER_SYSTEM[:HWS_COMMUNITY_HEATPUMP])
        efficiency = 3.0
      elsif (hws == SAP_HOT_WATER_SYSTEM[:HWS_COMMUNITY_GEOTHERMAL])
        efficiency = 1.0
      end

    end

    return efficiency
  end
end
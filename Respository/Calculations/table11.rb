class Table11
  def GetSecondaryFraction(pPrimary, pSecondary)
    if pSecondary == nil then
      # no secondary
      return (0.0)
    end
    if pPrimary.IsMicrogenSystem() then
      Debug.Assert(not "A MicrocoGen system should not be using Table 11 to calculate secondary fraction, use Table N8 instead")
    elsif pPrimary.IsHeatpump() then
      if pPrimary.IsFromProductDatabase() then
        Debug.Assert(not "A Heatpump system from Pcdf should not be using Table 11 to calculate secondary fraction, use Table N8 instead")
      else
        result = 0.1
      end
    elsif pPrimary.GetClass() == HSC_COMMUNITY_HEATING then
      result = 0.1
    elsif pPrimary.GetFuelCategory() == FC_ELECTRIC then
      if pPrimary.IsElectricCPSU() then
        result = 0.1
      elsif pPrimary.IsClass(HSC_ROOM_HEATERS) then
        result = 0.2
      elsif pPrimary.IsClass(HSC_STORAGE_HEATING) then
        sType = pPrimary.GetStorageHeatingType()
        if sType == SHT_INTEGRATED then
          result = 0.1
        elsif sType == SHT_FAN_ASSISTED then
          result = 0.1
        else
          result = 0.15
        end
      else # all other electric
        result = 0.1
      end
    elsif pPrimary.GetFuelCategory() == FC_GAS or pPrimary.GetFuelCategory() == FC_OIL or pPrimary.GetFuelCategory() == FC_SOLID then
      result = 0.1
    else
      # TODO: add validation fail here
      result = 0.1
    end
    return (result)
  end

  def initialize()
  end

  def Dispose()
  end
end
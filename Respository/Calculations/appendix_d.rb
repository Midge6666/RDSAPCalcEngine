require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

class AppendixD
  def initialize(pHeatingInfo, pContext)
    self.RegisterEngineContext(pContext)
    self.CategoriseBoiler(pHeatingInfo)
    @f = self.GetTableD23Result(pHeatingInfo.GetFuel())
    self.CalculateEfficiencyCeilings(pHeatingInfo)
  end

  def calculate_efficiency_ceilings(pHeatingInfo)
    if pHeatingInfo.IsCondensingBoiler() then
      if pHeatingInfo.GetFuelCategory() == FC_GAS then
        fuel = pHeatingInfo.GetFuel()
        case fuel
          when F_GAS_BULK_LPG, F_GAS_BOTTLED_LPG, F_GAS_LPG_SC18
            # condensing LPG
            @ceilingFL = 0.98
            @ceilingPL = 1.06
            break
          else
            # condensing Natural Gas
            @ceilingFL = 0.98
            @ceilingPL = 1.08
        end
      elsif pHeatingInfo.GetFuelCategory() == FC_OIL then
        # condensing oil
        @ceilingFL = 0.98
        @ceilingPL = 1.04
      else
        # invalid fuel type for appendix D
        self._ASSERT(0)
        @ceilingFL = 1.00
        @ceilingPL = 1.00
      end
    else # non-condensing
      if pHeatingInfo.GetFuelCategory() == FC_GAS then
        # non-condensing gas
        @ceilingFL = 0.92
        @ceilingPL = 0.91
      elsif pHeatingInfo.GetFuelCategory() == FC_OIL then
        # non-condensing oil
        @ceilingFL = 0.92
        @ceilingPL = 0.93
      else
        # invalid fuel type for appendix D
        self._ASSERT(0)
        @ceilingFL = 1.00
        @ceilingPL = 1.00
      end
    end
  end

  def modify_efficiency(sedbuk2005, winterSeason)
    case _categorisation
      when D71n_ONOFF_REGULAR_NONCONDENSING
        k1 = -6.5
        k2 = 3.8
        k3 = -6.5
        break
      when D71c_ONOFF_REGULAR_CONDENSING
        k1 = -2.5
        k2 = 1.45
        k3 = -2.5
        break
      when D72n_MODULATING_REGULAR_NONCONDENSING
        k1 = -2.0
        k2 = 3.15
        k3 = -2.0
        break
      when D72c_MODULATING_REGULAR_CONDENSING
        k1 = -2.0
        k2 = -0.95
        k3 = -2.0
        break
      when D73n_ONOFF_INSTANT_COMBI_NONCONDENSING
        k1 = -6.8
        k2 = -3.7
        k3 = -6.8
        break
      when D73c_ONOFF_INSTANT_COMBI_CONDENSING
        k1 = -2.8
        k2 = -5.0
        k3 = -2.8
        break
      when D74n_MODULATING_INSTANT_COMBI_NONCONDENSING
        k1 = -6.1
        k2 = 4.15
        k3 = -6.1
        break
      when D74c_MODULATING_INSTANT_COMBI_CONDENSING
        k1 = -2.1
        k2 = -0.7
        k3 = -2.1
        break
      when D75n_ONOFF_STORAGE_COMBI_NONCONDENSING
        k1 = -6.59
        k2 = -0.5
        k3 = -6.59
        break
      when D75c_ONOFF_STORAGE_COMBI_CONDENSING
        k1 = -6.59
        k2 = -0.5
        k3 = -6.59
        break
      when D76n_MODULATING_STORAGE_COMBI_NONCONDENSING
        k1 = -1.7
        k2 = 3.0
        k3 = -1.7
        break
      when D76c_MODULATING_STORAGE_COMBI_CONDENSING
        k1 = -1.7
        k2 = -1.0
        k3 = -1.7
        break
      when D77n_CPSU_NONCONDENSING
        k1 = -0.64
        k2 = -1.25
        k3 = -0.64
        break
      when D77c_CPSU_CONDENSING
        k1 = -0.28
        k2 = -3.15
        k3 = -0.28
        break
      when D78n_REGULAR_NONCONDENSING_OIL
        k1 = 0.0
        k2 = -5.2
        k3 = -1.1
        break
      when D78c_REGULAR_CONDENSING_OIL
        k1 = 0.0
        k2 = 1.1
        k3 = -1.1
        break
      when D79n_INSTANT_COMBI_NONCONDENSING_OIL
        k1 = -2.8
        k2 = 1.45
        k3 = -2.8
        break
      when D79c_INSTANT_COMBI_CONDENSING_OIL
        k1 = -2.8
        k2 = -0.25
        k3 = -2.8
        break
      when D710n_STORAGE_COMBI_NONCONDENSING_OIL
        k1 = -2.8
        k2 = -2.8
        k3 = -2.8
        break
      when D710c_STORAGE_COMBI_CONDENSING_OIL
        k1 = -2.8
        k2 = -0.95
        k3 = -2.8
        break
      when D000_UNCATEGORISED_TYPE
        return (sedbuk2005)
      else
        # invalid boiler categorisation!
        self._ASSERT(0)
        return (sedbuk2005)
    end
    @fullLoad = (((sedbuk2005) - k1) / _f) + k2
    @partLoad = (((sedbuk2005) - k1) / _f) - k2
    # Table D7.2 adustment
    if _fullLoad > 95.5 then
      @fullLoad += (-0.673 * (@fullLoad - 95.5))
    end
    if _partLoad > 96.6 then
      @partLoad += (-0.213 * (@partLoad - 96.6))
    end
    # check against ceilings
    @fullLoad = Math.Min(@fullLoad, (@ceilingFL * 100.0)) # These values are stored as decimels so can't use them in a min func without making the numbers a real percent
    @partLoad = Math.Min(@partLoad, (@ceilingPL * 100.0))
    @seasonal = (0.5 * (@fullLoad + @partLoad) * @f) + k3
    # Round To Point One Percent
    @seasonal = ((_seasonal * 10.0 + 0.5)) / 10.0
    # Apply winter and summer seasonal factors
    _seasonal += self.GetTableD27Result(winterSeason)
    # apparently we now need to round twice to fix a newly released TC16
    @seasonal = ((@seasonal * 10.0 + 0.5)) / 10.0
    # back to a decimal
    @seasonal /= 100.0
    return (@seasonal)
  end

  def categorise_boiler(pHeatingInfo)
    cbt = pHeatingInfo.GetCombiType()
    if pHeatingInfo.GetFuelCategory() == FC_GAS then
      if pHeatingInfo.IsCPSUSystem() then
        if pHeatingInfo.IsCondensingBoiler() then
          @categorisation = D77c_CPSU_CONDENSING
        else # non condensing
          @categorisation = D77n_CPSU_NONCONDENSING
        end
      elsif cbt == CBT_INSTANT then
        if pHeatingInfo.IsModulatingBoiler() then
          if pHeatingInfo.IsCondensingBoiler() then
            @categorisation = D74c_MODULATING_INSTANT_COMBI_CONDENSING
          else
            @categorisation = D74n_MODULATING_INSTANT_COMBI_NONCONDENSING
          end
        else # not modulating - must be on/off
          if pHeatingInfo.IsCondensingBoiler() then
            @categorisation = D73c_ONOFF_INSTANT_COMBI_CONDENSING
          else
            @categorisation = D73n_ONOFF_INSTANT_COMBI_NONCONDENSING
          end
        end
      elsif cbt == CBT_NOT_COMBI then
        if pHeatingInfo.IsModulatingBoiler() then
          if pHeatingInfo.IsCondensingBoiler() then
            @categorisation = D72c_MODULATING_REGULAR_CONDENSING
          else
            @categorisation = D72n_MODULATING_REGULAR_NONCONDENSING
          end
        else # not modulating - must be on/off
          if pHeatingInfo.IsCondensingBoiler() then
            @categorisation = D71c_ONOFF_REGULAR_CONDENSING
          else
            @categorisation = D71n_ONOFF_REGULAR_NONCONDENSING
          end
        end
      else # must be storage combi
        if pHeatingInfo.IsModulatingBoiler() then
          if pHeatingInfo.IsCondensingBoiler() then
            @categorisation = D76c_MODULATING_STORAGE_COMBI_CONDENSING
          else
            @categorisation = D76n_MODULATING_STORAGE_COMBI_NONCONDENSING
          end
        else # not modulating - must be on/off
          if pHeatingInfo.IsCondensingBoiler() then
            @categorisation = D75c_ONOFF_STORAGE_COMBI_CONDENSING
          else
            @categorisation = D75n_ONOFF_STORAGE_COMBI_NONCONDENSING
          end
        end
      end
    elsif pHeatingInfo.GetFuelCategory() == FC_OIL then
      if cbt == CBT_INSTANT then
        if pHeatingInfo.IsCondensingBoiler() then
          @categorisation = D79c_INSTANT_COMBI_CONDENSING_OIL
        else
          @categorisation = D79n_INSTANT_COMBI_NONCONDENSING_OIL
        end
      elsif cbt == CBT_NOT_COMBI then
        if pHeatingInfo.IsCondensingBoiler() then
          @categorisation = D78c_REGULAR_CONDENSING_OIL
        else
          @categorisation = D78n_REGULAR_NONCONDENSING_OIL
        end
      else # storage combi...
        if pHeatingInfo.IsCondensingBoiler() then
          @categorisation = D710c_STORAGE_COMBI_CONDENSING_OIL
        else
          @categorisation = D710n_STORAGE_COMBI_NONCONDENSING_OIL
        end
      end
    else
      @categorisation = D000_UNCATEGORISED_TYPE
    end
  end

  def get_table_D23_result(fuel)
    case fuel
      when F_GAS_MAINS, F_GAS_LNG
        result = 0.901
        break
      when F_GAS_BULK_LPG, F_GAS_BOTTLED_LPG, F_GAS_LPG_SC18
        result = 0.921
        break
      when F_OIL
        result = 0.937
        break
      when F_BIODIESEL_BIOMASS, F_BIODIESEL_COOKING_OIL
        result = 0.937
        break
      else
        # don't worry about the community fuels - CH doesn't use appendix D
        result = 1.0
        break
    end
    return (result)
  end

  def get_table_D27_result(winterSeason)
    case _categorisation
      when D71n_ONOFF_REGULAR_NONCONDENSING, D71c_ONOFF_REGULAR_CONDENSING
        return winterSeason ? 0.9 : -9.2
      when D72n_MODULATING_REGULAR_NONCONDENSING, D72c_MODULATING_REGULAR_CONDENSING
        return winterSeason ? 1.0 : -9.7
      when D73n_ONOFF_INSTANT_COMBI_NONCONDENSING, D73c_ONOFF_INSTANT_COMBI_CONDENSING
        return winterSeason ? 0.8 : -8.5
      when D74n_MODULATING_INSTANT_COMBI_NONCONDENSING, D74c_MODULATING_INSTANT_COMBI_CONDENSING
        return winterSeason ? 0.9 : -9.2
      when D75n_ONOFF_STORAGE_COMBI_NONCONDENSING, D75c_ONOFF_STORAGE_COMBI_CONDENSING
        return winterSeason ? 0.7 : -7.2
      when D76n_MODULATING_STORAGE_COMBI_NONCONDENSING, D76c_MODULATING_STORAGE_COMBI_CONDENSING
        return winterSeason ? 0.8 : -8.3
      when D77n_CPSU_NONCONDENSING, D77c_CPSU_CONDENSING
        return winterSeason ? 0.22 : -1.64
      when D78n_REGULAR_NONCONDENSING_OIL, D78c_REGULAR_CONDENSING_OIL
        return winterSeason ? 1.1 : -10.6
      when D79n_INSTANT_COMBI_NONCONDENSING_OIL, D79c_INSTANT_COMBI_CONDENSING_OIL
        return winterSeason ? 1.0 : -8.5
      when D710n_STORAGE_COMBI_NONCONDENSING_OIL, D710c_STORAGE_COMBI_CONDENSING_OIL
        return winterSeason ? 0.9 : -7.2
      when D000_UNCATEGORISED_TYPE
        return 0.0
      else
        # invalid boiler categorisation!
        self._ASSERT(0)
        return 0.0
    end
  end
end
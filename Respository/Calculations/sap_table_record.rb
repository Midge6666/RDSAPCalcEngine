class SapTableRecord
  def initialize(Obj)
    #_pValidator = new Validator(this);
    #_pValidator = new Validator(this);
    #_pValidator = new Validator(this);
    self.@code = Obj.code
    self.@systemClass = Obj.systemClass
    self.@fuelCat = Obj.fuelCat
    self.@winterEfficiency = Obj.winterEfficiency
    self.@summerEfficiency = Obj.summerEfficiency
    self.@heatingType = Obj.heatingType
    self.@responsiveness = Obj.responsiveness
    self.@hotWaterProvision = Obj.hotWaterProvision
    self.@requiresSupplementalHeating = Obj.requiresSupplementalHeating
    self.@isFromProductDb = Obj.isFromProductDb
    self.@flueOptions = Obj.flueOptions
    self.@hetasApprovedEfficiency = Obj.hetasApprovedEfficiency
    self.@_alternateEfficiencies = Obj._alternateEfficiencies
    self.@_alternateResponsiveness = Obj._alternateResponsiveness
    _pValidator = Validator.new(self)
  end

  def initialize(Obj)
    self.@code = Obj.code
    self.@systemClass = Obj.systemClass
    self.@fuelCat = Obj.fuelCat
    self.@winterEfficiency = Obj.winterEfficiency
    self.@summerEfficiency = Obj.summerEfficiency
    self.@heatingType = Obj.heatingType
    self.@responsiveness = Obj.responsiveness
    self.@hotWaterProvision = Obj.hotWaterProvision
    self.@requiresSupplementalHeating = Obj.requiresSupplementalHeating
    self.@isFromProductDb = Obj.isFromProductDb
    self.@flueOptions = Obj.flueOptions
    self.@hetasApprovedEfficiency = Obj.hetasApprovedEfficiency
    self.@_alternateEfficiencies = Obj._alternateEfficiencies
    self.@_alternateResponsiveness = Obj._alternateResponsiveness
    _pValidator = Validator.new(self)
  end

  def initialize(Obj)
    self.@code = Obj.code
    self.@systemClass = Obj.systemClass
    self.@fuelCat = Obj.fuelCat
    self.@winterEfficiency = Obj.winterEfficiency
    self.@summerEfficiency = Obj.summerEfficiency
    self.@heatingType = Obj.heatingType
    self.@responsiveness = Obj.responsiveness
    self.@hotWaterProvision = Obj.hotWaterProvision
    self.@requiresSupplementalHeating = Obj.requiresSupplementalHeating
    self.@isFromProductDb = Obj.isFromProductDb
    self.@flueOptions = Obj.flueOptions
    self.@hetasApprovedEfficiency = Obj.hetasApprovedEfficiency
    self.@_alternateEfficiencies = Obj._alternateEfficiencies
    self.@_alternateResponsiveness = Obj._alternateResponsiveness
    _pValidator = Validator.new(self)
  end

  def Dispose()
    if _pValidator != nil then
      _pValidator = nil
      _pValidator = nil
    end
  end

  def initialize(Obj)
    self.@code = Obj.code
    self.@systemClass = Obj.systemClass
    self.@fuelCat = Obj.fuelCat
    self.@winterEfficiency = Obj.winterEfficiency
    self.@summerEfficiency = Obj.summerEfficiency
    self.@heatingType = Obj.heatingType
    self.@responsiveness = Obj.responsiveness
    self.@hotWaterProvision = Obj.hotWaterProvision
    self.@requiresSupplementalHeating = Obj.requiresSupplementalHeating
    self.@isFromProductDb = Obj.isFromProductDb
    self.@flueOptions = Obj.flueOptions
    self.@hetasApprovedEfficiency = Obj.hetasApprovedEfficiency
    self.@_alternateEfficiencies = Obj._alternateEfficiencies
    self.@_alternateResponsiveness = Obj._alternateResponsiveness
    _pValidator = Validator.new(self)
  end

  def GetHeatingClass()
    return (systemClass)
  end

  def GetHeatingCode()
    return (code)
  end

  def GetFuelCategory()
    return (fuelCat)
  end

  def GetHotWaterProvision()
    return (hotWaterProvision)
  end

  def GetWinterEfficiency(hetasApproved)
    if hetasApproved and hetasApprovedEfficiency.TestValue() then
      return (hetasApprovedEfficiency.GetValue())
    else
      return (winterEfficiency)
    end
  end

  def GetSummerEfficiency()
    if summerEfficiency.TestValue() then
      return (summerEfficiency)
    else
      return (winterEfficiency)
    end
  end

  def GetHeatingType()
    return (heatingType)
  end

  def GetResponsiveness()
    if self.IsUnderfloorHeating() then
    end
    # responsiveness for underfloor emitters come from table 4d
    return (responsiveness)
  end

  def IsCPSU()
    case code
      when HC_GASCPSU_AUTO, HC_GASCPSU_CONDENSING_AUTO, HC_GASCPSU_PILOT, HC_GASCPSU_CONDENSING_PILOT
        result = true
        break
      when HC_ELECBLR_CPSU
        result = true
        break
      else
        result = false
        break
    end
    return (result)
  end

  def GetThermalStoreType()
    # TODO: is this a thermal store?
    return (TST_NO_THERMAL_STORE)
  end

  def GetCombiType()
    result = COMBI_BOILER_TYPE.new()
    case code
      when HC_GASBLR_COMBI_AUTO, HC_GASBLR_COND_COMBI_AUTO, HC_GASBLR_COMBI_PERM, HC_GASBLR_CONDCOMBI_PERM, HC_GASBLR_COMBI_PRE1998_FAN, HC_GASBLR_CONDCOMBI_PRE1998_FAN, HC_GASBLR_COMBI_PRE1998_OPEN, HC_OILBLR_COMBI_PRE1998, HC_OILBLR_COMBI, HC_OILBLR_CONDENSING_COMBI # bug fix (this was missing) TC9 (pw)
        result = CBT_INSTANT
        break
      when 			# all CPSUs are modelled as combis
      HC_GASCPSU_AUTO, HC_GASCPSU_CONDENSING_AUTO, HC_GASCPSU_PILOT, HC_GASCPSU_CONDENSING_PILOT
        result = CBT_STORAGE_PRIMARY
        break
      else
        result = CBT_NOT_COMBI
        break
    end
    return (result)
  end

  def IsElectricaireSystem()
    return code == HC_ELECWA_ELECTRICARE
  end

  def GetStorageHeatingType()
    type = STORAGE_HEATING_TYPE.new()
    case code
      when HC_ELECSTG_OLD_LARGE_VOLUME, HC_ELECSTG_MODERN_SLIMLINE, HC_ELECSTG_CONVECTOR, HC_ELECSTG_SLIMLINE_CELECT, HC_ELECSTG_CONVECTOR_CELECT
        type = SHT_STANDARD
        break
      when HC_ELECSTG_FAN, HC_ELECSTG_FAN_CELECT
        type = SHT_FAN_ASSISTED
        break
      when HC_ELECSTG_INTEGRATED, HC_ELECUF_INTEGRATED, HC_ELECUF_INTEGRATED_TARIFF
        type = SHT_INTEGRATED
        break
      else
        type = SHT_NOT_STORAGE
        break
    end
    return (type)
  end

  def GetHeatpumpType()
    result = HEATPUMP_TYPE.new()
    case code
      when HC_ELECHP_GROUND_TO_WATER, HC_GASHP_GROUND_SOURCE_BOILER, HC_ELECHP_GROUND_TO_AIR, HC_GASHP_GROUND_SOURCE_WARMAIR
        result = HPT_GROUND_SOURCE
        break
      when HC_ELECHP_GROUND_TO_WATER_AUX, HC_ELECHP_GROUND_TO_AIR_AUX
        result = HPT_GROUND_WITH_AUX
        break
      when HC_ELECHP_WATER_TO_WATER, HC_GASHP_WATER_SOURCE_BOILER, HC_ELECHP_WATER_TO_AIR, HC_GASHP_WATER_SOURCE_WARMAIR
        result = HPT_WATER_SOURCE
        break
      when HC_ELECHP_AIR_TO_WATER, HC_GASHP_AIR_SOURCE_BOILER, HC_ELECHP_AIR_TO_AIR, HC_GASHP_AIR_SOURCE_WARMAIR
        result = HPT_AIR_SOURCE
        break
      when HC_COMMUNITY_HEATPUMP
        result = HPT_COMMUNITY
        break
      else
        result = HPT_NOT_HEATPUMP
        break
    end
    return (result)
  end

  def CanProvideHotWater()
    return (hotWaterProvision != HWP_NONE)
  end

  def RequiresSupplementalHeating()
    return (requiresSupplementalHeating)
  end

  def IsFromProductDatabase()
    return (false)
  end

  def IsOffPeakOnlySystem()
    result = false
    case code
      when HC_ELECSTG_OLD_LARGE_VOLUME, HC_ELECSTG_MODERN_SLIMLINE, HC_ELECSTG_CONVECTOR, HC_ELECSTG_FAN, HC_ELECSTG_SLIMLINE_CELECT, HC_ELECSTG_CONVECTOR_CELECT, HC_ELECSTG_FAN_CELECT, HC_ELECSTG_INTEGRATED, HC_ELECUF_CONCRETE_SLAB, HC_ELECUF_INTEGRATED, HC_ELECUF_INTEGRATED_TARIFF, HC_ELECBLR_DRYCORE_INTERNAL #Classed as off peak
        result = true
        break
    end
    return (result)
  end

  def IsMicrogenSystem()
    # don't support microgen from SAP tables
    return (false)
  end

  def IsHeatpump()
    result = false
    case code
      when HC_ELECHP_GROUND_TO_AIR, HC_ELECHP_GROUND_TO_AIR_AUX, HC_ELECHP_WATER_TO_AIR, HC_ELECHP_AIR_TO_AIR, HC_GASHP_GROUND_SOURCE_WARMAIR, HC_GASHP_WATER_SOURCE_WARMAIR, HC_GASHP_AIR_SOURCE_WARMAIR
        result = true
        break
      when HC_ELECHP_GROUND_TO_WATER, HC_ELECHP_GROUND_TO_WATER_AUX, HC_ELECHP_WATER_TO_WATER, HC_ELECHP_AIR_TO_WATER, HC_GASHP_GROUND_SOURCE_BOILER, HC_GASHP_WATER_SOURCE_BOILER, HC_GASHP_AIR_SOURCE_BOILER
        result = true
        break
    end
    return (result)
  end

  def IsElectricCPSU()
    return (code == HC_ELECBLR_CPSU)
  end

  def IsUnderfloorHeating()
    case code
      when HC_ELECUF_CONCRETE_SLAB, HC_ELECUF_INTEGRATED, HC_ELECUF_INTEGRATED_TARIFF, HC_ELECUF_INSCREED, HC_ELECUF_INTIMBER
        result = true
        break
      else
        result = false
        break
    end
    return (result)
  end

  def IsPre98System()
    case code
      when 			# gas warmair - fan flue
      HC_GASWA_ONOFF_PRE1998_FAN, HC_GASWA_MODULATING_PRE1998_FAN, 			# gas warmair - open/balanced flue
          HC_GASWA_ONOFF_PRE1998, HC_GASWA_MODULATING_PRE1998, 			# gas room heaters
          HC_GASRH_PRE1980_OPEN, HC_GASRH_PRE1980_OPEN_BACKBLR, 			# gas boilers (pre-1998 with fan flues)
          HC_GASBLR_LOW_THERMAL, HC_GASBLR_HIGH_THERMAL, HC_GASBLR_COMBI_PRE1998_FAN, HC_GASBLR_CONDCOMBI_PRE1998_FAN, HC_GASBLR_COND_PRE1998_FAN, 			# gas boilers (pre-1998 with open/balanced flues)
          HC_GASBLR_WALL_PRE1998, HC_GASBLR_FLOOR_PRE1979, HC_GASBLR_FLOOR_PRE1998, HC_GASBLR_COMBI_PRE1998_OPEN, HC_GASBLR_BACK_TORADS_PRE1998, 			# oil boilers
          HC_OILBLR_PRE1985, HC_OILBLR_PRE1997, HC_OILBLR_COMBI_PRE1998, 			# gas kitchen ranges
          HC_GASRNG_TWIN_PILOT_PRE1998, HC_GASRNG_TWIN_AUTO_PRE1998, 			# oil kitchen ranges
          HC_OILRNG_TWIN_PRE1998
        result = true
        break
      else
        result = false
        break
    end
    return (result)
  end

  def HasFlueGasHeatRecovery()
    # DB only
    return (false)
  end

  def IsCondensingBoiler()
    if systemClass != HSC_CENTRAL_HEATING then
      return (false)
    end
    case code
      when 			# gas boilers (1998 or later)
      HC_GASBLR_COND_AUTO, HC_GASBLR_COND_COMBI_AUTO, HC_GASBLR_COND_PERM, HC_GASBLR_CONDCOMBI_PERM, 			# gas boilers (pre-1998 with fan flues)
          HC_GASBLR_CONDCOMBI_PRE1998_FAN, HC_GASBLR_COND_PRE1998_FAN, 			# gas CPSU
          HC_GASCPSU_CONDENSING_AUTO, 			# oil boilers
          HC_OILBLR_CONDENSING, HC_OILBLR_CONDENSING_COMBI
        result = true
        break
      else
        result = false
        break
    end
    return (result)
  end

  def GetManufacturersWaterLossFactor()
    # this data is not included for SAP table records...
    return (self.N())
  end

  def IsStoveOrRange()
    case code
      when HC_SFBLR_STOVE_TORADS, HC_SFBLR_INTEGRAL_RANGE, HC_SFBLR_INDEPENDENT_RANGE, HC_GASRNG_SINGLE_PILOT, HC_GASRNG_SINGLE_AUTO, HC_GASRNG_TWIN_PILOT_PRE1998, HC_GASRNG_TWIN_AUTO_PRE1998, HC_GASRNG_TWIN_PILOT, HC_GASRNG_TWIN_AUTO, HC_OILRNG_SINGLE, HC_OILRNG_TWIN_PRE1998, HC_OILRNG_TWIN
        result = true
      else
        result = false
    end
    return (result)
  end

  def IsBackBoiler()
    case code
      when HC_SFBLR_OPEN_BACKBLR_TORADS, HC_SFBLR_CLOSED_HEATER_TORADS, HC_GASRH_PRE1980_OPEN_BACKBLR, HC_GASRH_MODERN_OPEN_BACKBLR, HC_GASRH_LIVEFUEL_OPEN_BACKBLR, HC_GASRH_LIVEFUEL_OPEN_FANFLUE, HC_OILRH_PRE2000_BACKBLR, HC_OILRH_MODERN_BACKBLR, HC_SFRH_OPEN_FIRE_BACKBLR, HC_SFRH_CLOSED_HEATER_BACKBLR, HC_SFRH_PELLET_STOVE_BACKBLR, HC_GASBLR_BACK_TORADS, HC_GASBLR_BACK_TORADS_PRE1998, HC_OILBLR_HEATER_TORADS_PRE2000, HC_OILBLR_HEATER_TORADS
        result = true
      else
        result = false
    end
    return (result)
  end

  def HasFanFlue()
    if flueOptions == FT_FAN then
      # can only be fan flue...
      _isFanFlue.SetValue(true)
    elsif flueOptions == FO_ANY then #firx for OA-26 was retuning false becayse bit mmask check wasn;t working.  If Any then coudl be fan flue
                                     # can be fan flue, but also others - unknown
      _isFanFlue.Clear()
    else
      # cannot be fan flue
      _isFanFlue.SetValue(false)
    end
    return (_isFanFlue)
  end

  def HasChimney()
    # if it can be chimney and only chimney - then it has a chimney
    return (flueOptions == FO_CHIMNEY)
  end

  def HasOpenFlue()
    # if it can be open and only open - then it has an open flue
    return (flueOptions == FO_OPEN)
  end

  def IsUnitInHeatedSpace()
    # there are some system where it's explict
    isInHeatedSpace = N[System::Boolean].new()
    case code # explicit (internal)
      when HC_SFBLR_MANFEED_INTERNAL, HC_SFBLR_AUTOFEED_INTERNAL, HC_ELECBLR_DRYCORE_INTERNAL, HC_ELECBLR_WATER_INTERNAL
        isInHeatedSpace = true
        break # explicit (external)
      when HC_SFBLR_MANFEED_EXTERNAL, HC_SFBLR_AUTOFEED_EXTERNAL, HC_ELECBLR_DRYCORE_EXTERNAL, HC_ELECBLR_WATER_EXTERNAL
        isInHeatedSpace = false
        break
    end
    return (isInHeatedSpace)
  end

  def IsCombiSystem()
    return (self.GetCombiType() != CBT_NOT_COMBI)
  end

  def IsFromDirectActingElectric()
    case code
      when HC_ELECBLR_DIRECT
        return true
      else
        return false
    end
  end

  def SetFuelSpecificEfficiency(fuel, efficiency)
    _alternateEfficiencies[fuel] = efficiency
  end

  def SetFuelSpecificResponsiveness(fuel, responsiveness)
    _alternateResponsiveness[fuel] = responsiveness
  end

  def GetFuelSpecificEfficiency(fuel)
    it = _alternateEfficiencies.find(fuel)
    if it == _alternateEfficiencies.end() then
      return (winterEfficiency)
    else
      return (it.second)
    end
  end

  def GetFuelSpecificResponsiveness(fuel)
    it = _alternateResponsiveness.find(fuel)
    if it == _alternateResponsiveness.end() then
      return (responsiveness)
    else
      return (it.second)
    end
  end

  def HasFuelSpecificEfficiency(fuel)
    return (_alternateEfficiencies.find(fuel) != _alternateEfficiencies.end())
  end

  def HasFuelSpecificResponsiveness(fuel)
    return (_alternateResponsiveness.find(fuel) != _alternateResponsiveness.end())
  end
end
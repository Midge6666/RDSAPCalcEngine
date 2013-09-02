class MainsGasController < FieldController
  def initialize()
    @_fieldTitle = "MainsGas"
    @_primaryHeatingFuelTitle1 = "PrimaryHeating1\\" + StringEnum.GetEnumTitle()
    @_primaryHeatingFuelTitle2 = "PrimaryHeating2\\" + StringEnum.GetEnumTitle()
    @_secondaryHeatingFuelTitle = "Secondary" + StringEnum.GetEnumTitle()
    @_waterHeatingTitle = StringEnum.GetEnumTitle()
    @_available = ContainedEnum.Create()
  end

  def IsGasSelected(Fuel)
    if Fuel.HasValue then
      return (Fuel == HEATSYS_FUEL.HSFUEL_MAINSGAS) ? true : false
    else
      return false
    end
  end

  def IsSedbukfuelSelected(Fuel)
    if Fuel.HasValue then
      return (Fuel == SEDBUK_FUEL.SF_FUEL_MAINSGAS) ? true : false
    else
      return false
    end
  end

  def IsWaterHeatingFuelSelected(Fuel)
    if Fuel.HasValue then
      if Fuel == WATER_TYPE.WHTYPE_GASBACKBOILER or Fuel == WATER_TYPE.WHTYPE_GASINSTANTMULTI or Fuel == WATER_TYPE.WHTYPE_GASINSTANTSINGLE or Fuel == WATER_TYPE.WHTYPE_GASWASYSTEM_1998On or Fuel == WATER_TYPE.WHTYPE_GASWASYSTEM_PRE98 then
        return true
      else
        return false
      end
    else
      return false
    end
  end

  def DoControl()
    @_available.SetAvailability(@_available.All, true)
    if self.IsGasSelected(_connectedFields[@_primaryHeatingFuelTitle1].AsInt) then
      @_available.SetAvailability(YESNO.NO, false)
    else
      @_available.SetAvailability(YESNO.NO, true)
    end
    if (_connectedFields.ContainsKey(@_primaryHeatingFuelTitle2)) and (self.IsGasSelected(_connectedFields[@_primaryHeatingFuelTitle2].AsInt)) then
      @_available.SetAvailability(YESNO.NO, false)
    end
    if (_connectedFields.ContainsKey(@_secondaryHeatingFuelTitle)) and (self.IsGasSelected(_connectedFields[@_secondaryHeatingFuelTitle].AsInt)) then
      @_available.SetAvailability(YESNO.NO, false)
    end
    if self.IsWaterHeatingFuelSelected(_connectedFields[@_waterHeatingTitle].AsInt) then
      @_available.SetAvailability(YESNO.NO, false)
    end
    _ruleManager.SetRule(DiscreteDataRule[YESNO].new(@_available))
  end
end
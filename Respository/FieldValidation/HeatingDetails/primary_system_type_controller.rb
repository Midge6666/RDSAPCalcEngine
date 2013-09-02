class PrimarySystemTypeController < FieldController
  def initialize()
    @_fieldTitle = StringEnum.GetEnumTitle()
    @_numberOfSystemsTitle = StringEnum.GetEnumTitle()
    @_primarySystemEnum = ContainedEnum.Create()
  end

  def DoControl()
    numberOfSystems = _connectedFields[@_numberOfSystemsTitle].AsInt
    if (numberOfSystems.HasValue) and (numberOfSystems != NUMBER_PRIMARY_SYSTEMS.NMS_NONE) then
      @_primarySystemEnum.SetAvailability(@_primarySystemEnum.All, true)
      @_primarySystemEnum.SetAvailability(PRIMARY_SYSTEM_TYPE.PST_NONE, false)
    else
      @_primarySystemEnum.SetAvailability(@_primarySystemEnum.All, false)
      @_primarySystemEnum.SetAvailability(PRIMARY_SYSTEM_TYPE.PST_NONE, true)
    end
    _ruleManager.SetRule(DiscreteDataRule[PRIMARY_SYSTEM_TYPE].new(@_primarySystemEnum))
  end
end
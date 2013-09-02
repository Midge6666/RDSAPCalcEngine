class FlueFanController < FieldController
  def initialize() # special case - will be "not available" # special case - will be "not available" # special case - will be "not available"
                   # special... no need for available list
                   # special... no need for available list
                   # two bits of info can be used to try and determine the flue type in the following order
                   #		1. Primary System Code
                   #		2. Primary System Sub-type
                   # no result after checking system code - try system sub-type
                   # field will be "not required" until the system or sub-type is selected
    @_primaryHeatingSourceTitle = StringEnum.GetEnumTitle()
    @_primarySystemSubTypeTitle = StringEnum.GetEnumTitle()
    @_primarySystemCodeTitle = StringEnum.GetEnumTitle()
    @_primaryFlueTypeTitle = StringEnum.GetEnumTitle()
    @_sedbukBoilerIndexTitle = "SedbukBoilerIndex"
    @_notRequiredDataRule = NotRequiredDataRule.Instance
  end

  def DoControl()
    newRule = nil
    primaryHeatingSourceInt = _connectedFields[@_primaryHeatingSourceTitle].AsInt
    if primaryHeatingSourceInt.HasValue == false or primaryHeatingSourceInt.Value == PRIMARY_SYSTEM_TYPE.PST_NONE then
      newRule = @_notRequiredDataRule
    elsif primaryHeatingSourceInt.Value == PRIMARY_SYSTEM_TYPE.PST_SEDBUK then
      newRule = self.DoControlFromSedbuk()
    elsif primaryHeatingSourceInt.Value == PRIMARY_SYSTEM_TYPE.PST_SAP then
      newRule = self.DoControlFromSapTables()
    else
      System.Diagnostics.Debug.Assert(false, "Invalid primary system type specified")
      newRule = @_notRequiredDataRule
    end
    System.Diagnostics.Debug.Assert(newRule != nil, "Should never have null rule")
    if newRule == nil then
      newRule = @_notRequiredDataRule
    end
    _ruleManager.SetRule(newRule)
  end

  def ConstructRuleBasedOnFlueAvailability(availabilityCode)
    availableList = nil
    case availabilityCode
      when FLUE_AVAILABILITY_CODE.FAC_ANY
        availableList = List[YESNO].new(YESNO.YES, YESNO.NO)
        break
      when FLUE_AVAILABILITY_CODE.FAC_BALANCED
        availableList = List[YESNO].new(YESNO.NO)
        break
      when FLUE_AVAILABILITY_CODE.FAC_BALANCED_OR_FAN
        availableList = List[YESNO].new(YESNO.YES, YESNO.NO)
        break
      when FLUE_AVAILABILITY_CODE.FAC_CHIMNEY
        break
      when FLUE_AVAILABILITY_CODE.FAC_FAN_ASSISTED
        availableList = List[YESNO].new(YESNO.YES)
        break
      when FLUE_AVAILABILITY_CODE.FAC_FLUELESS
        break
      when FLUE_AVAILABILITY_CODE.FAC_NONE
        break
      when FLUE_AVAILABILITY_CODE.FAC_NOT_REQUIRED
        break
      when FLUE_AVAILABILITY_CODE.FAC_OPEN
        availableList = List[YESNO].new(YESNO.NO)
        break
      when FLUE_AVAILABILITY_CODE.FAC_OPEN_OR_BALANCED
        availableList = List[YESNO].new(YESNO.NO)
        break
      else
        System.Diagnostics.Debug.Assert(false, "Invalid flue availability code supplied")
        break
    end
    if availableList == nil then
      rule = NotRequiredDataRule.Instance
    else
      fanEnum = ContainedEnum.Create()
      fanEnum.SetAvailability(availableList, true, false)
      rule = DiscreteDataRule[FLUE_TYPE].new(fanEnum)
    end
    return (rule)
  end

  def ConstructRuleBasedOnFlueAvailabilityForSedbuk(availabilityCode)
    availableList = nil
    case availabilityCode
      when FLUE_AVAILABILITY_CODE.FAC_NOT_REQUIRED
        availableList = List[YESNO].new(YESNO.NO)
        break
    end
    if availableList == nil then
      rule = NotRequiredDataRule.Instance
    else
      fanEnum = ContainedEnum.Create()
      fanEnum.SetAvailability(availableList, true, false)
      rule = DiscreteDataRule[FLUE_TYPE].new(fanEnum)
    end
    return (rule)
  end

  def DoControlFromSedbuk()
    result = @_notRequiredDataRule
    if _connectedFields.ContainsKey(@_sedbukBoilerIndexTitle) then
      boilerIndexStrg = _connectedFields[@_sedbukBoilerIndexTitle].Value
      if not System::String.IsNullOrEmpty(boilerIndexStrg) then
        boilerItem = SedbukAccess.Data.Find(i.Index == boilerIndexStrg)
        if boilerItem != nil then
          availabilityCode = System.Convert.ToInt16(boilerItem.FlueType)
          result = self.ConstructRuleBasedOnFlueAvailabilityForSedbuk(availabilityCode)
        end
      end
    end
    return (result)
  end

  def DoControlFromSapTables()
    result = nil
    flueType = _connectedFields[@_primaryFlueTypeTitle].AsInt
    if flueType.HasValue then
      if flueType.Value == FLUE_TYPE.FT_FAN_ASSISTED then
        availableList = List[YESNO].new(YESNO.YES)
        fanEnum = ContainedEnum.Create()
        fanEnum.SetAvailability(availableList, true, false)
        result = DiscreteDataRule[FLUE_TYPE].new(fanEnum)
      elsif flueType.Value == FLUE_TYPE.FT_BALANCED then
        availableList = List[YESNO].new(YESNO.NO)
        fanEnum = ContainedEnum.Create()
        fanEnum.SetAvailability(availableList, true, false)
        result = DiscreteDataRule[FLUE_TYPE].new(fanEnum)
      end
    end
    if result == nil then
      systemCode = _connectedFields[@_primarySystemCodeTitle].AsInt
      if systemCode.HasValue then
        info = HeatingMapping.GetSystemInfo(systemCode)
        System.Diagnostics.Debug.Assert((info != nil), "Unregistered system code specified for primary system")
        if info == nil then
          result = @_notRequiredDataRule
        else
          result = self.ConstructRuleBasedOnFlueAvailability(info.FlueAvailability)
        end
      end
    end
    if result == nil then
      systemSubType = _connectedFields[@_primarySystemSubTypeTitle].AsInt
      if systemSubType.HasValue then
        flueAvailablityList = HeatingMapping.GetFlueAvailabilityForSubType(systemSubType.Value)
        if flueAvailablityList.Count() == 1 then
          result = self.ConstructRuleBasedOnFlueAvailability(flueAvailablityList.First())
        end
      end
    end
    if result == nil then
      result = @_notRequiredDataRule
    end
    return (result)
  end
end
class HasWWHRSController < FieldController
  def initialize()
    @_roomWithBathShowerFieldname = "RoomsWithBathShower"
    @_fieldTitle = StringEnum.GetEnumTitle()
  end

  def DoControl()
    roomsWithBathShower = _connectedFields["RoomsWithBathShower"].AsInt
    if roomsWithBathShower.HasValue and roomsWithBathShower.Value > 0 then
      _ruleManager.SetRule(DiscreteDataRule[HAS_WWHRS].new(ContainedEnum.Create()))
      self.SetDefault()
    else
      self.SetDefault()
      _ruleManager.SetRule(NotRequiredDataRule.Instance)
    end
  end

  def SetDefault()
    if System::String.IsNullOrEmpty(self.@Current) then
      EpcDomainController.Singleton.Execute(EpcDomainController.CreateUpdateCommand(self.@FullName, HAS_WWHRS.HASWWHRS_NO))
    end
  end
end
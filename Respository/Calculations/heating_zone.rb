class HeatingZone
  def initialize(demandTemperature, heatingResponsiveness)
    self.@_timeConstant =  < type
    self.@_utilisationFactor =  < type
    self.@_weekends = demandTemperature
    self.@_weekdays = demandTemperature
    _Ti = demandTemperature
    _R = heatingResponsiveness
  end

  def SetHeatingHours(hours)
    _weekdays.SetPattern(hours.weekday.offPeriod1, hours.weekday.offPeriod2, hours.weekday.offPeriod3, hours.weekday.offPeriod4)
    _weekends.SetPattern(hours.weekend.offPeriod1, hours.weekend.offPeriod2, hours.weekend.offPeriod3, hours.weekend.offPeriod4)
  end

  def SetWeekdayHeatingPattern(off1, off2, off3, off4)
    _weekdays.SetPattern(off1, off2, off3, off4)
  end

  def SetWeekendHeatingPattern(off1, off2, off3, off4)
    _weekends.SetPattern(off1, off2, off3, off4)
  end

  def Calculate(month, H, G, Te, hlp, tmp, pAppendixN, pOccupancy, SG)
    # table9c step 2 - calculate utilisation factor
    result = Table9a.Lookup(H, G, Te, hlp, _Ti, tmp)
    _timeConstant.SetMonthResult(month, result.timeConstant)
    _utilisationFactor.SetMonthResult(month, result.utilisationFactor)
    wd = _weekdays.Calculate(month, result.timeConstant, _R, G, H, Te, result.utilisationFactor, pOccupancy)
    we = _weekends.Calculate(month, result.timeConstant, _R, G, H, Te, result.utilisationFactor, pOccupancy)
    # This is the standard calc, for Appendix N a whole new formulae is introduced
    if pAppendixN == nil then
      # V3 - Calculation of Mean internal temperature.
      if pOccupancy != nil and pOccupancy.IsGreenDealOccupancy(INTERNAL_TEMPERATURES) then
        numberOfNormal = 7 - pOccupancy.GetNumberAlternateDays()
        # proportional average over the week
        t = ((wd * numberOfNormal) + (we * pOccupancy.GetNumberAlternateDays())) / 7.0
      else
        # proportional average over the week
        t = ((wd * 5.0) + (we * 2.0)) / 7.0
      end
    else
      t = pAppendixN.CalcMeanInternalTemp(month, we, wd, _Ti)
    end
    _meanTemperature.SetMonthResult(month, t)
    return (t)
  end
end

class HeatingPattern
  def initialize(demandTemperature)
    _demandTemperature.SetAllMonths(demandTemperature)
  end

  def SetPattern(off1, off2, off3, off4)
    _offPeriods[0] = off1
    _offPeriods[1] = off2
    _offPeriods[2] = off3
    _offPeriods[3] = off4
  end

  def Calculate(month, adjustedDT, tc, R, G, H, Te, eta, pOccupancy)
    _demandTemperature.SetMonthResult(month, adjustedDT)
    return (self.Calculate(month, tc, R, G, H, Te, eta, pOccupancy))
  end

  def Calculate(month, tc, R, G, H, Te, eta, pOccupancy)
    offPeriodCount = _offPeriods.Length
    Th = _demandTemperature.GetMonthResult(month)
    if pOccupancy != nil and pOccupancy.IsGreenDealOccupancy(INTERNAL_TEMPERATURES) then
    end
    #Th = pOccupancy->GetLivingAreaTemperature();
    # meanTemperature starts at the demand temperature - this is what the mean temperature would
    # be if the heating was on 24 hours a day, then for each off period the temperature drop
    # during that period (Table9b) is subtracted from the starting point
    meanTemperature = Th
    period = 0
    while period < offPeriodCount
      # Table9c step 3 - calculate temperature reduction for each off period during weekdays
      u = Table9b.Lookup(tc, _offPeriods[period], Th, R, G, H, Te, eta)
      # QUESTION: should u be stored? if so could turn _offPeriods[] into a structure to store - however remember that for
      #			 zone 2 the values for u will vary by month so storage would have to be a ResultData<double>
      # Table9c step 4 - Tweekday is Th - (u1 + u2)
      meanTemperature -= u
      period += 1
    end
    _meanTemperature.SetMonthResult(month, meanTemperature)
    return (meanTemperature)
  end
end
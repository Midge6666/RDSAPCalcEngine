class AppendixG
  def initialize()
    self.@_wwhrsRecord1 = nil
    self.@_wwhrsRecord2 = nil
    self.@_fghrsRecord = nil
  end

  def calculate(waterHeatingEnergy, spaceHeatingRequirement, systemFraction, isAppendixGCombi, keepHotFacility, pSystem)
    if _fghrsRecord.GetHeatStore() != PCDF_FGHRS_HS_EXTERNAL and pSystem.GetCombiType() != CBT_STORAGE_SECONDARY and IsAppendixGCombi then
      @isAppendixGCombi = true
    else #  an appendix g combi as the heat store is not close coupled and is not used a secondary store
      @isAppendixGCombi = false
    end
    @waterHeatingEnergy = waterHeatingEnergy
    @spaceHeatingRequirement = spaceHeatingRequirement
    @systemFraction = systemFraction
    @isAppendixGCombi = isAppendixGCombi
    @keepHotFacility = keepHotFacility
    @pSystem = pSystem
    if @fghrsRecord.GetHeatStore() == PCDF_FGHRS_HS_NONE then
      self.CalcG1()
    else
      self.CalcG3() # G4 also - Step 1
                    #bool UseInstantCombiWithoutKeepHot = false;
      it = Year.Begin()
      while it != Year.End()
        # Step 2
        ospm = @g3Result.GetMonthResult()
        resultBands = @fghrsRecord.GetCoefficientBands(Qspm)
        # If either banded data is an exact match then use those coefficients
        useBand = nil
        if @resultBands.Lower() != nil and @resultBands.Lower().GetSpaceHeatingRequirementFromBoilerSystem() == ospm then
          useBand = @resultBands.Lower()
        end
        if resultBands.Upper() != nil and @resultBands.Upper().GetSpaceHeatingRequirementFromBoilerSystem() == ospm then
          useBand = resultBands.Upper()
        end
        # step 6 - this step better done here I think
        if resultBands.Upper() == nil then
          useBand = resultBands.Lower()
        end
        if UseBand != nil then # only one set of data to consider so no interpolation required
          result = self.CalcG2(@useBand, @isAppendixGCombi, @ospm)
          result = @g2Result.GetMonthResult()
        else
          resultLower = self.CalcG2(ResultBands.Lower(), @isAppendixGCombi, Qspm)
          resultLower = @g2Result.GetMonthResult()
          resultUpper = self.CalcG2(ResultBands.Upper(), @isAppendixGCombi, Qspm)
          resultUpper = @g2Result.GetMonthResult()
          # step 4
          @result = self.LinearInterpolate(resultBands.Lower().GetSpaceHeatingRequirementFromBoilerSystem(), resultBands.Upper().GetSpaceHeatingRequirementFromBoilerSystem(), resultLower, resultUpper, ospm)
        end
        # step 5
        if result < 0 then
          result = 0.0
        end
        # step 7
        if @isAppendixGCombi then
          sm = Result
        else
          if @keepHotFacility then
            keepHotElec = self.GetKeepHotElectrity(_pSystem.GetKeepHotFacility())
            sm = Result + 0.5 * @fghrsRecord.GetDirectTotalHeatRecovered() * (@waterHeatingEnergy.GetCombiLoss() - keepHotElec)
          else
            losses = _waterHeatingEnergy.GetAdjustedWaterStorageLoss() + @waterHeatingEnergy.GetPrimaryCircuitLoss() + @waterHeatingEnergy.GetCombiLoss()
            directHeatRec = @fghrsRecord.GetDirectTotalHeatRecovered()
            if result == 0.0 then
              sm = 0.0
            else
              sm = result + 0.5 * directHeatRec * (losses - (1 - self.CalcKn()) * (@waterHeatingEnergy.GetEnergyContent() + @waterHeatingEnergy.GetSolarCalcResult() - @g10Result.GetMonthResult()))
            end
          end
        end
        @sm.SetMonthResult(, sm)
        it += 1
      end
    end
  end

  def get_keep_hot_electricity(keepHotElectricity)
    if keepHotElectricity != nil then
      if keepHotElectricity == KHF_WITH_TIME_CONTROL then
        result = 0.0
      elsif keepHotElectricity == KHF_NO_TIME_CONTROL then
        result = 900.0
      else
        result = 0.0
      end
    else
      result = 0.0
    end
    return (result)
  end

  def calc_vk()
    volume = @fghrsRecord.GetHeatStoreTotal()
    if volume == 0.0 then
      volume = @waterHeatingEnergy.GetCylinderVolume()
      if @pSystem.IsCPSUSystem() or @pSystem.GetClass() == HSC_STORAGE_HEATING then
        volume *= 1.3
      end
    end
    return volume
  end

  def calc_kn()
    vk = self.calc_vk()
    if vk >= 144.0 then
      return 0.0
    elsif vk < 144.0 and vk >= 75 then
      return 0.48 - vk / 300.0
    elsif vk < 75 and vk > 15 then
      return 1.1925 - 0.77 * vk / 60.0
    else
      return 1.0
    end
  end

  def calc_g1()
    @kf1 = _fghrsRecord.GetDirectUsefulHeatRecovered()
    enumerator = .GetEnumerator()
    while enumerator.MoveNext()
      = enumerator.Current
    end

    @Sm.SetMonthResult(month, _g1Result.GetMonthResult(month))
  end

  def calc_g2(a, b, c)
    enumerator = .GetEnumerator()
    while enumerator.MoveNext()
      = enumerator.Current
    end

    qhwm = qhwm + @waterHeatingEnergy.GetSolarCalcResult(month) - @g10Result.GetMonthResult(month)
    result = 0.0
    if qhwm < 0 then
      result = 0.0
    else
      if qhwm < 80 then
        tempQhwm = 80.0
        result = a * Math.Log(tempQhwm) + b * tempQhwm + c
        result *= (Qhwm / 80.0)
      elsif qhwm > 309 then
        tempQhwm = 309.0
        result = a * Math.Log(TempQhwm) + b * TempQhwm + c
      else # qhwm < 80 && qhwm > 309
        result = a * Math.Log(qhwm) + b * qhwm + c
      end
    end
    _g2Result.SetMonthResult(month, result)
  end

  def calc_g3()
    enumerator = .GetEnumerator()
    while enumerator.MoveNext()
      = enumerator.Current
    end
  end

  def calc_g2(a, b, c, qspm)
    if qspm <= 0.0 then
      return 0.0
    end
    return a * Math.Log(qspm) + b * qspm + c
  end


  def calc_g2(useBand, isAppendixGCombi, ospm)
    if IsAppendixGCombi then
      a = useBand.GetCoefficientACombi()
      b = useBand.GetCoefficientBCombi()
      c = useBand.GetCoefficientCCombi()
    else
      a = useBand.GetCoefficientAOtherBoilers()
      b = useBand.GetCoefficientBOtherBoilers()
      c = useBand.GetCoefficientCOtherBoilers()
    end
    self.calc_g2(a, b, c) # qhwm version
    return 0.0
  end

  def get_electrical_consumption
    return @fghrsRecord == nil ? 0 : @fghrsRecord.GetPowerConsumption()
  end

  def calculate_solar_input(energyContentYear, averageWaterUsage)
    if @peakPowerPV.TestValue() then
      renewablesTable = TableHx.new()
      g1 = _peakPowerPV.GetValue()
      g2 = renewablesTable.H2.GetSolarRadiation(_tilt, _orientation)
      g3 = renewablesTable.H4.GetOvershadingFactor(_overshading)
      g4 = _fghrsRecord.GetCableLoss()
      g5 = 0.84 * g1 * g2 * g3 * (1 - g4)
      g6 = g5 / energyContentYear
      g7 = g6 > 0 ? 1 - Math.Exp(-1 / g6) : 0
      g8 = @fghrsRecord.GetHeatStoreTotal()
      g9 = 0.76 * g8
      g10 = AverageWaterUseage
      g11 = g9 / g10
      g12 = 1 + 0.2 * Math.Log(g11)
      g13 = g5 * g7 * g12
      qs = g13
      enumerator = .GetEnumerator()
      while enumerator.MoveNext()
        = enumerator.Current
      end

    end
  end

  def set_PV_settings(peakPowerPV, tilt, orientation, over_shading)
    @peakPowerPV = peakPowerPV
    @tilt = tilt
    @orientation = orientation
    @over_shading = over_shading
  end

  def set_WWHRS_record_data(uF, heatRecoveryEffy, wwhrsRecord)
    if wwhrsRecord != nil then
      uf = wwhrsRecord.GetUtilisationFactor()
      heatRecoveryEffy = wwhrsRecord.GetEfficiency() / 100.0
    else # the number from pcdf is a %, we need it as a decimal to make the calc work
      uf = 0.0
      heatRecoveryEffy = 0.0
    end
  end

  def calculate_WWHRS(numBathAndShower, numShowersWithWWHRS1AndBath, numShowersWithWWHRS1NoBath, numShowersWithWWHRS2AndBath, numShowersWithWWHRS2NoBath, pOccupants)
    self.SetWWHRSRecordData(UF1, @HeatRecoveryEffy1, @wwhrsRecord1)
    self.SetWWHRSRecordData(UF2, @HeatRecoveryEffy2, @wwhrsRecord2)
    @g9Result = ((numShowersWithWWHRS1AndBath * 0.635 * @HeatRecoveryEffy1 * UF1) + (numShowersWithWWHRS2AndBath * 0.635 * @HeatRecoveryEffy2 * UF2) + (numShowersWithWWHRS1NoBath * @HeatRecoveryEffy1 * UF1) + (numShowersWithWWHRS2NoBath * @HeatRecoveryEffy2 * UF2)) / numBathAndShower
    enumerator = .GetEnumerator()
    while enumerator.MoveNext()
      = enumerator.Current
    end

    tColdM = self.TableG2().GetMonthResult(month)
    aWm = (0.33 * 25 * Table1.Table1d().GetMonthResult(month) / (41 - tColdM)) + 26.1
    bWm = 0.33 * 36 * Table1.Table1d().GetMonthResult(month) / (41 - tColdM)
    mFm = Table1.Table1c().GetMonthResult(month)
    g10Result = (N * aWm + bWm) * @g9Result * (35.0 - t_cold_m) * 4.18 * month.GetNumDays() * MFm / 3600
    @g10Result.SetMonthResult(month, g10Result)
  end


  def get_WWHRS_result

  end

  def set_FGHRS_index

  end

  def get_WWHRS_index
  end

  def get_table_g2_result_data

  end


end
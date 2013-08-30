class Table4e
  # To change this template use File | Settings | File Templates.

  @table4eData = []

  # inputs
  @cpsuOrIts = false
  @delayedStartTS = false

  # outputs
  @code = 0
  @controlLevel = 0
  @tempAdjust = 0
  @adjustment = 0

  def initialize
    cgo_none = [ SAP_CONTROLS_CODE[:CG0_NONE],	2,	0.3 ]
    cgo_not_relevant =  [ SAP_CONTROLS_CODE[:CG0_NOT_RELEVANT],	1,	0.0 ]

    # GROUP 1 ( Boiler systems )
    cg1_no_controls = [ SAP_CONTROLS_CODE[:CG1_NO_CONTROLS],	1,	0.6 ]
    cg1_prog_only = [ SAP_CONTROLS_CODE[:CG1_PROG_ONLY],	1,	0.6 ]
    cg1_roomstat_only = [ SAP_CONTROLS_CODE[:CG1_ROOMSTAT_ONLY],	1,	0.0 ]
    cg1_prog_roomstat = [ SAP_CONTROLS_CODE[:CG1_PROG_ROOMSTAT],	1,	0.0 ]
    cg1_prog_multistat = [ SAP_CONTROLS_CODE[:CG1_PROG_MULTISTAT],	2,	0.0 ]
    cg1_prog_roomstat_trvs = [ SAP_CONTROLS_CODE[:CG1_PROG_ROOMSTAT_TRVS],	2,	0.0 ]
    cg1_trvs_bypass = [ SAP_CONTROLS_CODE[:CG1_TRVS_BYPASS], 2,	0.0 ]
    cg1_prog_trvs_bypass = [ SAP_CONTROLS_CODE[:CG1_PROG_TRVS_BYPASS],	2,	0.0 ]
    cg1_prog_trvs_flowswitch = [ SAP_CONTROLS_CODE[:CG1_PROG_TRVS_FLOWSWITCH],	2,	0.0 ]
    cg1_prog_trvs_bem = [ SAP_CONTROLS_CODE[:CG1_PROG_TRVS_BEM],	2,	0.0 ]
    cg1_zone_control = [ SAP_CONTROLS_CODE[:CG1_ZONE_CONTROL], 3,	0.0 ]

    # GROUP 2 (Heat pumps - wet systems)
    cg2_no_controls = [ SAP_CONTROLS_CODE[:CG2_NO_CONTROLS], 1,	0.3 ]
    cg2_prog_only = [ SAP_CONTROLS_CODE[:CG2_PROG_ONLY], 1,	0.3 ]
    cg2_roomstat_only = [ SAP_CONTROLS_CODE[:CG2_ROOMSTAT_ONLY], 1,	0.0 ]
    cg2_prog_roomstat = [ SAP_CONTROLS_CODE[:CG2_PROG_ROOMSTAT], 1,	0.0 ]
    cg2_prog_multistat = [ SAP_CONTROLS_CODE[:CG2_PROG_MULTISTAT], 2,	0.0 ]
    cg2_prog_trvs_bypass = [ SAP_CONTROLS_CODE[:CG2_PROG_TRVS_BYPASS], 2,	0.0 ]
    cg2_zone_control = [ SAP_CONTROLS_CODE[:CG2_ZONE_CONTROL], 3,	0.0 ]

    # GROUP 3 (Community Heating Heat pumps - wet systems)
    cg3_frc_no_controls = [ SAP_CONTROLS_CODE[:CG3_FRC_NO_CONTROLS], 1,	0.3 ]
    cg3_frc__prog_only = [ SAP_CONTROLS_CODE[:CG3_FRC_PROG_ONLY], 1,	0.3 ]
    cg3_frc_roomstat_only = [ SAP_CONTROLS_CODE[:CG3_FRC_ROOMSTAT_ONLY], 1,	0.0 ]
    cg3_frc_prog_roomstat = [ SAP_CONTROLS_CODE[:CG3_FRC_PROG_ROOMSTAT], 1,	0.0 ]
    cg3_frc_trvs_only = [ SAP_CONTROLS_CODE[:CG3_FRC_TRVS_ONLY], 2,	0.0 ]
    cg3_frc_prog_trvs = [ SAP_CONTROLS_CODE[:CG3_FRC_PROG_TRVS], 2,	0.0 ]
    cg3_ubc_roomstat_only = [ SAP_CONTROLS_CODE[:CG3_UBC_ROOMSTAT_ONLY], 2,	0.0]
    cg3_ubc_prog_roomstat = [ SAP_CONTROLS_CODE[:CG3_UBC_PROG_ROOMSTAT], 2,	0.0 ]
    cg3_ubc_trvs_only = [ SAP_CONTROLS_CODE[:CG3_UBC_TRVS_ONLY], 3,	0.0 ]
    cg3_ubc_prog_trvs = [ SAP_CONTROLS_CODE[:CG3_UBC_PROG_TRVS], 3,	0.0 ]

    # GROUP 4 (electric storage)
    cg4_manual_charge = [ SAP_CONTROLS_CODE[:CG4_MANUAL_CHARGE], 3,	0.3 ]
    cg4_auto_charge = [ SAP_CONTROLS_CODE[:CG4_AUTO_CHARGE], 3,	0.0 ]
    cg4_celect = [ SAP_CONTROLS_CODE[:CG4_CELECT], 3,	0.0]

    # GROUP 5 (warm air systems - including heatpumps with warm-air distribution)
    cg5_no_controls = [ SAP_CONTROLS_CODE[:CG5_NO_CONTROLS], 1,	0.3 ]
    cg5_prog_only = [ SAP_CONTROLS_CODE[:CG5_PROG_ONLY], 1,	0.3 ]
    cg5_roomstat_only = [ SAP_CONTROLS_CODE[:CG5_ROOMSTAT_ONLY], 1,	0.0]
    cg5_prog_roomstat = [ SAP_CONTROLS_CODE[:CG5_PROG_ROOMSTAT], 1,	0.0]
    cg5_prog_multistat = [ SAP_CONTROLS_CODE[:CG5_PROG_MULTISTAT], 2,	0.0]
    cg5_zone_control = [ SAP_CONTROLS_CODE[:CG5_ZONE_CONTROL], 3,	0.0]

    # GROUP 6 (room heater systems)
    cg6_no_controls = [ SAP_CONTROLS_CODE[:CG6_NO_CONTROLS], 2,	0.3 ]
    cg6_applstats = [ SAP_CONTROLS_CODE[:CG6_APPLSTATS], 3,	0.0 ]
    cg6_prog_applstats = [ SAP_CONTROLS_CODE[:CG6_PROG_APPLSTATS], 3,	0.0 ]
    cg6_roomstat_only = [ SAP_CONTROLS_CODE[:CG6_ROOMSTAT_ONLY], 3,	0.0 ]
    cg6_prog_roomstat = [ SAP_CONTROLS_CODE[:CG6_PROG_ROOMSTAT], 3,	0.0 ]

    # GROUP 7 (other systems)
    cg7_no_controls = [ SAP_CONTROLS_CODE[:CG7_NO_CONTROLS], 1,	0.3 ]
    cg7_prog_only = [ SAP_CONTROLS_CODE[:CG7_PROG_ONLY], 1,	0.3 ]
    cg7_roomstat_only = [ SAP_CONTROLS_CODE[:CG7_ROOMSTAT_ONLY], 1,	0.0 ]
    cg7_prog_roomstat = [ SAP_CONTROLS_CODE[:CG7_PROG_ROOMSTAT], 1,	0.0 ]
    cg7_temp_zone_control = [ SAP_CONTROLS_CODE[:CG7_TEMP_ZONE_CONTROL], 2,	0.0 ]
    cg7_full_zone_control = [ SAP_CONTROLS_CODE[:CG7_FULL_ZONE_CONTROL], 3,	0.0 ]

    @table4eData = { SAP_CONTROLS_CODE[:CG0_NONE] => cgo_none,
                     SAP_CONTROLS_CODE[:CG0_NOT_RELEVANT] => cgo_not_relevant,
                     SAP_CONTROLS_CODE[:CG1_NO_CONTROLS] => cg1_no_controls,
                     SAP_CONTROLS_CODE[:CG1_PROG_ONLY] => cg1_prog_only,
                     SAP_CONTROLS_CODE[:CG1_ROOMSTAT_ONLY] => cg1_roomstat_only,
                     SAP_CONTROLS_CODE[:CG1_PROG_ROOMSTAT] => cg1_prog_roomstat,
                     SAP_CONTROLS_CODE[:CG1_PROG_MULTISTAT] => cg1_prog_multistat,
                     SAP_CONTROLS_CODE[:CG1_PROG_ROOMSTAT_TRVS] => cg1_prog_roomstat_trvs,
                     SAP_CONTROLS_CODE[:CG1_TRVS_BYPASS] => cg1_trvs_bypass,
                     SAP_CONTROLS_CODE[:CG1_PROG_TRVS_BYPASS] => cg1_prog_trvs_bypass,
                     SAP_CONTROLS_CODE[:CG1_PROG_TRVS_FLOWSWITCH] => cg1_prog_trvs_flowswitch,
                     SAP_CONTROLS_CODE[:CG1_PROG_TRVS_BEM] => cg1_prog_trvs_bem,
                     SAP_CONTROLS_CODE[:CG1_ZONE_CONTROL] => cg1_zone_control,
                     SAP_CONTROLS_CODE[:CG2_NO_CONTROLS] => cg2_no_controls,
                     SAP_CONTROLS_CODE[:CG2_PROG_ONLY] => cg2_prog_only,
                     SAP_CONTROLS_CODE[:CG2_ROOMSTAT_ONLY] => cg2_roomstat_only,
                     SAP_CONTROLS_CODE[:CG2_PROG_ROOMSTAT] => cg2_prog_roomstat,
                     SAP_CONTROLS_CODE[:CG2_PROG_MULTISTAT] => cg2_prog_multistat,
                     SAP_CONTROLS_CODE[:CG2_PROG_TRVS_BYPASS] => cg2_prog_trvs_bypass,
                     SAP_CONTROLS_CODE[:CG2_ZONE_CONTROL] => cg2_zone_control,
                     SAP_CONTROLS_CODE[:CG3_FRC_NO_CONTROLS] => cg3_frc_no_controls,
                     SAP_CONTROLS_CODE[:CG3_FRC_PROG_ONLY] => cg3_frc__prog_only,
                     SAP_CONTROLS_CODE[:CG3_FRC_ROOMSTAT_ONLY] => cg3_frc_roomstat_only,
                     SAP_CONTROLS_CODE[:CG3_FRC_PROG_ROOMSTAT] => cg3_frc_prog_roomstat,
                     SAP_CONTROLS_CODE[:CG3_FRC_TRVS_ONLY] => cg3_frc_trvs_only,
                     SAP_CONTROLS_CODE[:CG3_FRC_PROG_TRVS] => cg3_frc_prog_trvs,
                     SAP_CONTROLS_CODE[:CG3_UBC_ROOMSTAT_ONLY] => cg3_ubc_roomstat_only,
                     SAP_CONTROLS_CODE[:CG3_UBC_PROG_ROOMSTAT] => cg3_ubc_prog_roomstat,
                     SAP_CONTROLS_CODE[:CG3_UBC_TRVS_ONLY] => cg3_ubc_trvs_only,
                     SAP_CONTROLS_CODE[:CG3_UBC_PROG_TRVS] => cg3_ubc_prog_trvs,
                     SAP_CONTROLS_CODE[:CG4_MANUAL_CHARGE] => cg4_manual_charge,
                     SAP_CONTROLS_CODE[:CG4_AUTO_CHARGE] => cg4_auto_charge,
                     SAP_CONTROLS_CODE[:CG4_CELECT] => cg4_celect,
                     SAP_CONTROLS_CODE[:CG5_NO_CONTROLS] => cg5_no_controls,
                     SAP_CONTROLS_CODE[:CG5_PROG_ONLY] => cg5_prog_only,
                     SAP_CONTROLS_CODE[:CG5_ROOMSTAT_ONLY] => cg5_roomstat_only,
                     SAP_CONTROLS_CODE[:CG5_PROG_ROOMSTAT] => cg5_prog_roomstat,
                     SAP_CONTROLS_CODE[:CG5_PROG_MULTISTAT] => cg5_prog_multistat,
                     SAP_CONTROLS_CODE[:CG5_ZONE_CONTROL] => cg5_zone_control,
                     SAP_CONTROLS_CODE[:CG6_NO_CONTROLS] => cg6_no_controls,
                     SAP_CONTROLS_CODE[:CG6_APPLSTATS] => cg6_applstats,
                     SAP_CONTROLS_CODE[:CG6_PROG_APPLSTATS] => cg6_prog_applstats,
                     SAP_CONTROLS_CODE[:CG6_ROOMSTAT_ONLY] => cg6_roomstat_only,
                     SAP_CONTROLS_CODE[:CG6_PROG_ROOMSTAT] => cg6_prog_roomstat,
                     SAP_CONTROLS_CODE[:CG7_NO_CONTROLS] => cg7_no_controls,
                     SAP_CONTROLS_CODE[:CG7_PROG_ONLY] => cg7_prog_only,
                     SAP_CONTROLS_CODE[:CG7_ROOMSTAT_ONLY] => cg7_roomstat_only,
                     SAP_CONTROLS_CODE[:CG7_PROG_ROOMSTAT] => cg7_prog_roomstat,
                     SAP_CONTROLS_CODE[:CG7_TEMP_ZONE_CONTROL] => cg7_temp_zone_control,
                     SAP_CONTROLS_CODE[:CG7_FULL_ZONE_CONTROL] => cg7_full_zone_control }
  end

  def ControlLevel
    return @controlLevel
  end

  def Adjustment
    return @adjustment
  end

  def lookup(controlsCode, cpsuOrIts = false, delayedStartTS = false)
    @cpsuOrIts = cpsuOrIts
    @delayedStartTS = delayedStartTS
    calculate(controlsCode)
  end

  def calculate(controlsCode)

    find(controlsCode)

    @adjustment = @tempAdjust
    if (@cpsuOrIts &&
        ((@code >= SAP_CONTROLS_CODE[:CG1_NO_CONTROLS] && @code <= SAP_CONTROLS_CODE[:CG1_ZONE_CONTROL]) ||
         (@code >= SAP_CONTROLS_CODE[:CG2_NO_CONTROLS] && @code <= SAP_CONTROLS_CODE[:CG2_ZONE_CONTROL])))
      @adjustment += -0.1
    end

    if (@delayedStartTS &&
        (@code >= SAP_CONTROLS_CODE[:CG1_NO_CONTROLS] && @code <= SAP_CONTROLS_CODE[:CG1_ZONE_CONTROL]))
      @adjustment += -0.15
    end
  end

  def find(controlCode)
     @code = controlCode
     @controlLevel = @table4eData[controlCode][1]
     @tempAdjust = @table4eData[controlCode][2]
  end

end
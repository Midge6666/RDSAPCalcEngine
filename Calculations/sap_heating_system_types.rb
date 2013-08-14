HEATING_SYSTEM_CLASS =
{
    HSC_NOT_PRESENT:        0,
    HSC_CENTRAL_HEATING:    1,
    HSC_COMMUNITY_HEATING:  2,
    HSC_STORAGE_HEATING:    3,
    HSC_ELEC_UNDERFLOOR:    4,
    HSC_WARM_AIR:           5,
    HSC_ROOM_HEATERS:       6,
    HSC_OTHER_SYSTEMS:      7,
}

SAP_FUEL_CATEGORY =
{
    FC_NONE:      0,
    FC_GAS:       1,
    FC_OIL:       2,
    FC_SOLID:     3,
    FC_ELECTRIC:  4,
    FC_MULTI:     5,
    FC_EXPORT:    6,
    FC_RENEWABLE: 7,
}

SAP_HEATING_CODES =
{
    HC_UNKNOWN:                     -1,
    HC_NONE:                        0,		# only used for secondary
    HC_ASSUMED_ELECTRIC:            699,

    HC_SEDBUK_BOILER:               10001,
    HC_SEDBUK_CHP:                  10002,
    HC_SEDBUK_HEATPUMP_BLR:         10003,
    HC_SEDBUK_HEATPUMP_WA:          10004,

    # solid fuel boilers
    HC_SFBLR_MANFEED_INTERNAL:      151,
    HC_SFBLR_MANFEED_EXTERNAL:      152,
    HC_SFBLR_AUTOFEED_INTERNAL:     153,
    HC_SFBLR_AUTOFEED_EXTERNAL:     154,
    HC_SFBLR_WOODCHIP:              155,
    HC_SFBLR_OPEN_BACKBLR_TORADS:   156,
    HC_SFBLR_CLOSED_HEATER_TORADS:  158,
    HC_SFBLR_STOVE_TORADS:          159,
    HC_SFBLR_INTEGRAL_RANGE:        160,
    HC_SFBLR_INDEPENDENT_RANGE:     161,

    # electric boilers
    HC_ELECBLR_DIRECT:              191,
    HC_ELECBLR_CPSU:                192,
    HC_ELECBLR_DRYCORE_INTERNAL:    193,
    HC_ELECBLR_DRYCORE_EXTERNAL:    194,
    HC_ELECBLR_WATER_INTERNAL:      195,
    HC_ELECBLR_WATER_EXTERNAL:      196,

    # heat-pump (boilers)
    HC_ELECHP_GROUND_TO_WATER:      201,
    HC_ELECHP_GROUND_TO_WATER_AUX:  202,
    HC_ELECHP_WATER_TO_WATER:       203,
    HC_ELECHP_AIR_TO_WATER:         204,
    HC_GASHP_GROUND_SOURCE_BOILER:  205,
    HC_GASHP_WATER_SOURCE_BOILER:   206,
    HC_GASHP_AIR_SOURCE_BOILER:     207,

    # community heating
    HC_COMMUNITY_BOILERS:           2,
    HC_COMMUNITY_CHP:               1,
    HC_COMMUNITY_WASTE_HEAT:        4,
    HC_COMMUNITY_HEATPUMP:          3,
    HC_COMMUNITY_GEOTHERMAL:        5,

    # electric storage heating
    HC_ELECSTG_OLD_LARGE_VOLUME:    401,
    HC_ELECSTG_MODERN_SLIMLINE:     402,
    HC_ELECSTG_CONVECTOR:           403,
    HC_ELECSTG_FAN:                 404,
    HC_ELECSTG_SLIMLINE_CELECT:     405,
    HC_ELECSTG_CONVECTOR_CELECT:    406,
    HC_ELECSTG_FAN_CELECT:          407,
    HC_ELECSTG_INTEGRATED:          408,

    # electric underfloor
    HC_ELECUF_CONCRETE_SLAB:        421,
    HC_ELECUF_INTEGRATED:           422,
    HC_ELECUF_INTEGRATED_TARIFF:    423,
    HC_ELECUF_INSCREED:             424,
    HC_ELECUF_INTIMBER:             425,

    # gas warmair - fan flue
    HC_GASWA_ONOFF_PRE1998_FAN:       501,
    HC_GASWA_ONOFF_MODERN_FAN:        502,
    HC_GASWA_MODULATING_PRE1998_FAN:  503,
    HC_GASWA_MODULATING_MODERN_FAN:   504,
    HC_GASWA_HEATER_WITH_DUCTS:       505,

    # gas warmair - open/balanced flue
    HC_GASWA_ONOFF_PRE1998:           506,
    HC_GASWA_ONOFF_MODERN:            507,
    HC_GASWA_MODULATING_PRE1998:		  508,
    HC_GASWA_MODULATING_MODERN:       509,
    HC_GASWA_FLUE_HEAT_RECOVERY:      510,
    HC_GASWA_CONDENSING:              511,

    # oil warmair
    HC_OILWA_DUCTED_ONOFF:            512,
    HC_OILWA_DUCTED_MODULATING:       513,
    HC_OILWA_STUB_DUCTED:             514,

    # electric warmair
    HC_ELECWA_ELECTRICARE:            515,

    # heatpumps (warmair)
    HC_ELECHP_GROUND_TO_AIR:          521,
    HC_ELECHP_GROUND_TO_AIR_AUX:      522,
    HC_ELECHP_WATER_TO_AIR:           523,
    HC_ELECHP_AIR_TO_AIR:             524,
    HC_GASHP_GROUND_SOURCE_WARMAIR:   525,
    HC_GASHP_WATER_SOURCE_WARMAIR:    526,
    HC_GASHP_AIR_SOURCE_WARMAIR:      527,

    # gas room heaters
    HC_GASRH_PRE1980_OPEN:            601,
    HC_GASRH_PRE1980_OPEN_BACKBLR:    602,
    HC_GASRH_MODERN_OPEN:             603,
    HC_GASRH_MODERN_OPEN_BACKBLR:     604,
    HC_GASRH_LIVEFUEL_OPEN:           605,
    HC_GASRH_LIVEFUEL_OPEN_BACKBLR:   606,
    HC_GASRH_LIVEFUEL_OPEN_FANFLUE:   607,
    HC_GASRH_BALANCED_FLUE:           609,
    HC_GASRH_CLOSED_FANFLUE:          610,
    HC_GASRH_CONDENSING:              611,
    HC_GASRH_DECORATIVE_TO_CHIMNEY:   612,
    HC_GASRH_FLUELESS:                613,		# secondary heating only

    # oil room heaters
    HC_OILRH_PRE2000:                 621,
    HC_OILRH_PRE2000_BACKBLR:         622,
    HC_OILRH_MODERN:                  623,
    HC_OILRH_MODERN_BACKBLR:          624,
    HC_OILRH_BIOETHANOL:              625,		# secondary heating only

    # solid fuel room heaters
    HC_SFRH_OPEN_FIRE:                631,
    HC_SFRH_OPEN_FIRE_BACKBLR:        632,
    HC_SFRH_CLOSED_HEATER:            633,
    HC_SFRH_CLOSED_HEATER_BACKBLR:    634,
    HC_SFRH_PELLET_STOVE:             635,
    HC_SFRH_PELLET_STOVE_BACKBLR:     636,

    # electric room heaters
    HC_ELECRH_PANEL_HEATERS:          691,
    HC_ELECRH_FILLED_RADS:            694,
    HC_ELECRH_FAN_HEATERS:            692,
    HC_ELECRH_PORTABLE_HEATERS:       693,

    # other heating
    HC_ELECOTHER_CEILING_HEATING:     701,

    # gas boilers (1998 or later)
    HC_GASBLR_AUTO:                   101,
    HC_GASBLR_COND_AUTO:              102,
    HC_GASBLR_COMBI_AUTO:             103,
    HC_GASBLR_COND_COMBI_AUTO:        104,
    HC_GASBLR_PERM:                   105,
    HC_GASBLR_COND_PERM:              106,
    HC_GASBLR_COMBI_PERM:             107,
    HC_GASBLR_CONDCOMBI_PERM:         108,
    HC_GASBLR_BACK_TORADS:            109,

    # gas boilers (pre-1998 with fan flues)
    HC_GASBLR_LOW_THERMAL:            110,
    HC_GASBLR_HIGH_THERMAL:           111, # includes "unknown thermal capacity"
    HC_GASBLR_COMBI_PRE1998_FAN:      112,
    HC_GASBLR_CONDCOMBI_PRE1998_FAN:  113,
    HC_GASBLR_COND_PRE1998_FAN:       114,

    # gas boilers (pre-1998 with open/balanced flues)
    HC_GASBLR_WALL_PRE1998:           115,
    HC_GASBLR_FLOOR_PRE1979:          116,
    HC_GASBLR_FLOOR_PRE1998:          117,
    HC_GASBLR_COMBI_PRE1998_OPEN:     118,
    HC_GASBLR_BACK_TORADS_PRE1998:    119,

    # gas CPSUs
    HC_GASCPSU_AUTO:                  120,

    HC_GASCPSU_CONDENSING_AUTO:       121,
    HC_GASCPSU_PILOT:                 122,
    HC_GASCPSU_CONDENSING_PILOT:      123,

    # oil boilers
    HC_OILBLR_PRE1985:                124,
    HC_OILBLR_PRE1997:                125,
    HC_OILBLR_MODERN:                 126,
    HC_OILBLR_CONDENSING:             127,
    HC_OILBLR_COMBI_PRE1998:          128,
    HC_OILBLR_COMBI:                  129,
    HC_OILBLR_CONDENSING_COMBI:       130,
    HC_OILBLR_HEATER_TORADS_PRE2000:  131,
    HC_OILBLR_HEATER_TORADS:          132,

    # gas range cooker boilers
    HC_GASRNG_SINGLE_PILOT:           133,
    HC_GASRNG_SINGLE_AUTO:            134,
    HC_GASRNG_TWIN_PILOT_PRE1998:     135,
    HC_GASRNG_TWIN_AUTO_PRE1998:      136,
    HC_GASRNG_TWIN_PILOT:             137,
    HC_GASRNG_TWIN_AUTO:              138,

    # oil range cooker boilers
    HC_OILRNG_SINGLE:                 139,
    HC_OILRNG_TWIN_PRE1998:           140,
    HC_OILRNG_TWIN:                   141,
  }

  SAP_FUELS =
  {
      F_NO_FUEL:                      0,
      F_GAS_MAINS:                    1,
      F_GAS_LNG:                      8,
      F_GAS_BULK_LPG:                 2,
      F_GAS_BOTTLED_LPG:              3,
      F_GAS_LPG_SC18:                 9,

      F_OIL:                          4,
      F_BIODIESEL_BIOMASS:            71,
      F_BIODIESEL_COOKING_OIL:        72,
      F_RAPESEED_OIL:                 73,
      F_MINERAL_OIL:                  74,
      F_B30K:                         75,
      F_BIOETHANOL:                   76,

      F_HOUSECOAL:                    11,
      F_ANTHRACITE:                   15,
      F_SMOKELESS:                    12,
      F_WOOD_LOGS:                    20,
      F_WOOD_PELLETS_BAGGED:          22,
      F_WOOD_PELLETS_BULK:            23,
      F_WOOD_CHIPS:                   21,
      F_DUAL_FUEL:                    10,

      F_ELEC_STANDARD:                30,
      F_ELEC_7HOUR_ONPEAK:            32,
      F_ELEC_7HOUR_OFFPEAK:           31,
      F_ELEC_10HOUR_ONPEAK:           34,
      F_ELEC_10HOUR_OFFPEAK:          33,
      F_ELEC_24HOUR:                  35,
      F_ELEC_SOLD:                    36,
      F_ELEC_DISPLACED:               37,
      F_ELEC_UNSPECIFIED:             39,

      F_COMMUNITY_MAINS_GAS:          51,
      F_COMMUNITY_LPG:                52,
      F_COMMUNITY_OIL:                53,
      F_COMMUNITY_B30D:               55,
      F_COMMUNITY_COAL:               54,
      F_COMMUNITY_ELEC_HEATPUMP:      41,
      F_COMMUNITY_WASTE_COMBUSTION:   42,
      F_COMMUNITY_BIOMASS:            43,
      F_COMMUNITY_BIOGAS:             44,
      F_COMMUNITY_POWERSTATION_WASTE: 45,
      F_COMMUNITY_GEOTHERMAL:         46,
      F_COMMUNITY_CHP_HEAT:           48,
      F_COMMUNITY_CHP_ELEC:           49,
      F_COMMUNITY_ELEC_DNET:          50,
  }

  # bitmask - so for example balanced fan flue = 6 (balanced | fan)
  SAP_FLUE_TYPE =
  {
      FT_NO_FLUE:     0,
      FT_OPEN:        1,
      FT_BALANCED:    2,
      FT_FAN:         4,
      FT_CHIMNEY:     8,
  }

  FLUE_OPTIONS =
  {
      FO_NONE:       0,

      FO_OPEN:       8,         #(FT_OPEN),
      FO_BALANCED:   2,         #(FT_BALANCED),
      FO_NON_FAN:    1 | 2,     #(FT_OPEN | FT_BALANCED),
      FO_FAN:        4,         #(FT_FAN),
      FO_ANY:        1 | 2 | 4, #(FT_OPEN | FT_BALANCED | FT_FAN),
      FO_CHIMNEY:    8,         #FT_CHIMNEY,
  }

  SAP_CONTROLS_CODE =
  {
      CG_INVALID_CONTROLS:      0,

      # GROUP 0
      CG0_NONE:                 2699,
      CG0_NOT_RELEVANT:         2100,

      # GROUP 1 (Boiler systems)
      CG1_NO_CONTROLS:          2101,
      CG1_PROG_ONLY:            2102,
      CG1_ROOMSTAT_ONLY:        2103,
      CG1_PROG_ROOMSTAT:        2104,
      CG1_PROG_MULTISTAT:       2105,
      CG1_PROG_ROOMSTAT_TRVS:   2106,
      CG1_TRVS_BYPASS:          2111,
      CG1_PROG_TRVS_BYPASS:     2107,
      CG1_PROG_TRVS_FLOWSWITCH: 2108,
      CG1_PROG_TRVS_BEM:        2109,
      CG1_ZONE_CONTROL:         2110,

      # GROUP 2 (Heatpumps - wet systems)
      CG2_NO_CONTROLS:          2201,
      CG2_PROG_ONLY:            2202,
      CG2_ROOMSTAT_ONLY:        2203,
      CG2_PROG_ROOMSTAT:        2204,
      CG2_PROG_MULTISTAT:       2205,
      CG2_PROG_TRVS_BYPASS:     2206,
      CG2_ZONE_CONTROL:         2207,

      # GROUP 3 (Community HeatingHeatpumps - wet systems)
      CG3_FRC_NO_CONTROLS:      2301,
      CG3_FRC_PROG_ONLY:        2302,
      CG3_FRC_ROOMSTAT_ONLY:    2303,
      CG3_FRC_PROG_ROOMSTAT:    2304,
      CG3_FRC_TRVS_ONLY:        2307,
      CG3_FRC_PROG_TRVS:        2305,
      CG3_UBC_ROOMSTAT_ONLY:    2308,
      CG3_UBC_PROG_ROOMSTAT:    2309,
      CG3_UBC_TRVS_ONLY:        2310,
      CG3_UBC_PROG_TRVS:        2306,

      # GROUP 4 (electric storage)
      CG4_MANUAL_CHARGE:        2401,
      CG4_AUTO_CHARGE:          2402,
      CG4_CELECT:               2403,

      # GROUP 5 (warm air systems - including heatpumps with warm-air distribution)
      CG5_NO_CONTROLS:          2501,
      CG5_PROG_ONLY:            2502,
      CG5_ROOMSTAT_ONLY:        2503,
      CG5_PROG_ROOMSTAT:        2504,
      CG5_PROG_MULTISTAT:       2505,
      CG5_ZONE_CONTROL:         2506,

      # GROUP 6 (room heater systems)
      CG6_NO_CONTROLS:          2601,
      CG6_APPLSTATS:            2602,
      CG6_PROG_APPLSTATS:       2603,
      CG6_ROOMSTAT_ONLY:        2604,
      CG6_PROG_ROOMSTAT:        2605,

      # GROUP 7 (other systems)
      CG7_NO_CONTROLS:          2701,
      CG7_PROG_ONLY:            2702,
      CG7_ROOMSTAT_ONLY:        2703,
      CG7_PROG_ROOMSTAT:        2704,
      CG7_TEMP_ZONE_CONTROL:    2705,
      CG7_FULL_ZONE_CONTROL:    2706,
  }

#define IS_CONTROL_GROUP0(x) (x == CG0_NONE)
#define IS_CONTROL_GROUP1(x) (x >= CG1_NO_CONTROLS   && x <= CG1_ZONE_CONTROL)
#define IS_CONTROL_GROUP2(x) (x >= CG2_NO_CONTROLS   && x <= CG2_ZONE_CONTROL)
#define IS_CONTROL_GROUP3(x) (x >= CG3_NO_CONTROLS   && x <= CG3_UBC_PROG_TRVS)
#define IS_CONTROL_GROUP4(x) (x >= CG4_MANUAL_CHARGE && x <= CG4_CELECT)
#define IS_CONTROL_GROUP5(x) (x >= CG5_NO_CONTROLS   && x <= CG5_ZONE_CONTROL)
#define IS_CONTROL_GROUP6(x) (x >= CG6_NO_CONTROLS   && x <= CG6_PROG_ROOMSTAT)
#define IS_CONTROL_GROUP7(x) (x >= CG7_NO_CONTROLS   && x <= CG7_FULL_ZONE_CONTROL)

  # combi boilers only
  KEEP_HOT_FACILITY =
  {
      KHF_NOT_COMBI:          0,
      KHF_NO_FACILITY:        1,
      KHF_NO_TIME_CONTROL:    2,
      KHF_WITH_TIME_CONTROL:  3,
  }

  KEEP_HOT_SOURCE =
  {
      KHS_NONE:           0,
      KHS_ELECTRIC:       1,
      KHS_HEATING_FUEL:   2,
  }

  COMBI_BOILER_TYPE =
  {
      CBT_NOT_COMBI:          0,
      CBT_INSTANT:            1,
      CBT_CLOSE_COUPLED:      2,
      CBT_STORAGE_PRIMARY:    3,
      CBT_STORAGE_SECONDARY:  4,
  }

  THERMAL_STORE_TYPE =
  {
      TST_NO_THERMAL_STORE: 0,
      TST_INTEGRATED:       1,
      TST_SEPARATED:        2,
  }

  SAP_EMITTER_TYPE =
  {
      SET_INTRINSIC:      0,		# i.e. storage heaters
      SET_RADIATORS:      1,
      SET_UNDERFLOOR:     2,
      SET_FAN_COIL_UNITS: 3,		# warm air option
  }

  SAP_UNDERFLOOR_PIPE_CONFIG =
  {
      UPC_NO_UNDERFLOOR_PIPES:  0,		# for radiators or fan-coil units
      UPC_TIMBER_FLOOR:         1,
      UPC_SCREED:               2,
      UPC_CONCRETE_SLAB:        3,
  }

  LOAD_COMPENSATION_TYPE =
  {
      LCT_NO_LOAD_COMPENSATION: 0,
      LCT_STANDARD:             1,
      LCT_ENHANCED:             2,
  }

  FUEL_PUMP_TYPE =
  {
      FPT_NO_FUEL_PUMP:         0,
      FPT_PUMP_UNHEATED_SPACE:  1,
      FPT_PUMP_HEATED_SPACE:    2,
  }

  STORAGE_HEATING_TYPE =
  {
      SHT_NOT_STORAGE:      0,
      SHT_FAN_ASSISTED:     1,
      SHT_STANDARD:         2,
      SHT_INTEGRATED:       3,
  }

  HEATPUMP_TYPE =
  {
      HPT_NOT_HEATPUMP:     0,
      HPT_AIR_SOURCE:       1,
      HPT_WATER_SOURCE:     2,
      HPT_GROUND_SOURCE:    3,
      HPT_GROUND_WITH_AUX:  4,
      HPT_COMMUNITY:        5,
  }

  SAP_IMMERSION_TYPE =
  {
      SIT_NOT_IMMERSION:  0,
      SIT_SINGLE:         1,
      SIT_DOUBLE:         2,
  }

  HOT_WATER_PROVISION =
  {
      HWP_NONE:           0,	# heating system is incapable of providing hot water
      HWP_INDEPENDANT:    1,	# can provide hot water independantly of heating
      HWP_WINTER:         2,	# can provide hot water while providing space heating (i.e. not in summer)
  }

  SAP_UNDER_HEATING_DEFINITION =
  {
      SUD_NOT_UNDERHEATED:        0,
      SUD_SLIGHTLY_UNDERHEATED:   1,
      SUD_SEVERELY_UNDERHEATED:   2,
  }

  HEAT_DISTRIBUTION_SYSTEM =
  {
      HDS_NOT_COMMUNITY_HEATING:  0,  # other values only applicable for community heating
      HDS_PRE1991_HIGH_TEMP:      1,	# mains piping system installed in 1990 or earlier, not pre-insulated medium or high temperature distribution (120-140oC), full flow system
      HDS_PRE1991_LOW_TEMP:       2,
      HDS_MODERN_HIGH_TEMP:       3,
      HDS_MODERN_LOW_TEMP:        4,	# modern pre-insulated piping sstem operating at 100oC or brlow, full control system installed in 1991 or later, variable flow system
      HDS_CALCULATED_LOSSES:      5,	# using calculated losses see section C3.1
  }


class SapHeatingSystemTypes
  # To change this template use File | Settings | File Templates.
end
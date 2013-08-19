SAP_HOT_WATER_SYSTEM =
{
    HWS_NONE_PRESENT:               999,
    HWS_FROM_MAIN_SYSTEM:           901,
    HWS_FROM_ALTERNATE_MAIN_SYSTEM: 914,
    HWS_FROM_SECONDARY_SYSTEM:      902,

    HWS_ELECTRIC_IMMERSION:         903,
    HWS_GAS_SINGLE_POINT:           907,		#/* instant */
    HWS_GAS_MULTI_POINT:            908,		#/* instant */
    HWS_ELECTRIC_INSTANT:           909,		#/* instant */

    HWS_GAS_CIRCULATOR:             911,
    HWS_OIL_CIRCULATOR:             912,
    HWS_SOLID_CIRCULATOR:           913,

    HWS_GAS_RANGE_SINGLE_PILOT:     921,
    HWS_GAS_RANGE_SINGLE_AUTO:      922,
    HWS_GAS_RANGE_TWIN_PILOT_PRE98: 923,
    HWS_GAS_RANGE_TWIN_AUTO_PRE98:  924,
    HWS_GAS_RANGE_TWIN_PILOT:       925,
    HWS_GAS_RANGE_TWIN_AUTO:        926,
    HWS_OIL_RANGE_SINGLE:           927,
    HWS_OIL_RANGE_TWIN_PRE98:       928,
    HWS_OIL_RANGE_TWIN_AUTO:        929,
    HWS_SOLID_RANGE_INTEGRAL:       930,
    HWS_SOLID_RANGE_INDEPENDENT:    931,

    HWS_COMMUNITY_BOILERS:          952,
    HWS_COMMUNITY_CHP:              951,
    HWS_COMMINUTY_WASTE:            954,
    HWS_COMMUNITY_HEATPUMP:         953,
    HWS_COMMUNITY_GEOTHERMAL:       955,

    HWS_FROM_SUBSTITUTED_SYSTEM:    980,
}

PRIMARY_PIPE_INSULATION =
{
    PPI_NO_PIPES:			    0,
    PPI_NO_INSULATION:		1,
    PPI_FULL_INSULATION:	2,
}

CYLINDER_INSULATION_CLASS =
{
    CIC_NONE:           0,
    CIC_LOOSE_JACKET:   1,
    CIC_SPRAY_FOAM:     2,
    CIC_INTEGRAL:       3,
}

CYLINDER_CONFIGURATION =
{
    CCT_NONE:			0,		 # no hot water cylinder
    CCT_EXTERNA:	1,		 # hot water cylinder is external to the dwelling

    CCT_INTERNAL:	2,		 # hot water cylinder is in the dwelling
    CCT_AIRING:		3,		 # hot water cylinder is in airing cupboard of the dwelling

    CCT_INTEGRAL: 4,		 # hot water cylinder is integral to the heating equipment
}

class SapWaterHeatingTypes
  # To change this template use File | Settings | File Templates.
end
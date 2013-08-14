
SAP_WALL_STRUCTURE =
{
    WS_STEEL_FRAMED:		0,
    WS_TIMBER_FRAMED:	  1,
    WS_MASONARY:        2,
}

SAP_FLOOR_STRUCTURE =
{
    FS_SUSPENDED_UNSEALED:  0,
    FS_SUSPENDED_SEALED:    1,
    FS_GROUND_OTHER:        2,
    FS_UPPER_ANY:           3,
    FS_NON_HEATLOSS:        4,
}

FABRIC_ELEMENT_TYPE =
{
    FET_DOOR:               0,
    FET_WINDOW:             1,
    FET_ROOFLIGHT:          2,

    FET_BASEMENT_FLOOR:     3,
    FET_GROUND_FLOOR:       4,
    FET_EXPOSED_FLOOR:      5,

    FET_BASEMENT_WALL:      6,
    FET_EXTERNAL_WALL:      7,

    FET_EXTERNAL_ROOF:      8,

    FET_PARTY_WALL:         9,
    FET_PARTY_FLOOR:        10,
    FET_PARTY_CEILING:      11,

    FET_INTERNAL_WALL:      12,
    FET_INTERNAL_FLOOR:     13,
    FET_INTERNAL_CEILING:   14,

    N_FABRIC_ELEMENT_TYPES: 15,
}

GLAZING_EXTENT =
{
    GE_SOLID:         0,		# i.e no glass - used for doors
    GE_SEMI_GLAZED:   1,
    GE_FULL_GLAZED:   2,
}

GLAZING_TYPES =
{
    GT_SOLID:            0,
    GT_SINGLE:           1,
    GT_DOUBLE:           2,
    GT_DOUBLE_HARD_LOWE: 3,
    GT_DOUBLE_SOFT_LOWE: 4,
    GT_SECONDARY:        5,
    GT_TRIPLE:           6,
    GT_TRIPLE_HARD_LOWE: 7,
    GT_TRIPLE_SOFT_LOWE: 8,
}

 GLAZING_FRAMES =
 {
     GF_WOOD:           0,
     GF_METAL:          1,
     GF_METAL_TBREAK:   2,
     GF_PVC_U:          3,
 }

 GLAZING_OVERSHADING =
 {
    GOS_NONE:           0,	# for rooflights
    GOS_HEAVY:          1,
    GOS_ABOVE_AVERAGE:  2,
    GOS_AVERAGE:        3,
    GOS_BELOW_AVERAGE:  4,
    GOS_VERY_LITTLE:    5,
    GOS_NOT_APPLICABLE: 6,	# for solid elements
}

GLAZING_ORIENTATION =
{
    GO_NORTH:         0,
    GO_NORTHEAST:     1,
    GO_EAST:          2,
    GO_SOUTHEAST:     3,
    GO_SOUTH:         4,
    GO_SOUTHWEST:     5,
    GO_WEST:          6,
    GO_NORTHWEST:     7,
    GO_HORIZONTAL:    8,	  # for rooflights
    GO_NOT_APPLICABLE:	9,  # for solid elements
}

GLAZING_GAPS =
{
    GG_NO_GAP:       0,
    GG_UNSPECIFIED:  1,
    GG_6MM:          6,
    GG_12MM:         12,
    GG_16MM_PLUS:    16,
}

THERMAL_BREAKS =
{
    TB_NO_BREAK:   0,
    TB_4MM:        1,
    TB_8MM:        2,
    TB_12MM:       3,
    TB_20MM:       4,
    TB_32MM:       5,
}

  SAP_VENTILATION_METHOD =
  {
    VM_EXTRACT_CENTRALISED:   3,		# extract fans throughout building (centralised duct)
    VM_EXTRACT_DECENTRALISED: 4,		# extract fans throughout building
    VM_MECHANICAL:            5,		# fully managed ventilation
    VM_MECHANICAL_WITH_HR:    6,		# as above but with heat recovery
    VM_RENWABLE_TECH:         7,		# *special case* use Appendix Q
  }

  SAP_VENTILATION_DUCTING_CONFIGURATION =
  {
    VDC_NO_MECHANICAL_VENTILATION:  0,
    VDC_UNKNOWN_CONFIGURATION:      1,
    VDC_NO_DUCTING:                 2,
    VDC_RIGID_DUCTING:              3,
    VDC_FLEXIBLE_DUCTING:           4,
  }

  SAP_VENTILATION_DUCTING_INSULATION =
  {
     VDI_NO_MECHANICAL_VENTILATION: 0,
     VDI_NO_HEAT_RECOVERY:          1,
     VDI_UNKNOWN_INSULATION:        2,
     VDI_UNINSULATED:               3,
     VDI_INSULATED:                 4,
  }

  SAP_TERRAIN_TYPE =
  {
     ST_DENSE_URBAN:  1,
     ST_SUBURBAN:     2,
     ST_RURAL:        3,
  }

  SOLAR_WATER_COLLECTOR_TYPE =
  {
     SWC_NONE:            0,
     SWC_EVACUATED_TUBE:  1,
     SWC_FLAT_PLATE:      2,
     SWC_UNGLAZED:        3,
  }

  RENEWABLE_COLLECTOR_TILT =
  {
     SWT_HORIZONTAL:  0,
     SWT_30:          1,
     SWT_45:          2,
     SWT_60:          3,
     SWT_VERTICAL:    4,
  }

  RENEWABLE_COLLECTOR_OVERSHADING =
  {
     SWO_HEAVY:       0,
     SWO_SIGNIFICANT: 1,
     SWO_MODEST:      2,
     SWO_NONE:        3,
  }

class SapStructureTypes
  # To change this template use File | Settings | File Templates.
end
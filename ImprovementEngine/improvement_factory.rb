#
# Improvement Factory
#

require File.dirname(__FILE__) + '/../General/factory'
require File.dirname(__FILE__) + '/../ImprovementEngine/measure_a2_flat_roof_insulation'
require File.dirname(__FILE__) + '/../ImprovementEngine/measure_a3_roof_room_insulation'
require File.dirname(__FILE__) + '/../ImprovementEngine/measure_a_loft_insulation'
require File.dirname(__FILE__) + '/../ImprovementEngine/measure_b_cavity_wall_insulation'
require File.dirname(__FILE__) + '/../ImprovementEngine/measure_c_hot_water_cylinder'
require File.dirname(__FILE__) + '/../ImprovementEngine/measure_d_draught_insulation'
require File.dirname(__FILE__) + '/../ImprovementEngine/measure_f_cylinder_stat'
require File.dirname(__FILE__) + '/../ImprovementEngine/measure_g_central_heating'
require File.dirname(__FILE__) + '/../ImprovementEngine/measure_h_warm_air'
require File.dirname(__FILE__) + '/../ImprovementEngine/measure_j_biomass_boiler'
require File.dirname(__FILE__) + '/../ImprovementEngine/measure_j_boiler_upgrade_same_fuel'
require File.dirname(__FILE__) + '/../ImprovementEngine/measure_k_biomass_room_heater'
require File.dirname(__FILE__) + '/../ImprovementEngine/measure_l_storage_heater'
require File.dirname(__FILE__) + '/../ImprovementEngine/measure_m_warm_air'
require File.dirname(__FILE__) + '/../ImprovementEngine/measure_n_solar_water_heating'
require File.dirname(__FILE__) + '/../ImprovementEngine/measure_o2_triple_glazing'
require File.dirname(__FILE__) + '/../ImprovementEngine/measure_o_double_glazing'
require File.dirname(__FILE__) + '/../ImprovementEngine/measure_p_secondary_glazing'
require File.dirname(__FILE__) + '/../ImprovementEngine/measure_q1_solid_wall_other_insulation'
require File.dirname(__FILE__) + '/../ImprovementEngine/measure_q2_external_cavity_insulation'
require File.dirname(__FILE__) + '/../ImprovementEngine/measure_q_solid_wall_brick_insulation'
require File.dirname(__FILE__) + '/../ImprovementEngine/measure_r_condensing_oil_boiler'
require File.dirname(__FILE__) + '/../ImprovementEngine/measure_s_condensing_gas_boiler'
require File.dirname(__FILE__) + '/../ImprovementEngine/measure_t2_F_G_H_R_S'
require File.dirname(__FILE__) + '/../ImprovementEngine/measure_t_switch_fuel_condensing_gas_boiler'
require File.dirname(__FILE__) + '/../ImprovementEngine/measure_u_photo_voltaic'
require File.dirname(__FILE__) + '/../ImprovementEngine/measure_v2_mast_wind_turbine'
require File.dirname(__FILE__) + '/../ImprovementEngine/measure_v_wind_turbine'
require File.dirname(__FILE__) + '/../ImprovementEngine/measure_w_floor_insulation'
require File.dirname(__FILE__) + '/../ImprovementEngine/measure_x_insulated_doors'
require File.dirname(__FILE__) + '/../ImprovementEngine/measure_y_W_H_R_S'
require File.dirname(__FILE__) + '/../ImprovementEngine/measure_z1_pump_alt'
require File.dirname(__FILE__) + '/../ImprovementEngine/measure_z2_ground_source_alt'
require File.dirname(__FILE__) + '/../ImprovementEngine/measure_z3_micro_chp_alt'
require File.dirname(__FILE__) + '/../ImprovementEngine/measure_z4_pump_ground_source_radiator'
require File.dirname(__FILE__) + '/../ImprovementEngine/measure_z5_pump_ground_source_underfloor_alt'

class ImprovementFactory

  @@instance = ImprovementFactory.new

  def initialize
  end

  def self.instance
    return @@instance
  end

  private_class_method :new

  def new_measure_a2_flat_roof_insulation
    return MeasureA2FlatRoofInsulation.new('A2')
  end

  def new_measure_a3_roof_room_insulation
    return MeasureA3RoofRoomInsulation.new('A3')
  end

  def new_measure_a_loft_insulation
    return MeasureALoftInsulation.new('A')
  end

  def new_measure_b_cavity_wall_insulation
    return MeasureBCavityWallInsulation.new('B')
  end

  def new_measure_c_hot_water_cylinder
    return MeasureCHotWaterCylinder.new('C')
  end

  def new_measure_d_draught_insulation
    return MeasureDDraughtInsulation.new('D')
  end

  def new_measure_f_cylinder_stat
    return MeasureFCylinderStat.new('F')
  end

  def new_measure_g_central_heating
    return MeasureGCentralHeating.new('G')
  end

  def new_measure_h_warm_air
    return MeasureHWarmAir.new('H')
  end

  def new_measure_j_biomass_boiler
    return MeasureJBiomassBoiler.new('J')
  end

  def new_measure_k_biomass_boiler
    return MeasureKBiomassRoomHeater.new('K')
  end

  def new_measure_l_storage_heater
    return MeasureLStorageHeater.new('L')
  end

  def new_measure_m_warm_air
    return MeasureMWarmAir.new('M')
  end

  def new_measure_n_solar_water_heating
    return MeasureNSolarWaterHeating.new('N')
  end

  def new_measure_o2_triple_glazing
    return MeasureO2TripleGlazing.new('O2')
  end

  def new_measure_o_double_glazing
    return MeasureODoubleGlazing.new('O')
  end

  def new_measure_p_secondary_glazing
    return MeasurePSecondaryGlazing.new('P')
  end

  def new_measure_q1_solid_wall_other_insulation
    return MeasureQ1SolidWallOtherInsulation.new('Q1')
  end

  def new_measure_q2_external_cavity_insulation
    return MeasureQ2ExternalCavityInsulation.new('Q2')
  end

  def new_measure_q_solid_wall_brick_insulation
    return MeasureQSolidWallBrickInsulation.new('Q')
  end

  def new_measure_r_condensing_oil_boiler
    return MeasureRCondensingOilBoiler.new('R')
  end

  def new_measure_s_condensing_gas_boiler
    return MeasureSCondensingGasBoiler.new('S')
  end

  def new_measure_t2_F_G_H_R_S
    return MeasureT2FGHRS.new('T2')
  end

  def new_measure_t_switch_fuel_condensing_gas_boiler
    return MeasureTSwitchFuelCondensingGasBoiler.new('T')
  end

  def new_measure_u_photo_voltaic
    return MeasureUPhotoVoltaic.new('U')
  end

  def new_measure_v2_mast_wind_turbine
    return MeasureV2MastWindTurbine.new('V2')
  end

  def new_measure_v_wind_turbine
    return MeasureVWindTurbine.new('V')
  end

  def new_measure_w_floor_insulation
    return MeasureWFloorInsulation.new('W')
  end

  def new_measure_x_insulated_doors
    return MeasureXInsulatedDoors.new('X')
  end

  def new_measure_y_W_H_R_S
    return MeasureYWHRS.new('Y')
  end

  def new_measure_z1_pump_alt
    return MeasureZ1PumpAlt.new('Z1')
  end

  def new_measure_z2_ground_source_alt
    return MeasureZ2GroundSourceAlt.new('Z2')
  end

  def new_measure_z3_micro_chp_alt
    return MeasureZ3MicroCHPAlt.new('Z3')
  end

  def new_measure_z4_pump_ground_source_radiator
    return MeasureZ4PumpGroundSourceRadiator.new('Z4')
  end

  def new_measure_z5_pump_ground_source_underfloor
    return MeasureZ5PumpGroundSourceUnderfloorAlt.new('Z5')
  end
end

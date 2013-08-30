#!/usr/bin/env ruby

require 'test/unit'
require File.dirname(__FILE__) + '/../General/factory'
require File.dirname(__FILE__) + '/../ImprovementEngine/improvement_factory'

class ImprovementFactoryTest < Test::Unit::TestCase

  def test_improvement_factory
    logger1 = ImprovementFactory.instance
    logger2 = ImprovementFactory.instance
    assert_equal logger1, logger2
    assert_equal ImprovementFactory, logger1.class
   end

  def test_get_measure_a2_flat_roof_insulation
    factory = ImprovementFactory.instance

    item = factory.new_measure_a2_flat_roof_insulation

    assert_not_equal item, NIL
    assert_equal MeasureA2FlatRoofInsulation, item.class
  end

  def test_get_measure_a3_roof_room_insulation
    factory = ImprovementFactory.instance

    item = factory.new_measure_a3_roof_room_insulation

    assert_not_equal item, NIL
    assert_equal MeasureA3RoofRoomInsulation, item.class
  end

  def test_get_measure_a_loft_insulation
    factory = ImprovementFactory.instance

    item = factory.new_measure_a_loft_insulation

    assert_not_equal item, NIL
    assert_equal MeasureALoftInsulation, item.class
  end

  def test_get_measure_b_cavity_wall_insulation
    factory = ImprovementFactory.instance

    item = factory.new_measure_b_cavity_wall_insulation

    assert_not_equal item, NIL
    assert_equal MeasureBCavityWallInsulation, item.class
  end

  def test_get_measure_c_hot_water_cylinder
    factory = ImprovementFactory.instance

    item = factory.new_measure_c_hot_water_cylinder

    assert_not_equal item, NIL
    assert_equal MeasureCHotWaterCylinder, item.class
  end

  def test_get_measure_d_draught_insulation
    factory = ImprovementFactory.instance

    item = factory.new_measure_d_draught_insulation

    assert_not_equal item, NIL
    assert_equal MeasureDDraughtInsulation, item.class
  end

  def test_get_measure_f_cylinder_stat
    factory = ImprovementFactory.instance

    item = factory.new_measure_f_cylinder_stat

    assert_not_equal item, NIL
    assert_equal MeasureFCylinderStat, item.class
  end

  def test_get_measure_g_central_heating
    factory = ImprovementFactory.instance

    item = factory.new_measure_g_central_heating

    assert_not_equal item, NIL
    assert_equal MeasureGCentralHeating, item.class
  end

  def test_get_measure_h_warm_air
    factory = ImprovementFactory.instance

    item = factory.new_measure_h_warm_air

    assert_not_equal item, NIL
    assert_equal MeasureHWarmAir, item.class
  end

  def test_get_measure_j_biomass_boiler
    factory = ImprovementFactory.instance

    item = factory.new_measure_j_biomass_boiler

    assert_not_equal item, NIL
    assert_equal MeasureJBiomassBoiler, item.class
  end

  def test_get_measure_k_biomass_room_heater
    factory = ImprovementFactory.instance

    item = factory.new_measure_k_biomass_boiler

    assert_not_equal item, NIL
    assert_equal MeasureKBiomassRoomHeater, item.class
  end

  def test_get_measure_l_storage_heater
    factory = ImprovementFactory.instance

    item = factory.new_measure_l_storage_heater

    assert_not_equal item, NIL
    assert_equal MeasureLStorageHeater, item.class
  end

  def test_get_measure_m_warm_air
    factory = ImprovementFactory.instance

    item = factory.new_measure_m_warm_air

    assert_not_equal item, NIL
    assert_equal MeasureMWarmAir, item.class
  end

  def test_get_measure_n_solar_water_heating
    factory = ImprovementFactory.instance

    item = factory.new_measure_n_solar_water_heating

    assert_not_equal item, NIL
    assert_equal MeasureNSolarWaterHeating, item.class
  end

  def test_get_measure_o2_triple_glazing
    factory = ImprovementFactory.instance

    item = factory.new_measure_o2_triple_glazing

    assert_not_equal item, NIL
    assert_equal MeasureO2TripleGlazing, item.class
  end

  def test_get_measure_o_double_glazing
    factory = ImprovementFactory.instance

    item = factory.new_measure_o_double_glazing

    assert_not_equal item, NIL
    assert_equal MeasureODoubleGlazing, item.class
  end

  def test_get_measure_p_secondary_glazing
    factory = ImprovementFactory.instance

    item = factory.new_measure_p_secondary_glazing

    assert_not_equal item, NIL
    assert_equal MeasurePSecondaryGlazing, item.class
  end

  def test_get_measure_q1_solid_wall_other_insulation
    factory = ImprovementFactory.instance

    item = factory.new_measure_q1_solid_wall_other_insulation

    assert_not_equal item, NIL
    assert_equal MeasureQ1SolidWallOtherInsulation, item.class
  end

  def test_get_measure_q2_external_cavity_insulation
    factory = ImprovementFactory.instance

    item = factory.new_measure_q2_external_cavity_insulation

    assert_not_equal item, NIL
    assert_equal MeasureQ2ExternalCavityInsulation, item.class
  end

  def test_get_measure_q_solid_wall_brick_insulation
    factory = ImprovementFactory.instance

    item = factory.new_measure_q_solid_wall_brick_insulation

    assert_not_equal item, NIL
    assert_equal MeasureQSolidWallBrickInsulation, item.class
  end

  def test_get_measure_r_condensing_oil_boiler
    factory = ImprovementFactory.instance

    item = factory.new_measure_r_condensing_oil_boiler

    assert_not_equal item, NIL
    assert_equal MeasureRCondensingOilBoiler, item.class
  end

  def test_get_measure_s_condensing_gas_boiler
    factory = ImprovementFactory.instance

    item = factory.new_measure_s_condensing_gas_boiler

    assert_not_equal item, NIL
    assert_equal MeasureSCondensingGasBoiler, item.class
  end

  def test_get_measure_t2_F_G_H_R_S
    factory = ImprovementFactory.instance

    item = factory.new_measure_t2_F_G_H_R_S

    assert_not_equal item, NIL
    assert_equal MeasureT2FGHRS, item.class
  end

  def test_get_measure_t_switch_fuel_condensing_gas_boiler
    factory = ImprovementFactory.instance

    item = factory.new_measure_t_switch_fuel_condensing_gas_boiler

    assert_not_equal item, NIL
    assert_equal MeasureTSwitchFuelCondensingGasBoiler, item.class
  end

  def test_get_measure_u_photo_voltaic
    factory = ImprovementFactory.instance

    item = factory.new_measure_u_photo_voltaic

    assert_not_equal item, NIL
    assert_equal MeasureUPhotoVoltaic, item.class
  end

  def test_get_measure_v2_mast_wind_turbine
    factory = ImprovementFactory.instance

    item = factory.new_measure_v2_mast_wind_turbine

    assert_not_equal item, NIL
    assert_equal MeasureV2MastWindTurbine, item.class
  end

  def test_get_measure_v_wind_turbine
    factory = ImprovementFactory.instance

    item = factory.new_measure_v_wind_turbine

    assert_not_equal item, NIL
    assert_equal MeasureVWindTurbine, item.class
  end

  def test_get_measure_w_floor_insulation
    factory = ImprovementFactory.instance

    item = factory.new_measure_w_floor_insulation

    assert_not_equal item, NIL
    assert_equal MeasureWFloorInsulation, item.class
  end

  def test_get_measure_x_insulated_doors
    factory = ImprovementFactory.instance

    item = factory.new_measure_x_insulated_doors

    assert_not_equal item, NIL
    assert_equal MeasureXInsulatedDoors, item.class
  end

  def test_get_measure_y_W_H_R_S
    factory = ImprovementFactory.instance

    item = factory.new_measure_y_W_H_R_S

    assert_not_equal item, NIL
    assert_equal MeasureYWHRS, item.class
  end

  def test_get_measure_z1_pump_alt
    factory = ImprovementFactory.instance

    item = factory.new_measure_z1_pump_alt

    assert_not_equal item, NIL
    assert_equal MeasureZ1PumpAlt, item.class
  end

  def test_get_measure_z2_ground_source_alt
    factory = ImprovementFactory.instance

    item = factory.new_measure_z2_ground_source_alt

    assert_not_equal item, NIL
    assert_equal MeasureZ2GroundSourceAlt, item.class
  end

  def test_get_measure_z3_micro_chp_alt
    factory = ImprovementFactory.instance

    item = factory.new_measure_z3_micro_chp_alt

    assert_not_equal item, NIL
    assert_equal MeasureZ3MicroCHPAlt, item.class
  end

  def test_get_measure_z4_pump_ground_source_radiator
    factory = ImprovementFactory.instance

    item = factory.new_measure_z4_pump_ground_source_radiator

    assert_not_equal item, NIL
    assert_equal MeasureZ4PumpGroundSourceRadiator, item.class
  end

  def test_get_measure_z5_pump_ground_source_underfloor_alt
    factory = ImprovementFactory.instance

    item = factory.new_measure_z5_pump_ground_source_underfloor

    assert_not_equal item, NIL
    assert_equal MeasureZ5PumpGroundSourceUnderfloorAlt, item.class
  end

end





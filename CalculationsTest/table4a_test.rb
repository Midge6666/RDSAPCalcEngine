#!/usr/bin/env ruby

require 'test/unit'
require File.dirname(__FILE__) + '/../General/factory'
require File.dirname(__FILE__) + '/../Calculations/calculation_factory'
require File.dirname(__FILE__) + '/../Calculations/sap_heating_system_types'

class Table4aTest < Test::Unit::TestCase

  def test_get_table4a
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4a

    assert_not_equal item, NIL
    assert_equal Table4a, item.class
  end

  def test_get_heating_system_efficiency_warm_air_pre98
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4a

    pre98 = true
    spaceHeatingInfo = calculationFactory.new_space_heating_info(HEATING_SYSTEM_CLASS[:HSC_WARM_AIR], pre98)

    assert_equal 0.65, item.look_up_efficiency(SAP_HOT_WATER_SYSTEM[:HWS_NONE_PRESENT], spaceHeatingInfo)
  end

  def test_get_heating_system_efficiency_warm_air
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4a

    pre98 = false
    spaceHeatingInfo = calculationFactory.new_space_heating_info(HEATING_SYSTEM_CLASS[:HSC_WARM_AIR], pre98)

    assert_equal 0.73, item.look_up_efficiency(SAP_HOT_WATER_SYSTEM[:HWS_NONE_PRESENT], spaceHeatingInfo)
  end

  def test_get_heating_system_efficiency_hot_water_none
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4a

    assert_equal 1.0, item.look_up_efficiency(SAP_HOT_WATER_SYSTEM[:HWS_NONE_PRESENT], NIL)
  end

  def test_get_heating_system_efficiency_hot_water_main_system
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4a

    assert_equal 1.0, item.look_up_efficiency(SAP_HOT_WATER_SYSTEM[:HWS_FROM_MAIN_SYSTEM], NIL)
  end

  def test_get_heating_system_efficiency_hot_water_gas_single_point
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4a

    assert_equal 0.7, item.look_up_efficiency(SAP_HOT_WATER_SYSTEM[:HWS_GAS_SINGLE_POINT], NIL)
  end

  def test_get_heating_system_efficiency_hot_water_gas_circulator
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4a

    assert_equal 0.65, item.look_up_efficiency(SAP_HOT_WATER_SYSTEM[:HWS_GAS_CIRCULATOR], NIL)
  end

  def test_get_heating_system_efficiency_hot_water_oil_circulator
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4a

    assert_equal 0.70, item.look_up_efficiency(SAP_HOT_WATER_SYSTEM[:HWS_OIL_CIRCULATOR], NIL)
  end

  def test_get_heating_system_efficiency_hot_water_solid_circulator
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4a

    assert_equal 0.55, item.look_up_efficiency(SAP_HOT_WATER_SYSTEM[:HWS_SOLID_CIRCULATOR], NIL)
  end

  def test_get_heating_system_efficiency_hot_water_gas_range_twin_pilot
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4a

    assert_equal 0.65, item.look_up_efficiency(SAP_HOT_WATER_SYSTEM[:HWS_GAS_RANGE_TWIN_PILOT], NIL)
  end

  def test_get_heating_system_efficiency_hot_water_community_chp
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4a

    assert_equal 0.75, item.look_up_efficiency(SAP_HOT_WATER_SYSTEM[:HWS_COMMUNITY_CHP], NIL)
  end

  def test_get_heating_system_efficiency_hot_water_community_heat_pump
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4a

    assert_equal 3.0, item.look_up_efficiency(SAP_HOT_WATER_SYSTEM[:HWS_COMMUNITY_HEATPUMP], NIL)
  end


end





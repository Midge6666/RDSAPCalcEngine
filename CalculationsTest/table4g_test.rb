#!/usr/bin/env ruby

require 'test/unit'
require File.dirname(__FILE__) + '/../General/factory'
require File.dirname(__FILE__) + '/../Calculations/calculation_factory'

class Table10Test < Test::Unit::TestCase

  def test_get_table4g
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4g

    assert_not_equal item, NIL
    assert_equal Table4g, item.class
  end

  def test_get_table4g_centralised
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4g

    assert_equal 0.8, item.get_specific_fan_power(SAP_VENTILATION_METHOD[:VM_EXTRACT_CENTRALISED])
  end

  def test_get_table4g_decentralised
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4g

    assert_equal 0.8, item.get_specific_fan_power(SAP_VENTILATION_METHOD[:VM_EXTRACT_DECENTRALISED])
  end

  def test_get_table4g_mechanical
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4g

    assert_equal 2.0, item.get_specific_fan_power(SAP_VENTILATION_METHOD[:VM_MECHANICAL])
  end

  def test_get_table4g_renewable
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4g

    assert_equal 2.0, item.get_specific_fan_power(SAP_VENTILATION_METHOD[:VM_RENWABLE_TECH])
  end

end





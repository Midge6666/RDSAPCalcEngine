#!/usr/bin/env ruby

require 'test/unit'
require File.dirname(__FILE__) + '/../General/factory'
require File.dirname(__FILE__) + '/../Calculations/calculation_factory'

class CalculationFactoryTest < Test::Unit::TestCase

  def test_calculation_factory
    logger1 = CalculationFactory.instance
    logger2 = CalculationFactory.instance
    assert_equal logger1, logger2
    assert_equal CalculationFactory, logger1.class
   end

  def test_get_appendix_g
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_appendix_g

    assert_equal AppendixG, item.class
  end

  def test_get_appendix_n
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_appendix_n

    assert_equal AppendixN, item.class
  end

  def test_get_table2
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table2

    assert_equal Table2, item.class
  end

  def test_get_table2a
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table2a

    assert_equal Table2a, item.class
  end

  def test_get_table10
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table10

    assert_equal Table10, item.class
  end

  def test_get_table4a
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4a

    assert_equal Table4a, item.class
  end

  def test_get_space_heating_info
    calculationFactory = CalculationFactory.instance

    heatingSystemClass = HEATING_SYSTEM_CLASS[:HSC_ELECTRIC_UNDERFLOOR]
    pre98 = true
    item = calculationFactory.new_space_heating_info(heatingSystemClass, pre98)

    assert_equal SpaceHeatingInfo, item.class
    assert_equal true, item.IsClass(heatingSystemClass)

    underFloorHeatingSystemClass = HEATING_SYSTEM_CLASS[:HSC_WARM_AIR]
    assert_equal false, item.IsClass(underFloorHeatingSystemClass)
    assert_equal true, item.IsPre98System
  end

end





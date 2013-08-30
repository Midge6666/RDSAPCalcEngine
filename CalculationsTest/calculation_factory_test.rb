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

  def test_get_table4a
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4a

    assert_equal Table4a, item.class
  end

  def test_get_table4d
    calculationFactory = CalculationFactory.instance

    emitterType = SAP_EMITTER_TYPE[:SET_RADIATORS]
    pipeConfig = SAP_UNDERFLOOR_PIPE_CONFIG[:UPC_TIMBER_FLOOR]
    responsiveness = 1.0
    heatingType = 1
    item = calculationFactory.new_table4d(emitterType, pipeConfig, responsiveness, heatingType)

    assert_equal Table4d, item.class
  end

  def test_get_table4e
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4e

    assert_equal Table4e, item.class
  end

  def test_get_table4g
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4g

    assert_equal Table4g, item.class
  end

  def test_get_table4h
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4h

    assert_equal Table4h, item.class
  end

  def test_get_table7
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table7

    assert_equal Table7, item.class
  end

  def test_get_table8
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table8

    assert_equal Table8, item.class
  end

  def test_get_table10
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table10

    assert_equal Table10, item.class
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


  def test_get_resultData
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_resultData(0.1, 2.3, 3.1, 4.2, 2.8, 6.7, 2.5, 3.2, 1.5, 3.2, 1.5, 2.6)

    assert_equal ResultData, item.class
  end

end





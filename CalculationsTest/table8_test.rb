#!/usr/bin/env ruby

require 'test/unit'
require File.dirname(__FILE__) + '/../General/factory'
require File.dirname(__FILE__) + '/../Calculations/calculation_factory'

class Table8Test < Test::Unit::TestCase

  def test_get_table8
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table8

    assert_not_equal item, NIL
    assert_equal Table8, item.class
  end

  def test_get_table8_external_temperature_default
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table8

    temp = item.get_external_temperature_default(MONTHS_INDEX[:JAN])
    assert_equal 4.5, temp

    temp = item.get_external_temperature_default(MONTHS_INDEX[:APRIL])
    assert_equal 8.7, temp

    temp = item.get_external_temperature_default(MONTHS_INDEX[:JULY])
    assert_equal 16.9, temp
  end

  def test_get_table8_external_temperature
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table8

    temp = item.get_external_temperature(RHI_REGION[:RHIR_THAMES], MONTHS_INDEX[:JAN])
    assert_equal 5.1, temp

    temp = item.get_external_temperature(RHI_REGION[:RHIR_BORDERS], MONTHS_INDEX[:APRIL])
    assert_equal 7.9, temp

    temp = item.get_external_temperature(RHI_REGION[:RHIR_WESTERNISLES], MONTHS_INDEX[:JULY])
    assert_equal 13.7, temp
  end

  def test_get_table8_get_values_default
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table8

    testResultData = calculationFactory.new_resultData(4.5, 5.0, 6.8, 8.7, 11.7, 14.6, 16.9, 16.9, 14.3, 10.8, 7.0, 4.9)

    results = item.get_values_default
    diff = results - testResultData.results

    assert_equal 0, diff.count
  end

  def test_get_table8_get_values_e_scotland
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table8

    testResultData = calculationFactory.new_resultData(4.1, 4.4, 5.7, 7.7, 10.6, 13.2, 15.2, 15.0, 12.7, 9.4, 6.3, 4.3)

    results = item.get_values(RHI_REGION[:RHIR_E_SCOTLAND])
    diff = results - testResultData.results

    assert_equal 0, diff.count
  end

end





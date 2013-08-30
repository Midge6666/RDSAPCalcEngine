#!/usr/bin/env ruby

require 'test/unit'
require File.dirname(__FILE__) + '/../General/factory'
require File.dirname(__FILE__) + '/../Calculations/calculation_factory'

class ResultDataTest < Test::Unit::TestCase

  def test_get_result_data
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_resultData(0.1, 2.3, 3.1, 4.2, 2.8, 6.7, 2.5, 3.2, 1.5, 3.2, 1.5, 2.6)

    assert_equal ResultData, item.class
  end

  def test_get_result_data_month_result
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_resultData(0.1, 2.3, 3.1, 4.2, 2.8, 6.7, 2.5, 3.2, 1.5, 3.2, 1.5, 2.6)

    assert_equal 0.1, item.get_month_result(MONTHS_INDEX[:JAN])
    assert_equal 6.7, item.get_month_result(MONTHS_INDEX[:JUNE])
    assert_equal 2.6, item.get_month_result(MONTHS_INDEX[:DEC])
  end

  def test_get_result_data_get_month_result
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_resultData(0.1, 2.3, 3.1, 4.2, 2.8, 6.7, 2.5, 3.2, 1.5, 3.2, 1.5, 2.6)

    assert_equal 0.1, item.get_month_result(MONTHS_INDEX[:JAN])
    assert_equal 6.7, item.get_month_result(MONTHS_INDEX[:JUNE])
    assert_equal 2.6, item.get_month_result(MONTHS_INDEX[:DEC])
  end

  def test_get_result_data_set_month_result
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_resultData(0.1, 2.3, 3.1, 4.2, 2.8, 6.7, 2.5, 3.2, 1.5, 3.2, 1.5, 2.6)
    item.set_month_result(MONTHS_INDEX[:JAN], 6.1)
    item.set_month_result(MONTHS_INDEX[:JUNE], 9.6)
    item.set_month_result(MONTHS_INDEX[:DEC], 5.4)

    assert_equal 6.1, item.get_month_result(MONTHS_INDEX[:JAN])
    assert_equal 9.6, item.get_month_result(MONTHS_INDEX[:JUNE])
    assert_equal 5.4, item.get_month_result(MONTHS_INDEX[:DEC])
  end

  def test_get_result_data_set_all_months
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_resultData(0.1, 2.3, 3.1, 4.2, 2.8, 6.7, 2.5, 3.2, 1.5, 3.2, 1.5, 2.6)
    item.set_all_months(7.7)

    assert_equal 7.7, item.get_month_result(MONTHS_INDEX[:FEB])
    assert_equal 7.7, item.get_month_result(MONTHS_INDEX[:OCT])
    assert_equal 7.7, item.get_month_result(MONTHS_INDEX[:NOV])
  end

  def test_get_result_data_additional_result
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_resultData(0.1, 2.3, 3.1, 4.2, 2.8, 6.7, 2.5, 3.2, 1.5, 3.2, 1.5, 2.6)
    additionalResult = [ 0.1, 2.3, 3.1, 4.2, 2.8, 6.7, 2.5, 3.2, 1.5, 3.2, 1.5, 2.6 ]
    item.add_result_data(additionalResult)

    assert_equal 0.2, item.get_month_result(MONTHS_INDEX[:JAN])
    assert_equal 4.6, item.get_month_result(MONTHS_INDEX[:FEB])
    assert_equal 6.2, item.get_month_result(MONTHS_INDEX[:MARCH])
    assert_equal 8.4, item.get_month_result(MONTHS_INDEX[:APRIL])
    assert_equal 5.6, item.get_month_result(MONTHS_INDEX[:MAY])
    assert_equal 13.4, item.get_month_result(MONTHS_INDEX[:JUNE])
    assert_equal 5.0, item.get_month_result(MONTHS_INDEX[:JULY])
    assert_equal 6.4, item.get_month_result(MONTHS_INDEX[:AUG])
    assert_equal 3.0, item.get_month_result(MONTHS_INDEX[:SEP])
    assert_equal 6.4, item.get_month_result(MONTHS_INDEX[:OCT])
    assert_equal 3.0, item.get_month_result(MONTHS_INDEX[:NOV])
    assert_equal 5.2, item.get_month_result(MONTHS_INDEX[:DEC])
  end

  def test_get_result_data_additional_result
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_resultData(0.1, 2.3, 3.1, 4.2, 2.8, 6.7, 2.5, 3.2, 1.5, 3.2, 1.5, 2.6)
    additionalResult = [ 0.1, 2.3, 3.1, 4.2, 2.8, 6.7, 2.5, 3.2, 1.5, 3.2, 1.5, 2.6 ]
    item.add_result_data(additionalResult)

    assert_equal 0.2, item.get_month_result(MONTHS_INDEX[:JAN])
    assert_equal 4.6, item.get_month_result(MONTHS_INDEX[:FEB])
    assert_equal 6.2, item.get_month_result(MONTHS_INDEX[:MARCH])
    assert_equal 8.4, item.get_month_result(MONTHS_INDEX[:APRIL])
    assert_equal 5.6, item.get_month_result(MONTHS_INDEX[:MAY])
    assert_equal 13.4, item.get_month_result(MONTHS_INDEX[:JUNE])
    assert_equal 5.0, item.get_month_result(MONTHS_INDEX[:JULY])
    assert_equal 6.4, item.get_month_result(MONTHS_INDEX[:AUG])
    assert_equal 3.0, item.get_month_result(MONTHS_INDEX[:SEP])
    assert_equal 6.4, item.get_month_result(MONTHS_INDEX[:OCT])
    assert_equal 3.0, item.get_month_result(MONTHS_INDEX[:NOV])
    assert_equal 5.2, item.get_month_result(MONTHS_INDEX[:DEC])
  end

  def test_get_result_data_increment_result
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_resultData(0.1, 2.3, 3.1, 4.2, 2.8, 6.7, 2.5, 3.2, 1.5, 3.2, 1.5, 2)
    item.increment_month_result(MONTHS_INDEX[:DEC], 9)

    assert_equal 11, item.get_month_result(MONTHS_INDEX[:DEC])
  end

  def test_get_result_data_calculate_year
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_resultData(1, 2.3, 3, 4, 2, 6, 2, 3, 1, 3, 1, 2)

    assert_equal 30.3, item.calc_year
  end

  def test_get_result_data_get_results
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_resultData(1, 2.3, 3, 4, 2, 6, 2, 3, 1, 3, 1, 2)

    results = item.results
    diff = [1, 2.3, 3, 4, 2, 6, 2, 3, 1, 3, 1, 2] - results

    assert_equal 0, diff.count
  end

end





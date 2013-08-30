#!/usr/bin/env ruby

require 'test/unit'
require File.dirname(__FILE__) + '/../General/factory'
require File.dirname(__FILE__) + '/../Calculations/calculation_factory'

class Table2Test < Test::Unit::TestCase

  def test_get_table7
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table7

    assert_not_equal item, NIL
    assert_equal Table7, item.class
  end

  def test_get_table7_result_data
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table7

    testResultData = calculationFactory.new_resultData( 5.4, 5.1, 5.1, 4.5, 4.1, 3.9, 3.7, 3.7, 4.2, 4.5, 4.8, 5.1)
    resultData = item.get_values

    diff = testResultData.results - resultData.results

    assert_equal 0, diff.count
  end

end





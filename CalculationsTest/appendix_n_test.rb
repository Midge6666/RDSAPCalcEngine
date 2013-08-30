#!/usr/bin/env ruby

require 'test/unit'
require File.dirname(__FILE__) + '/../General/factory'
require File.dirname(__FILE__) + '/../Calculations/calculation_factory'

class AppendixNTest < Test::Unit::TestCase

  def test_get_appendix_n
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_appendix_n

    assert_not_equal item, NIL
    assert_equal AppendixN, item.class
  end

end





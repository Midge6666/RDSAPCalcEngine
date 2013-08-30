#!/usr/bin/env ruby

require 'test/unit'
require File.dirname(__FILE__) + '/../General/factory'
require File.dirname(__FILE__) + '/../Calculations/calculation_factory'

class AppendixGTest < Test::Unit::TestCase

  def test_get_appendix_g
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_appendix_g

    assert_not_equal item, NIL
    assert_equal AppendixG, item.class
  end

end





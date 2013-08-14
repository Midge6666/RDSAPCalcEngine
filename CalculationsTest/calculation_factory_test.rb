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

end





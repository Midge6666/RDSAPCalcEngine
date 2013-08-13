#!/usr/bin/env ruby

require 'test/unit'
require File.dirname(__FILE__) + '/../General/factory'
require File.dirname(__FILE__) + '/../Application/application_factory'

class ApplicationFactoryTest < Test::Unit::TestCase

  def test_application_factory
    logger1 = ApplicationFactory.instance
    logger2 = ApplicationFactory.instance
    assert_equal logger1, logger2
    assert_equal ApplicationFactory, logger1.class
   end

  def test_get_calculation_engine
    factory = ApplicationFactory.instance
    calc = factory.new_calculation_engine

    assert_equal CalculationEngine, calc.class
   end

  def test_calculation_engine_calculate
    factory = ApplicationFactory.instance
    calc = factory.new_calculation_engine
    success = calc.calculate

    assert_equal(success, false)
  end

end

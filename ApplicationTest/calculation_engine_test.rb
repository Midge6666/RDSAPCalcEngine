#!/usr/bin/env ruby

require 'test/unit'
require File.dirname(__FILE__) + '/../General/factory'
require File.dirname(__FILE__) + '/../Application/application_factory'

class ApplicationFactoryTest < Test::Unit::TestCase


 def test_calculation_engine_calculate
    factory = ApplicationFactory.instance
    calc = factory.new_calculation_engine
    success = calc.calculate

    assert_equal(success, false)
  end

end

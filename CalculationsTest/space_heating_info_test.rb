#!/usr/bin/env ruby

require 'test/unit'
require File.dirname(__FILE__) + '/../General/factory'
require File.dirname(__FILE__) + '/../Calculations/calculation_factory'
require File.dirname(__FILE__) + '/../Calculations/sap_heating_system_types'

class SpaceHeatingInfoTest < Test::Unit::TestCase

  def test_get_space_heating_info
    calculationFactory = CalculationFactory.instance

    heatingSystem = HEATING_SYSTEM_CLASS[:HSC_STORAGE_HEATING]
    pre98 = true
    item = calculationFactory.new_space_heating_info(heatingSystem, pre98)

    assert_not_equal item, NIL
    assert_equal SpaceHeatingInfo, item.class
    assert_equal true, item.IsPre98System
  end

  def test_is_heating_system_class
    calculationFactory = CalculationFactory.instance

    heatingSystem = HEATING_SYSTEM_CLASS[:HSC_WARM_AIR]
    pre98 = false
    item = calculationFactory.new_space_heating_info(heatingSystem, pre98)

    assert_equal true, item.IsClass(heatingSystem)
    assert_equal false, item.IsPre98System
  end

end





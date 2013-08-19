#!/usr/bin/env ruby

require 'test/unit'
require File.dirname(__FILE__) + '/../General/factory'
require File.dirname(__FILE__) + '/../Calculations/calculation_factory'

class Table10Test < Test::Unit::TestCase

  def test_get_table10
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table10

    assert_not_equal item, nil
    assert_equal Table10, item.class
  end

  def test_get_rhi_for_thames_region
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table10

    region = RHI_V_REGION[:RHI_THAMES]
    assert_equal 51.5, region
  end

  def test_get_rhi_for_sw_england_region
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table10

    region = RHI_V_REGION[:RHI_SW_ENGLAND]
    assert_equal 50.6, region
  end

  def test_get_rhi_northumberland
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table10

    region = RHI_V_REGION[:RHI_NORTHERNIRELAND]
    assert_equal 54.7, region
  end


end





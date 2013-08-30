#!/usr/bin/env ruby

require 'test/unit'
require File.dirname(__FILE__) + '/../General/factory'
require File.dirname(__FILE__) + '/../Calculations/calculation_factory'

class Table2aTest < Test::Unit::TestCase

  def test_get_table2a
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table2a

    assert_not_equal item, NIL
    assert_equal Table2a, item.class
  end

  def test_get_cylinder_volume_factor
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table2a

    volume = 1
    factor = (120.0 / volume) ** (1.0 / 3.0)
    assert_equal factor, item.get_cylinder_volume_factor(volume)
  end

  def test_get_cylinder_volume_factor_non_zero
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table2a

    volume = 2
    factor = (120.0 / volume) ** (1.0 / 3.0)
    assert_equal factor, item.get_cylinder_volume_factor(volume)
  end

  def test_get_cylinder_volume_factor_has_value
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table2a

    volume = 2
    factor = (120.0 / volume) ** (1.0 / 3.0)
    item.get_cylinder_volume_factor(volume)

    assert_equal factor, item.get_cylinder_volume_factor(volume)
  end

  def test_get_cylinder_volume_factor_volume_changed
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table2a

    volume = 2
    item.get_cylinder_volume_factor(volume)

    volume = 3
    factor = (120.0 / volume) ** (1.0 / 3.0)
    assert_equal factor, item.get_cylinder_volume_factor(volume)
  end

end





#!/usr/bin/env ruby

require 'test/unit'
require File.dirname(__FILE__) + '/../General/factory'
require File.dirname(__FILE__) + '/../Calculations/calculation_factory'

class Table2Test < Test::Unit::TestCase

  def test_get_table2
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table2

    assert_not_equal item, NIL
    assert_equal Table2, item.class
  end

  def test_get_CPSU_loss_factor
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table2

    assert_equal 0.022, item.get_electric_CPSU_loss_factor
  end

  def test_get_loss_factor_insulation_none
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table2

    insulation = CYLINDER_INSULATION_CLASS[:CIC_NONE]
    thickness = 0
    assert_equal 0.1425, item.get_loss_factor(insulation, thickness)
  end

  def test_get_loss_factor_insulation_loose_jacket
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table2

    insulation = CYLINDER_INSULATION_CLASS[:CIC_LOOSE_JACKET]
    thickness = 1.0
    answer = 0.005 + (1.76 / (thickness + 12.8))
    assert_equal answer, item.get_loss_factor(insulation, thickness)
  end

  def test_get_loss_factor_insulation_spray_foam
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table2

    insulation = CYLINDER_INSULATION_CLASS[:CIC_SPRAY_FOAM]
    thickness = 2.0
    answer = 0.005 + (0.55 / (thickness + 4.0))
    assert_equal answer, item.get_loss_factor(insulation, thickness)
  end

  def test_get_loss_factor_insulation_integral
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table2

    insulation = CYLINDER_INSULATION_CLASS[:CIC_INTEGRAL]
    thickness = 2.0
    answer = 0.005 + (0.55 / (thickness + 4.0))
    assert_equal answer, item.get_loss_factor(insulation, thickness)
  end

end





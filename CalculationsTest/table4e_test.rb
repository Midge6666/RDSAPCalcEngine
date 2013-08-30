#!/usr/bin/env ruby

require 'test/unit'
require File.dirname(__FILE__) + '/../General/factory'
require File.dirname(__FILE__) + '/../Calculations/calculation_factory'

class Table10Test < Test::Unit::TestCase

  def test_get_table4e
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4e

    assert_not_equal item, NIL
    assert_equal Table4e, item.class
  end

  def test_get_table4e_prog_only
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4e
    cpsuOrIts = false
    delayedStartTS = false
    item.lookup(SAP_CONTROLS_CODE[:CG1_PROG_ONLY], cpsuOrIts, delayedStartTS)

    assert_equal 0.6, item.Adjustment
    assert_equal 1, item.ControlLevel
   end

  def test_get_table4e_cg6_applstats
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4e
    cpsuOrIts = false
    delayedStartTS = false
    item.lookup(SAP_CONTROLS_CODE[:CG6_APPLSTATS], cpsuOrIts, delayedStartTS)

    assert_equal 0.0, item.Adjustment
    assert_equal 3, item.ControlLevel
  end

  def test_get_table4e_cg1_no_controls_cpsuOrIts
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4e
    cpsuOrIts = true
    delayedStartTS = false
    item.lookup(SAP_CONTROLS_CODE[:CG1_NO_CONTROLS], cpsuOrIts, delayedStartTS)

    assert_equal 0.5, item.Adjustment
    assert_equal 1, item.ControlLevel
  end

  def test_get_table4e_cg2_roomstat_only_cpsuOrIts
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4e
    cpsuOrIts = true
    delayedStartTS = false
    item.lookup(SAP_CONTROLS_CODE[:CG2_ROOMSTAT_ONLY], cpsuOrIts, delayedStartTS)

    assert_equal -0.1, item.Adjustment
    assert_equal 1, item.ControlLevel
  end

  def test_get_table4e_cg2_roomstat_only_cpsuOrIts_delayed
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4e
    cpsuOrIts = true
    delayedStartTS = true
    item.lookup(SAP_CONTROLS_CODE[:CG2_ROOMSTAT_ONLY], cpsuOrIts, delayedStartTS)

    assert_equal -0.1, item.Adjustment
    assert_equal 1, item.ControlLevel
  end

  def test_get_table4e_cg1_no_controls_cpsuOrIts_delayed
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4e
    cpsuOrIts = true
    delayedStartTS = true
    item.lookup(SAP_CONTROLS_CODE[:CG1_NO_CONTROLS], cpsuOrIts, delayedStartTS)

    assert_equal 0.35, item.Adjustment
    assert_equal 1, item.ControlLevel
  end

end





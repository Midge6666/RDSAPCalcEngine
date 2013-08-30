#!/usr/bin/env ruby

require 'test/unit'
require File.dirname(__FILE__) + '/../General/factory'
require File.dirname(__FILE__) + '/../Calculations/calculation_factory'

class Table10Test < Test::Unit::TestCase

  def test_get_table4h
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4h

    assert_not_equal item, NIL
    assert_equal Table4h, item.class
  end


  def test_get_table4h_decentralised_flexible
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4h

    assert_equal 1.45, item.get_in_use_factor_spf(SAP_VENTILATION_METHOD[:VM_EXTRACT_DECENTRALISED],SAP_VENTILATION_DUCTING_CONFIGURATION[:VDC_FLEXIBLE_DUCTING] )
  end

  def test_get_table4h_decentralised_rigid
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4h

    assert_equal 1.30, item.get_in_use_factor_spf(SAP_VENTILATION_METHOD[:VM_EXTRACT_DECENTRALISED],SAP_VENTILATION_DUCTING_CONFIGURATION[:VDC_RIGID_DUCTING] )
  end

  def test_get_table4h_decentralised_no_ducting
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4h

    assert_equal 1.15, item.get_in_use_factor_spf(SAP_VENTILATION_METHOD[:VM_EXTRACT_DECENTRALISED],SAP_VENTILATION_DUCTING_CONFIGURATION[:VDC_NO_DUCTING] )
  end

  def test_get_table4h_decentralised_other
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4h

    assert_equal 1.45, item.get_in_use_factor_spf(SAP_VENTILATION_METHOD[:VM_EXTRACT_DECENTRALISED],SAP_VENTILATION_DUCTING_CONFIGURATION[:VDC_NO_MECHANICAL_VENTILATION] )
  end

  def test_get_table4h_positive_flexible
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4h

    assert_equal 1.70, item.get_in_use_factor_spf(SAP_VENTILATION_METHOD[:VM_POSITIVE_INPUT_EXTERNAL],SAP_VENTILATION_DUCTING_CONFIGURATION[:VDC_FLEXIBLE_DUCTING] )
  end

  def test_get_table4h_centralised_rigid
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4h

    assert_equal 1.40, item.get_in_use_factor_spf(SAP_VENTILATION_METHOD[:VM_EXTRACT_CENTRALISED],SAP_VENTILATION_DUCTING_CONFIGURATION[:VDC_RIGID_DUCTING] )
  end

  def test_get_table4h_centralised_unknown_config
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_table4h

    assert_equal 1.70, item.get_in_use_factor_spf(SAP_VENTILATION_METHOD[:VM_EXTRACT_CENTRALISED],SAP_VENTILATION_DUCTING_CONFIGURATION[:VDC_UNKNOWN_CONFIGURATION] )
  end

end





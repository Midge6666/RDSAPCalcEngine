#!/usr/bin/env ruby

require 'test/unit'
require File.dirname(__FILE__) + '/../General/factory'
require File.dirname(__FILE__) + '/../Calculations/calculation_factory'

class Table4dTest < Test::Unit::TestCase

  def test_get_table4d
    calculationFactory = CalculationFactory.instance

    emitterType = SAP_EMITTER_TYPE[:SET_RADIATORS]
    pipeConfig = SAP_UNDERFLOOR_PIPE_CONFIG[:UPC_TIMBER_FLOOR]
    responsiveness = 1.0
    heatingType = 1
    item = calculationFactory.new_table4d(emitterType, pipeConfig, responsiveness, heatingType)

    assert_equal Table4d, item.class
  end

  def test_get_table4d_responsiveness_heatingType
    calculationFactory = CalculationFactory.instance

    emitterType = SAP_EMITTER_TYPE[:SET_RADIATORS]
    pipeConfig = SAP_UNDERFLOOR_PIPE_CONFIG[:UPC_TIMBER_FLOOR]
    responsiveness = 1.0
    heatingType = 1
    item = calculationFactory.new_table4d(emitterType, pipeConfig, responsiveness, heatingType)

    item.calculate
    assert_equal SAP_EMITTER_TYPE[:SET_RADIATORS], item.EmitterType
  end

  def test_get_table4d_responsiveness_heatingType_radiators
    calculationFactory = CalculationFactory.instance

    emitterType = SAP_EMITTER_TYPE[:SET_RADIATORS]
    pipeConfig = SAP_UNDERFLOOR_PIPE_CONFIG[:UPC_TIMBER_FLOOR]
    responsiveness = 1.0
    heatingType = 1
    item = calculationFactory.new_table4d(emitterType, pipeConfig, responsiveness, heatingType)

    item.calculate
    assert_equal SAP_EMITTER_TYPE[:SET_RADIATORS], item.EmitterType
    assert_equal SAP_UNDERFLOOR_PIPE_CONFIG[:UPC_TIMBER_FLOOR], item.PipeConfig
    assert_equal 1.0, item.Responsiveness
    assert_equal 1, item.HeatingType
  end

  def test_get_table4d_responsiveness_heatingType_fan_coil
    calculationFactory = CalculationFactory.instance

    emitterType = SAP_EMITTER_TYPE[:SET_FAN_COIL_UNITS]
    pipeConfig = SAP_UNDERFLOOR_PIPE_CONFIG[:UPC_TIMBER_FLOOR]
    responsiveness = 1.0
    heatingType = 1
    item = calculationFactory.new_table4d(emitterType, pipeConfig, responsiveness, heatingType)

    item.calculate
    assert_equal SAP_EMITTER_TYPE[:SET_FAN_COIL_UNITS], item.EmitterType
    assert_equal SAP_UNDERFLOOR_PIPE_CONFIG[:UPC_TIMBER_FLOOR], item.PipeConfig
    assert_equal 1.0, item.Responsiveness
    assert_equal 1, item.HeatingType
  end

  def test_get_table4d_responsiveness_heatingType_under_floor_timber_floor
    calculationFactory = CalculationFactory.instance

    emitterType = SAP_EMITTER_TYPE[:SET_UNDERFLOOR]
    pipeConfig = SAP_UNDERFLOOR_PIPE_CONFIG[:UPC_TIMBER_FLOOR]
    responsiveness = 1.0
    heatingType = 1
    item = calculationFactory.new_table4d(emitterType, pipeConfig, responsiveness, heatingType)

    item.calculate
    assert_equal SAP_EMITTER_TYPE[:SET_UNDERFLOOR], item.EmitterType
    assert_equal SAP_UNDERFLOOR_PIPE_CONFIG[:UPC_TIMBER_FLOOR], item.PipeConfig
    assert_equal 1.0, item.Responsiveness
    assert_equal 1, item.HeatingType
  end

  def test_get_table4d_responsiveness_heatingType_under_floor_screed
    calculationFactory = CalculationFactory.instance

    emitterType = SAP_EMITTER_TYPE[:SET_UNDERFLOOR]
    pipeConfig = SAP_UNDERFLOOR_PIPE_CONFIG[:UPC_SCREED]
    responsiveness = 1.0
    heatingType = 1
    item = calculationFactory.new_table4d(emitterType, pipeConfig, responsiveness, heatingType)

    item.calculate
    assert_equal SAP_EMITTER_TYPE[:SET_UNDERFLOOR], item.EmitterType
    assert_equal SAP_UNDERFLOOR_PIPE_CONFIG[:UPC_SCREED], item.PipeConfig
    assert_equal 0.75, item.Responsiveness
    assert_equal 2, item.HeatingType
  end

  def test_get_table4d_responsiveness_heatingType_under_floor_concrete_slab
    calculationFactory = CalculationFactory.instance

    emitterType = SAP_EMITTER_TYPE[:SET_UNDERFLOOR]
    pipeConfig = SAP_UNDERFLOOR_PIPE_CONFIG[:UPC_CONCRETE_SLAB]
    responsiveness = 1.0
    heatingType = 1
    item = calculationFactory.new_table4d(emitterType, pipeConfig, responsiveness, heatingType)

    item.calculate
    assert_equal SAP_EMITTER_TYPE[:SET_UNDERFLOOR], item.EmitterType
    assert_equal SAP_UNDERFLOOR_PIPE_CONFIG[:UPC_CONCRETE_SLAB], item.PipeConfig
    assert_equal 0.25, item.Responsiveness
    assert_equal 4, item.HeatingType
  end


end





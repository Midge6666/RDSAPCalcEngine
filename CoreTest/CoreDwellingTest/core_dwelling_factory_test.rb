#!/usr/bin/env ruby

require 'test/unit'
require File.dirname(__FILE__) + '/../../General/factory'
require File.dirname(__FILE__) + '/../../Core/CoreDwelling/core_dwelling_factory'


class CalculationFactoryTest < Test::Unit::TestCase

  def test_core_dwelling_factory
    logger1 = CoreDwellingFactory.instance
    logger2 = CoreDwellingFactory.instance
    assert_equal logger1, logger2
    assert_equal CoreDwellingFactory, logger1.class
  end

  def test_get_dwelling
    coreFactory = CoreDwellingFactory.instance

    item = coreFactory.new_dwelling

    assert_not_equal item, nil
  end

  def test_get_building_envelope
    coreFactory = CoreDwellingFactory.instance

    groundFloorInsulated = true
    item = coreFactory.new_building_envelope(groundFloorInsulated)

    assert_not_equal item, nil
    assert_equal BuildingEnvelope, item.class
  end

  def test_get_floor
    coreFactory = CoreDwellingFactory.instance

    item = coreFactory.new_floor

    assert_not_equal item, nil
    assert_equal Floor, item.class
  end

  def test_get_roof
    coreFactory = CoreDwellingFactory.instance

    item = coreFactory.new_roof

    assert_not_equal item, nil
    assert_equal Roof, item.class
  end

  def test_get_heating_system
    coreFactory = CoreDwellingFactory.instance

    item = coreFactory.new_heating_system

    assert_not_equal item, nil
    assert_equal HeatingSystem, item.class
  end

  def test_get_primary_heating
    coreFactory = CoreDwellingFactory.instance

    item = coreFactory.new_primary_heating

    assert_not_equal item, nil
    assert_equal PrimaryHeating, item.class
  end

  def test_get_secondary_heating
    coreFactory = CoreDwellingFactory.instance

    item = coreFactory.new_secondary_heating

    assert_not_equal item, nil
    assert_equal SecondaryHeating, item.class
  end

end





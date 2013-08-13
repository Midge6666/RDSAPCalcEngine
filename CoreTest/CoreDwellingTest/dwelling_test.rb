#!/usr/bin/env ruby

require 'test/unit'
require File.dirname(__FILE__) + '/../../General/factory'
require File.dirname(__FILE__) + '/../../Core/CoreDwelling/core_dwelling_factory'


class DwellingTest < Test::Unit::TestCase

  def test_dwelling_envelope
    coreDwellingFactory = CoreDwellingFactory.instance
    dwelling = coreDwellingFactory.new_dwelling

    envelope = coreDwellingFactory.new_building_envelope(true)
    envelope1 = coreDwellingFactory.new_building_envelope(false)

    dwelling.add_building_envelope(envelope)
    dwelling.add_building_envelope(envelope1)

    count = 0
    dwelling.each do |a|
      assert_equal(envelope, a) if count == 0
      assert_equal(envelope1, a) if count == 1
      count += 1
    end

    assert dwelling.include?(envelope)
    assert dwelling.include?(envelope1)

    assert dwelling.any?{|t| t.groundFloorInsulated == true}
    assert dwelling.any?{|t| t.groundFloorInsulated == false}

  end

end





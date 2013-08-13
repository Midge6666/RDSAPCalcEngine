#!/usr/bin/env ruby

require 'test/unit'
require File.dirname(__FILE__) + '/../General/factory'


class FactoryTest < Test::Unit::TestCase

  def test_singleton
    logger1 = Factory.instance
    logger2 = Factory.instance
    assert_equal logger1, logger2
    assert_equal Factory, logger1.class
  end

end





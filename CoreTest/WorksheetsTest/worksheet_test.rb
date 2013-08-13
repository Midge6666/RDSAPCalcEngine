#!/usr/bin/env ruby

require 'test/unit'
require File.dirname(__FILE__) + '/../../Core/Worksheets/worksheets_factory'
require File.dirname(__FILE__) + '/../../Core/Worksheets/worksheet_a'
require File.dirname(__FILE__) + '/../../Core/Worksheets/worksheet_result'

class WorksheetsTest < Test::Unit::TestCase

  def test_worksheet_creation
    factory = WorksheetsFactory.instance

    sheet = factory.new_worksheet_a
    worksheets = factory.new_worksheets(sheet)

    assert_equal CompositeCommand, worksheets.class
  end

  def test_worksheet_worksheet_a
    factory = WorksheetsFactory.instance

    sheet = factory.new_worksheet_a
    worksheets = factory.new_worksheets(sheet)

    assert_equal CompositeCommand, worksheets.class
  end

  def test_worksheet_executes
    factory = WorksheetsFactory.instance

    item = factory.new_worksheet_a
    worksheets = factory.new_worksheets(item)

    success = worksheets.execute
    assert_equal(success, false)
  end

end





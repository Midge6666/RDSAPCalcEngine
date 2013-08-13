#!/usr/bin/env ruby

require 'test/unit'
require File.dirname(__FILE__) + '/../../General/factory'
require File.dirname(__FILE__) + '/../../Core/Worksheets/worksheets_factory'

class WorksheetsFactoryTest < Test::Unit::TestCase

  def test_core_dwelling_factory
    logger1 = WorksheetsFactory.instance
    logger2 = WorksheetsFactory.instance
    assert_equal logger1, logger2
    assert_equal WorksheetsFactory, logger1.class
  end

  def test_get_work_sheet_result
    factory = WorksheetsFactory.instance

    item = factory.new_worksheet_result('Heating')

    assert_not_equal item, nil
    assert_equal WorksheetResult, item.class
  end

  def test_get_work_sheet
    factory = WorksheetsFactory.instance

    item = factory.new_worksheet("dummy")

    assert_not_equal item, nil
    assert_equal Worksheet, item.class
  end

  def test_get_work_sheet_a
    factory = WorksheetsFactory.instance

    item = factory.new_worksheet_a

    assert_not_equal item, nil
    assert_equal WorksheetA, item.class
  end

  def test_get_work_sheets
    factory = WorksheetsFactory.instance

    item = factory.new_worksheet_a
    worksheets = factory.new_worksheets(item)

    assert_not_equal worksheets, nil
    assert_equal CompositeCommand, worksheets.class
  end

end





#!/usr/bin/env ruby

require 'test/unit'
require File.dirname(__FILE__) + '/../../General/factory'
require File.dirname(__FILE__) + '/../../Core/Worksheets/worksheets_factory'
require File.dirname(__FILE__) + '/../../Core/Worksheets/worksheet_result'

class WorksheetResultTest < Test::Unit::TestCase

  def test_worksheet_result_creation
    factory = WorksheetsFactory.instance

    worksheet = factory.new_worksheet_result('Heating')

    assert_equal worksheet.description, 'Heating'
   end

end





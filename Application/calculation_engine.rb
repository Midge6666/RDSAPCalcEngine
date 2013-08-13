require File.dirname(__FILE__) + '/../Core/Worksheets/worksheets_factory'

class CalculationEngine

  attr_accessor :worksheets

  def initialize
    factory = WorksheetsFactory.instance
    worksheet_a = factory.new_worksheet_a
    @worksheets = factory.new_worksheets(worksheet_a)
  end

  def calculate
    @worksheets.execute
  end
end

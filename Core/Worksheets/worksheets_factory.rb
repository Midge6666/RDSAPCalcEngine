require File.dirname(__FILE__) + '/../../General/factory'
require File.dirname(__FILE__) + '/../../General/composite_command'
require File.dirname(__FILE__) + '/../../Core/Worksheets/worksheet'
require File.dirname(__FILE__) + '/../../Core/Worksheets/worksheet_a'
require File.dirname(__FILE__) + '/../../Core/Worksheets/worksheet_result'

class WorksheetsFactory

  @@instance = WorksheetsFactory.new

  def initialize
  end

  def self.instance
    return @@instance
  end

  private_class_method :new

  def new_worksheets(worksheetA)
    worksheets = CompositeCommand.new
    worksheets.add_command(worksheetA)
    return worksheets
  end

  def new_worksheet(name)
    return Worksheet.new(name)
  end

  def new_worksheet_a
    return WorksheetA.new
  end

  def new_worksheet_result(description)
    return WorksheetResult.new(description)
  end
end

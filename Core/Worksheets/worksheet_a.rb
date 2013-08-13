require File.dirname(__FILE__) + '/../../Core/Worksheets/worksheet'

class WorksheetA < Worksheet
  include Enumerable

  def initialize
    super('WorksheetA')
  end

  def execute
    super.execute
  end

end

require File.dirname(__FILE__) + '/../Application/calculation_engine'

class ApplicationFactory

  @@instance = ApplicationFactory.new

  def self.instance
    return @@instance
  end

  private_class_method :new

  def initialize
    @name = 'ApplicationFactory'

    @worksheets = CompositeCommand.new
  end

  def new_calculation_engine
    return CalculationEngine.new
  end

end

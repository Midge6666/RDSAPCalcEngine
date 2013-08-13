#
# Calculation Factory
#

require File.dirname(__FILE__) + '/../General/factory'
require File.dirname(__FILE__) + '/../Calculations/appendix_g'
require File.dirname(__FILE__) + '/../Calculations/appendix_n'

class CalculationFactory

  @@instance = CalculationFactory.new

  def self.instance
     return @@instance
  end

  private_class_method :new

  def initialize
  end

  def new_appendix_g
    return AppendixG.new
  end

  def new_appendix_n
    return AppendixN.new
  end
end

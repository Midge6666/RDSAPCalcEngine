#
# Calculation Factory
#

require File.dirname(__FILE__) + '/../General/factory'
require File.dirname(__FILE__) + '/../Calculations/appendix_g'
require File.dirname(__FILE__) + '/../Calculations/appendix_n'
require File.dirname(__FILE__) + '/../Calculations/table2'
require File.dirname(__FILE__) + '/../Calculations/Table2a'

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

  def new_table2
    return Table2.new
  end

  def new_table2a
    return Table2a.new
  end
end

#
# Calculation Factory
#

require File.dirname(__FILE__) + '/../General/factory'
require File.dirname(__FILE__) + '/../Calculations/appendix_g'
require File.dirname(__FILE__) + '/../Calculations/appendix_n'
require File.dirname(__FILE__) + '/../Calculations/table2'
require File.dirname(__FILE__) + '/../Calculations/Table2a'
require File.dirname(__FILE__) + '/../Calculations/Table4a'
require File.dirname(__FILE__) + '/../Calculations/Table4d'
require File.dirname(__FILE__) + '/../Calculations/Table4e'
require File.dirname(__FILE__) + '/../Calculations/Table4g'
require File.dirname(__FILE__) + '/../Calculations/Table4h'
require File.dirname(__FILE__) + '/../Calculations/Table7'
require File.dirname(__FILE__) + '/../Calculations/Table8'
require File.dirname(__FILE__) + '/../Calculations/Table10'
require File.dirname(__FILE__) + '/../Calculations/space_heating_info'
require File.dirname(__FILE__) + '/../Calculations/sap_heating_system_types'
require File.dirname(__FILE__) + '/../Calculations/sap_structure_types'
require File.dirname(__FILE__) + '/../Calculations/sap_water_heating_types'
require File.dirname(__FILE__) + '/../Calculations/result_data'

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

  def new_table4a
    return Table4a.new
  end

  def new_table4d(emitterType, pipeConfig, responsiveness, heatingType)
    return Table4d.new(emitterType, pipeConfig, responsiveness, heatingType)
  end

  def new_table4e
    return Table4e.new
  end

  def new_table4g
    return Table4g.new
  end

  def new_table4h
    return Table4h.new
  end

  def new_table7
    return Table7.new
  end

  def new_table8
    return Table8.new
  end

  def new_table10
    return Table10.new
  end

  def new_resultData(jan, feb, march, april, may, june, july, aug, sep, oct, nov, dec)
    return ResultData.new(jan, feb, march, april, may, june, july, aug, sep, oct, nov, dec)
  end

  def new_space_heating_info(heatingSystemClass, pre98)
    return SpaceHeatingInfo.new(heatingSystemClass, pre98)
  end
end

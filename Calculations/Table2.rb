
require File.dirname(__FILE__) + '/../Calculations/sap_water_heating_types'

class Table2
  # To change this template use File | Settings | File Templates.
  def initialize
  end

  def get_loss_factor(insulation, thickness)

    lossFactor = 0
    if (insulation == CYLINDER_INSULATION_CLASS[:CIC_NONE])

        lossFactor = 0.1425

    elsif (insulation == CYLINDER_INSULATION_CLASS[:CIC_LOOSE_JACKET])

      lossFactor = calculate_jacket_loss_factor(thickness)

    elsif (insulation == CYLINDER_INSULATION_CLASS[:CIC_SPRAY_FOAM] ||
           insulation == CYLINDER_INSULATION_CLASS[:CIC_INTEGRAL])

      lossFactor = calculate_factory_loss_factor(thickness)
    end

      return lossFactor
  end

  def get_electric_CPSU_loss_factor
      return (0.022)
  end

  def calculate_jacket_loss_factor(thickness)
      return (0.005 + (1.76 / (thickness + 12.8)))
  end

  def calculate_factory_loss_factor(thickness)
      return(0.005 + (0.55 / (thickness + 4.0)))
  end
end
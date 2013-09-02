class Table6d
  def get_winter_access_factor(os)
    winterSolar = 0.0
    case os
      when GOS_HEAVY
        winterSolar = 0.30
        break
      when GOS_ABOVE_AVERAGE
        winterSolar = 0.54
        break
      when GOS_AVERAGE
        winterSolar = 0.77
        break
      when GOS_VERY_LITTLE
        winterSolar = 1.00
        break
      else
    end
    # TODO: Validation error
    return (winterSolar)
  end

  def get_summer_access_factor(os)
    case os
      when GOS_HEAVY
        summerSolar = 0.5
        break
      when GOS_ABOVE_AVERAGE
        summerSolar = 0.7
        break
      when GOS_AVERAGE
        summerSolar = 0.9
        break
      when GOS_VERY_LITTLE
        summerSolar = 1.0
        break
      else
    end
    # TODO: Validation error
    return (summerSolar)
  end

  def get_light_access_factor(os)
    lightFactor = 0.0
    case os
      when GOS_HEAVY
        lightFactor = 0.50
        break
      when GOS_ABOVE_AVERAGE
        lightFactor = 0.67
        break
      when GOS_AVERAGE
        lightFactor = 0.83
        break
      when GOS_VERY_LITTLE
        lightFactor = 1.00
        break
      else
    end
    # TODO: Validation error
    return (lightFactor)
  end

  def initialize()
  end
end
class Table6b
  def get_solar_energy_transmittance(type)
    solar = 0.0
    case type
      when GT_SINGLE
        solar = 0.85
        break
      when GT_DOUBLE
        solar = 0.76
        break
      when GT_DOUBLE_HARD_LOWE
        solar = 0.72
        break
      when GT_DOUBLE_SOFT_LOWE
        solar = 0.63
        break
      when GT_SECONDARY
        solar = 0.76
        break
      when GT_TRIPLE
        solar = 0.68
        break
      when GT_TRIPLE_HARD_LOWE
        solar = 0.64
        break
      when GT_TRIPLE_SOFT_LOWE
        solar = 0.57
        break
      when GT_SOLID
        solar = 0.0
        break
      else
    end
    # TODO: validation failure
    # apply normal incidence conversion (see footnote 1)
    # return(solar * 0.9); // this caused the lighting gains calc to go wrong.  I think the 0.9 factor is also included in section 6
    return solar
  end

  def get_light_transmittance(type)
    light = 0.0
    case type
      when GT_SINGLE
        light = 0.90
        break
      when GT_DOUBLE
        light = 0.80
        break
      when GT_DOUBLE_HARD_LOWE
        light = 0.80
        break
      when GT_DOUBLE_SOFT_LOWE
        light = 0.80
        break
      when GT_SECONDARY
        light = 0.80
        break
      when GT_TRIPLE
        light = 0.70
        break
      when GT_TRIPLE_HARD_LOWE
        light = 0.70
        break
      when GT_TRIPLE_SOFT_LOWE
        light = 0.70
        break
      else
    end
    # TODO: validation failure
    # apply normal incidence conversion (see footnote 1)
    #return(light * 0.9); // this caused the lighting gains calc to go wrong.  I think the 0.9 factor is also included in the Appendix L5
    return light
  end
end
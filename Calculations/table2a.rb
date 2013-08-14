class Table2a
  # To change this template use File | Settings | File Templates.
  @factor = 0
  @volume = 0

  def get_cylinder_volume_factor(v)
    if (@volume == v)
      return @factor
    end

    @volume = v
    @factor =  (120.0 / @volume) ** (1.0 / 3.0)

    return @factor
  end

end
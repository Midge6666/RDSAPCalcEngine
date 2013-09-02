class Table6c
  def initialize()
  end

  def get_frame_factor(frame)
    factor = 0.0
    case frame
      when GF_WOOD
        factor = 0.7
        break
      when GF_METAL
        factor = 0.8
        break
      when GF_METAL_TBREAK
        factor = 0.8
        break
      when GF_PVC_U
        factor = 0.7
        break
      else
    end
    # TODO: validation fail
    return (factor)
  end

end
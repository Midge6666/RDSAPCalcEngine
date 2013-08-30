class Table4d
  # To change this template use File | Settings | File Templates.
  @emitterType
  @pipeConfig
  @responsiveness
  @heatingType

  def initialize
  end

  def initialize(emitterType, pipeConfig, responsiveness, heatingType)
    @emitterType = emitterType
    @pipeConfig = pipeConfig
    @responsiveness = responsiveness
    @heatingType = heatingType
  end

  def HeatingType
    return @heatingType
  end

  def PipeConfig
    return @pipeConfig
  end

  def Responsiveness
    return @responsiveness
  end

  def EmitterType
    return @emitterType
  end

  def calculate
    if (@emitterType == SAP_EMITTER_TYPE[:SET_RADIATORS] || @emitterType == SAP_EMITTER_TYPE[:SET_FAN_COIL_UNITS])
      @responsiveness = 1.0
      @heatingType = 1
    elsif (@emitterType == SAP_EMITTER_TYPE[:SET_UNDERFLOOR])
      if (@pipeConfig == SAP_UNDERFLOOR_PIPE_CONFIG[:UPC_TIMBER_FLOOR])
        @heatingType = 1
        @responsiveness = 1.0
      elsif (@pipeConfig == SAP_UNDERFLOOR_PIPE_CONFIG[:UPC_SCREED])
        @heatingType = 2
        @responsiveness = 0.75
      elsif (@pipeConfig == SAP_UNDERFLOOR_PIPE_CONFIG[:UPC_CONCRETE_SLAB])
        @heatingType = 4
        @responsiveness = 0.25
      end
    end
  end

end
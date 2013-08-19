class SpaceHeatingInfo
  # To change this template use File | Settings | File Templates.
  @heatingSystem
  @pre98

  def initialize
  end

  def initialize(heatingSystem, pre98)
    @heatingSystem = heatingSystem
    @pre98 = pre98
  end

  def IsClass(heatingSystem)
    isClass = false

    if (heatingSystem == @heatingSystem)
      isClass = true
    end

    return isClass
  end

  def IsPre98System
    return @pre98
  end
end
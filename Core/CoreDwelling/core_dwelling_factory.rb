#
# Core Dwelling Factory
#

require File.dirname(__FILE__) + '/../../General/factory'
require File.dirname(__FILE__) + '/../../Core/CoreDwelling/dwelling'

require File.dirname(__FILE__) + '/../../Core/CoreDwelling/heating_system'
require File.dirname(__FILE__) + '/../../Core/CoreDwelling/primary_heating'
require File.dirname(__FILE__) + '/../../Core/CoreDwelling/secondary_heating'
require File.dirname(__FILE__) + '/../../Core/CoreDwelling/floor'
require File.dirname(__FILE__) + '/../../Core/CoreDwelling/roof'
require File.dirname(__FILE__) + '/../../Core/CoreDwelling/building_envelope'

class CoreDwellingFactory

  @@instance = CoreDwellingFactory.new

  def initialize
  end

  def self.instance
    return @@instance
  end

  private_class_method :new

  def new_dwelling
    return Dwelling.new
  end
  def new_building_envelope(groundFloorInsulated)
    return BuildingEnvelope.new(groundFloorInsulated)
  end
  def new_floor
    return Floor.new
  end
  def new_roof
    return Roof.new
  end
  def new_heating_system
    return HeatingSystem.new
  end
  def new_primary_heating
    return PrimaryHeating.new
  end
  def new_secondary_heating
    return SecondaryHeating.new
  end
end

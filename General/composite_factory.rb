#
# A composite factory.
#
class CompositeFactory < Factory
  def initialize
    @factories = []
  end

  def add_factory(factory)
    @factories << factory
  end
end
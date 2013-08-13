class Dwelling
  include Enumerable

  def initialize
    @envelopes = []
  end

  def each(&block)
    @envelopes.each(&block)
  end

  def add_building_envelope(envelope)
    @envelopes << envelope
  end
end
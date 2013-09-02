class FieldController
  # To change this template use File | Settings | File Templates.

  @@connected = []

  @@rules = []

  @@hash = []

  def initialize
  end

  # override function for fields which can update a group, increment, decrement
  def update_group(increment)
  end
end
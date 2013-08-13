require 'fileutils'

class Command 
  attr_reader :description

  def initialize(description)
    @description = description
  end

  def execute
    false
  end
end


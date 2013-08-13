
#require 'singleton'

class Factory
  attr_accessor :name

  @@instance = Factory.new

  def initialize
  end

	def self.instance
		return @@instance
	end
	
	private_class_method :new
end
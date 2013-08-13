#
# A composite command.
#

require File.dirname(__FILE__) + '/../General/command'

class CompositeCommand < Command
  def initialize
    @commands = []
  end

  def add_command(cmd)
    @commands << cmd
  end

  def execute
    success = false
    @commands.each {|cmd| success = cmd.execute}
    return success
  end

  def description
    description = ''
    @commands.each {|cmd| description += cmd.description + "\n"}
    description
  end
end


require File.dirname(__FILE__) + '/../General/command'

class DeleteFileCommand < Command
  def initialize(path)
    super("Delete file: #{path}")
    @path = path
  end

  def execute
    File.delete(@path)
  end
end
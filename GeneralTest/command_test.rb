#!/usr/bin/env ruby

require 'test/unit'
require File.dirname(__FILE__) + '/../General/command'
require File.dirname(__FILE__) + '/../General/composite_command'
require File.dirname(__FILE__) + '/../General/copy_file_command'
require File.dirname(__FILE__) + '/../General/create_file_command'
require File.dirname(__FILE__) + '/../General/delete_file_command'

#require 'ex4_file_cmd'

class FileCommandTest < Test::Unit::TestCase

  NEW_FILE = File.dirname(__FILE__) + '/../GeneralTest/new_test_file.txt'
  EXISTING_FILE = File.dirname(__FILE__) + '/../GeneralTest/existing_test_file.txt'
  
  def setup
    File.delete(NEW_FILE) if File.exists?(NEW_FILE)
    File.open(EXISTING_FILE, 'w') { |f| f.print "hello" }
  end
  
  def teardown
    File.delete(NEW_FILE) if File.exists?(NEW_FILE)
    File.delete(EXISTING_FILE) if File.exists?(NEW_FILE)
  end

  def test_create_file
    assert(! File.exists?(NEW_FILE))
    cf = CreateFileCommand.new(NEW_FILE, 'hello world')
    cf.execute
    assert(File.exists?(NEW_FILE))
    assert_equal('hello world', File.read(NEW_FILE)) 
  end
  
  def test_delete_file
    assert(File.exists?(EXISTING_FILE))
    cf = DeleteFileCommand.new(EXISTING_FILE)
    cf.execute
    assert(!File.exists?(EXISTING_FILE))
  end
  
  def test_copy_file
    assert(! File.exists?(NEW_FILE))
    assert(File.exists?(EXISTING_FILE))
    cf = CopyFileCommand.new(EXISTING_FILE, NEW_FILE)
    cf.execute
    assert_equal(File.read(EXISTING_FILE), File.read(NEW_FILE)) 
  end

  def test_base_command
    cf = Command.new('BaseTest')
    success = cf.execute
    assert_equal(success, false)
  end
  
  def test_composite_cmd
    create = CreateFileCommand.new(EXISTING_FILE, 'new stuff')
    copy = CopyFileCommand.new(EXISTING_FILE, NEW_FILE)
    delete = DeleteFileCommand.new(EXISTING_FILE)
    comp = CompositeCommand.new
    comp.add_command(create)
    comp.add_command(copy)
    comp.add_command(delete)
    comp.execute
    assert(!File.exists?(EXISTING_FILE))
    assert_equal('new stuff', File.read(NEW_FILE))
  end

end


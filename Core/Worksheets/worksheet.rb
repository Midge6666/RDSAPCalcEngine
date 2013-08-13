class Worksheet < Command
  include Enumerable

  def initialize(name)
    super(name)
    @results = []
    @expected = []
  end

  def each(&block)
    @results.each(&block)
  end

  def add_result(result)
    @results << result
  end

  def add_expected(result)
    @expected << result
  end

  def execute
    super.execute
  end

  def compare
     @results.each do |temp|
      @expected.each do |temp2|
        temp.compare(tmp2) if temp.description == temp2.description
      end
    end
  end
end
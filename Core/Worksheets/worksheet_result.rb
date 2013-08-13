#
# Worksheet Result
#
class WorksheetResult 
  attr_reader   :description
  attr_accessor :val

  # Worksheet items

  def initialize(description)
    @description = description
  end
  
  def compare(expected)
    return (expected.description == @description &&
            expected.value == @val)
   end

end


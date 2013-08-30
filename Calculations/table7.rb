class Table7
  # To change this template use File | Settings | File Templates.

  def initialize
  end

  def get_values
    calculationFactory = CalculationFactory.instance

    item = calculationFactory.new_resultData( 5.4, 5.1, 5.1, 4.5, 4.1, 3.9, 3.7, 3.7, 4.2, 4.5, 4.8, 5.1)

    return item
  end
end
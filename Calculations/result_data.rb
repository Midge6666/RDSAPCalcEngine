MONTHS_INDEX =
{
    JAN:    0,
    FEB:    1,
    MARCH:  2,
    APRIL:  3,
    MAY:    4,
    JUNE:   5,
    JULY:   6,
    AUG:    7,
    SEP:    8,
    OCT:    9,
    NOV:   10,
    DEC:   11
}

class ResultData
  # To change this template use File | Settings | File Templates.

  @daysInMonth = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ]
  @resultData = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]

  @leapYearBase = 2000

  def initialize
  end

  def initialize(jan, feb, march, april, may, june, july, aug, sep, oct, nov, dec)
    @resultData = [ jan, feb, march, april, may, june, july, aug, sep, oct, nov, dec ]
  end

  def set_all_months(val)
    @resultData = [ val, val, val, val, val, val, val, val, val, val, val, val ]
  end

  def add_result_data(additionalResult)
    @resultData[MONTHS_INDEX[:JAN]] += additionalResult[MONTHS_INDEX[:JAN]]
    @resultData[MONTHS_INDEX[:FEB]] += additionalResult[MONTHS_INDEX[:FEB]]
    @resultData[MONTHS_INDEX[:MARCH]] += additionalResult[MONTHS_INDEX[:MARCH]]
    @resultData[MONTHS_INDEX[:APRIL]] += additionalResult[MONTHS_INDEX[:APRIL]]
    @resultData[MONTHS_INDEX[:MAY]] += additionalResult[MONTHS_INDEX[:MAY]]
    @resultData[MONTHS_INDEX[:JUNE]] += additionalResult[MONTHS_INDEX[:JUNE]]
    @resultData[MONTHS_INDEX[:JULY]] += additionalResult[MONTHS_INDEX[:JULY]]
    @resultData[MONTHS_INDEX[:AUG]] += additionalResult[MONTHS_INDEX[:AUG]]
    @resultData[MONTHS_INDEX[:SEP]] += additionalResult[MONTHS_INDEX[:SEP]]
    @resultData[MONTHS_INDEX[:OCT]] += additionalResult[MONTHS_INDEX[:OCT]]
    @resultData[MONTHS_INDEX[:NOV]] += additionalResult[MONTHS_INDEX[:NOV]]
    @resultData[MONTHS_INDEX[:DEC]] += additionalResult[MONTHS_INDEX[:DEC]]
  end

  def get_month_result(monthIndex)
    return @resultData[monthIndex]
  end

  def set_month_result(monthIndex, val)
    @resultData[monthIndex] = val
  end

  def increment_month_result(monthIndex, val)
    @resultData[monthIndex] += val
  end

  def results
    return @resultData
  end

  def calc_year
    total = 0

    for i in 0..11
      total = total + @resultData[i]
    end

    return total
  end

end
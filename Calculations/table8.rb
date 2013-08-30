class Table8
  # To change this template use File | Settings | File Templates.

  @table8Data = []

  def initialize
    calculationFactory = CalculationFactory.instance
    thames = calculationFactory.new_resultData( 5.1, 5.5, 7.4, 9.3, 12.6, 15.4, 17.8, 17.8, 15.1, 11.6, 7.6, 5.5 )
    se_england = calculationFactory.new_resultData( 5.3, 5.4, 7.4, 9.2, 12.6, 15.2, 17.6, 17.8, 15.2, 11.9, 7.9, 5.8 )
    s_england = calculationFactory.new_resultData( 5.5, 5.7, 7.5, 9.2, 12.6, 15.2, 17.4, 17.6, 15.1, 11.8, 8.1, 5.9 )
    sw_england = calculationFactory.new_resultData( 6.4, 6.5, 7.9, 9.3, 12.4, 14.7, 16.8, 17.0, 14.9, 12.0, 8.9, 7.0 )
    severn = calculationFactory.new_resultData( 5.4, 5.7, 7.5, 9.2, 12.6, 15.2, 17.4, 17.3, 14.9, 11.5, 8.0, 5.9 )
    midlands = calculationFactory.new_resultData( 4.9, 5.3, 7.1, 9.0, 12.2, 14.9, 17.2, 17.1, 14.5, 11.0, 7.3, 5.2 )
    w_pennines = calculationFactory.new_resultData( 5.1, 5.5, 7.0, 8.9, 12.0, 14.5, 16.6, 16.5, 14.1, 10.9, 7.6, 5.4 )
    nw_england_sw_scotland = calculationFactory.new_resultData( 4.6, 4.9, 6.2, 8.1, 11.1, 13.5, 15.5, 15.4, 13.1, 10.1, 7.0, 4.9 )
    borders = calculationFactory.new_resultData( 4.3, 4.7, 6.1, 7.9, 10.7, 13.4, 15.5, 15.4, 13.0, 9.8, 6.6, 4.6 )
    ne_england = calculationFactory.new_resultData( 4.5, 4.9, 6.4, 8.2, 11.2, 14.0, 16.2, 16.1, 13.6, 10.3, 6.9, 4.8 )
    e_pennines = calculationFactory.new_resultData( 4.5, 5.0, 6.8, 8.7, 11.7, 14.6, 16.9, 16.9, 14.3, 10.8, 7.0, 4.9 )
    e_anglia = calculationFactory.new_resultData( 4.6, 5.0, 7.0, 9.0, 12.2, 15.0, 17.5, 17.6, 15.0, 11.4, 7.3, 5.1 )
    wales = calculationFactory.new_resultData( 5.7, 5.8, 7.3, 8.9, 12.0, 14.3, 16.4, 16.3, 14.2, 11.2, 8.2, 6.2 )
    w_scotland = calculationFactory.new_resultData( 4.8, 4.9, 6.0, 7.9, 10.8, 13.1, 14.9, 14.8, 12.8, 9.8, 7.0, 5.1 )
    e_scotland = calculationFactory.new_resultData( 4.1, 4.4, 5.7, 7.7, 10.6, 13.2, 15.2, 15.0, 12.7, 9.4, 6.3, 4.3 )
    ne_scotland = calculationFactory.new_resultData( 4.0, 4.2, 5.5, 7.4, 10.1, 12.8, 14.9, 14.7, 12.5, 9.2, 6.2, 4.1 )
    highland = calculationFactory.new_resultData( 4.4, 4.3, 5.5, 7.4, 10.2, 12.5, 14.5, 14.4, 12.3, 9.2, 6.5, 4.5 )
    westernisles = calculationFactory.new_resultData( 5.3, 5.0, 5.9, 7.4, 9.8, 11.7, 13.7, 13.7, 12.1, 9.5, 7.2, 5.6 )
    orkney = calculationFactory.new_resultData( 4.9, 4.5, 5.2, 6.9, 9.1, 11.2, 13.3, 13.6, 11.9, 9.3, 6.9, 5.2 )
    shetland = calculationFactory.new_resultData( 4.7, 4.1, 4.7, 6.4, 8.5, 10.6, 12.7, 13.0, 11.4, 8.8, 6.5, 4.9 )
    northernireland = calculationFactory.new_resultData( 5.2, 5.4, 6.8, 8.3, 11.1, 13.4, 15.4, 15.2, 13.2, 10.2, 7.4, 5.5 )

    @table8Data = [thames, se_england, s_england, sw_england, severn, midlands, w_pennines, nw_england_sw_scotland, borders, ne_england, e_pennines, e_anglia, wales, w_scotland, e_scotland, ne_scotland, highland, westernisles, orkney, shetland, northernireland  ]
  end

  def get_external_temperature_default(month)
    # as the data starts at 0, -1
    resultData = @table8Data[RHI_REGION[:RHIR_E_PENNINES] - 1]
    return resultData.get_month_result(month)
  end

  def get_external_temperature(region, month)
    # as the data starts at 0, -1
    resultData = @table8Data[region - 1]
    return resultData.get_month_result(month)
  end

  def get_values_default
    resultData = @table8Data[RHI_REGION[:RHIR_E_PENNINES] - 1]
    return resultData.results
  end

  def get_values(region)
    resultData = @table8Data[region - 1]
    return resultData.results
  end

end
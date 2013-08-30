class Table4g
  # To change this template use File | Settings | File Templates.

  def get_specific_fan_power(method)
    result = 0

    if (method == SAP_VENTILATION_METHOD[:VM_EXTRACT_CENTRALISED]     ||
        method == SAP_VENTILATION_METHOD[:VM_EXTRACT_DECENTRALISED]   ||
        method == SAP_VENTILATION_METHOD[:VM_POSITIVE_INPUT_EXTERNAL])
      result = 0.8
    elsif (method == SAP_VENTILATION_METHOD[:VM_MECHANICAL])
      result = 2.0
    elsif (method == SAP_VENTILATION_METHOD[:VM_MECHANICAL_WITH_HR] ||
           method == SAP_VENTILATION_METHOD[:VM_RENWABLE_TECH])
      result = 2.0
    end

    return result
  end
end
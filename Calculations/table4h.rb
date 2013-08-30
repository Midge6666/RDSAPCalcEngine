class Table4h
  # To change this template use File | Settings | File Templates.

  def get_in_use_factor_spf(method, config)

    result = 2.5

    if (method == SAP_VENTILATION_METHOD[:VM_EXTRACT_DECENTRALISED])
      if (config == SAP_VENTILATION_DUCTING_CONFIGURATION[:VDC_FLEXIBLE_DUCTING])
        result = 1.45
      elsif (config == SAP_VENTILATION_DUCTING_CONFIGURATION[:VDC_RIGID_DUCTING])
        result = 1.30
      elsif (config == SAP_VENTILATION_DUCTING_CONFIGURATION[:VDC_NO_DUCTING])
        result = 1.15
      else
        result = 1.45
      end
    elsif (method == SAP_VENTILATION_METHOD[:VM_POSITIVE_INPUT_EXTERNAL] ||
           method == SAP_VENTILATION_METHOD[:VM_EXTRACT_CENTRALISED])

      if (config == SAP_VENTILATION_DUCTING_CONFIGURATION[:VDC_FLEXIBLE_DUCTING])
        result = 1.70
      elsif (config == SAP_VENTILATION_DUCTING_CONFIGURATION[:VDC_RIGID_DUCTING])
        result = 1.40
      else
        result = 1.70
      end
    end

    return result
  end

  def get_in_use_factor_hre(insulation)
    return insulation == SAP_VENTILATION_DUCTING_INSULATION[:VDI_INSULATED] ? 0.85 : 0.70
  end

end
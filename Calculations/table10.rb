RHI_REGION =
{
    RHIR_THAMES:                  1,
    RHIR_SE_ENGLAND:              2,
    RHIR_S_ENGLAND:               3,
    RHIR_SW_ENGLAND:              4,
    RHIR_SEVERN:                  5,
    RHIR_MIDLANDS:                6,
    RHIR_W_PENNINES:              7,
    RHIR_NW_ENGLAND_SW_SCOTLAND:  8,
    RHIR_BORDERS:                 9,
    RHIR_NE_ENGLAND:              10,
    RHIR_E_PENNINES:              11,
    RHIR_E_ANGLIA:                12,
    RHIR_WALES:                   13,
    RHIR_W_SCOTLAND:              14,
    RHIR_E_SCOTLAND:              15,
    RHIR_NE_SCOTLAND:             16,
    RHIR_HIGHLAND:                17,
    RHIR_WESTERNISLES:            18,
    RHIR_ORKNEY:                  19,
    RHIR_SHETLAND:                20,
    RHIR_NORTHERNIRELAND:         21,
}

RHI_V_REGION =
  {
      RHI_THAMES: 51.5,
      RHI_SE_ENGLAND: 51.0,
      RHI_S_ENGLAND: 50.8,
      RHI_SW_ENGLAND: 50.6,
      RHI_SEVERN: 51.5,
      RHI_MIDLANDS: 52.7,
      RHI_W_PENNINES: 53.4,
      RHI_NW_ENGLAND_SW_SCOTLAND: 54.8,
      RHI_BORDERS: 55.5,
      RHI_NE_ENGLAND: 54.5,
      RHI_E_PENNINES: 53.4,
      RHI_E_ANGLIA: 52.3,
      RHI_WALES: 52.5,
      RHI_W_SCOTLAND: 55.8,
      RHI_E_SCOTLAND: 56.4,
      RHI_NE_SCOTLAND: 57.2,
      RHI_HIGHLAND: 57.5,
      RHI_WESTERNISLES: 58.0,
      RHI_ORKNEY: 59.0,
      RHI_SHETLAND: 60.2,
      RHI_NORTHERNIRELAND: 54.7,
  };

class Table10
  # To change this template use File | Settings | File Templates.

  def get_latitude(region)
    return RHI_V_REGION[:region]
  end
end
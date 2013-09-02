class Table6a
  def Initilise()
    _records.insert(std.make_pair(RHIR_THAMES, self.Table6aRecord(self.ResultData(29, 55, 99, 153, 192, 214, 204, 177, 124, 73, 39, 23))))
    _records.insert(std.make_pair(RHIR_SE_ENGLAND, self.Table6aRecord(self.ResultData(31, 57, 103, 163, 204, 225, 213, 186, 129, 78, 42, 24))))
    _records.insert(std.make_pair(RHIR_S_ENGLAND, self.Table6aRecord(self.ResultData(33, 59, 105, 162, 207, 225, 213, 190, 132, 77, 43, 26))))
    _records.insert(std.make_pair(RHIR_SW_ENGLAND, self.Table6aRecord(self.ResultData(33, 60, 104, 166, 200, 218, 208, 186, 133, 75, 42, 27))))
    _records.insert(std.make_pair(RHIR_SEVERN, self.Table6aRecord(self.ResultData(31, 57, 100, 157, 198, 218, 208, 184, 128, 72, 40, 24))))
    _records.insert(std.make_pair(RHIR_MIDLANDS, self.Table6aRecord(self.ResultData(26, 53, 95, 147, 188, 204, 194, 168, 117, 68, 34, 21))))
    _records.insert(std.make_pair(RHIR_W_PENNINES, self.Table6aRecord(self.ResultData(23, 51, 93, 144, 189, 196, 186, 159, 110, 63, 30, 19))))
    _records.insert(std.make_pair(RHIR_NW_ENGLAND_SW_SCOTLAND, self.Table6aRecord(self.ResultData(20, 48, 87, 138, 188, 192, 187, 156, 110, 59, 28, 17))))
    _records.insert(std.make_pair(RHIR_BORDERS, self.Table6aRecord(self.ResultData(21, 47, 85, 135, 182, 186, 178, 149, 103, 57, 28, 16))))
    _records.insert(std.make_pair(RHIR_NE_ENGLAND, self.Table6aRecord(self.ResultData(22, 50, 88, 139, 181, 188, 183, 154, 106, 61, 30, 18))))
    _records.insert(std.make_pair(RHIR_E_PENNINES, self.Table6aRecord(self.ResultData(26, 54, 94, 150, 190, 201, 194, 164, 116, 68, 33, 21))))
    _records.insert(std.make_pair(RHIR_E_ANGLIA, self.Table6aRecord(self.ResultData(29, 56, 100, 157, 196, 212, 203, 173, 123, 75, 38, 23))))
    _records.insert(std.make_pair(RHIR_WALES, self.Table6aRecord(self.ResultData(26, 53, 98, 152, 195, 209, 198, 172, 117, 67, 33, 21))))
    _records.insert(std.make_pair(RHIR_W_SCOTLAND, self.Table6aRecord(self.ResultData(17, 45, 84, 139, 193, 186, 183, 154, 102, 54, 24, 13))))
    _records.insert(std.make_pair(RHIR_E_SCOTLAND, self.Table6aRecord(self.ResultData(17, 45, 81, 133, 185, 187, 177, 146, 99, 52, 24, 12))))
    _records.insert(std.make_pair(RHIR_NE_SCOTLAND, self.Table6aRecord(self.ResultData(17, 43, 84, 131, 183, 187, 170, 142, 98, 51, 23, 12))))
    _records.insert(std.make_pair(RHIR_HIGHLAND, self.Table6aRecord(self.ResultData(15, 41, 82, 134, 184, 181, 163, 140, 97, 48, 21, 11))))
    _records.insert(std.make_pair(RHIR_WESTERNISLES, self.Table6aRecord(self.ResultData(17, 38, 83, 140, 200, 189, 175, 147, 106, 49, 21, 10))))
    _records.insert(std.make_pair(RHIR_ORKNEY, self.Table6aRecord(self.ResultData(16, 42, 81, 144, 202, 199, 178, 141, 102, 49, 19, 9))))
    _records.insert(std.make_pair(RHIR_SHETLAND, self.Table6aRecord(self.ResultData(11, 32, 72, 129, 186, 183, 163, 138, 87, 43, 15, 6))))
    _records.insert(std.make_pair(RHIR_NORTHERNIRELAND, self.Table6aRecord(self.ResultData(23, 49, 89, 139, 190, 188, 175, 152, 107, 61, 29, 17))))
  end

  def get_solar_radiation(month)
    # The default solar radiation figures are based on a specific region
    return self.GetSolarRadiation(month, RHIR_E_PENNINES)
  end

  def get_solar_radiation(month, Region)
    if _records.size() == 0 then
      self.Initilise()
    end
    return _records[Region].Radiation.GetMonthResult(month)
  end
end
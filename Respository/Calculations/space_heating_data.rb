class SpaceHeatingData
  def InitTable4() #hw    sup   proddb
    self.AddRecord(self.SapTableRecord(HC_ASSUMED_ELECTRIC, HSC_NOT_PRESENT, FC_NONE, 100.0, 0, 1.00, HWP_NONE, true, false, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_SEDBUK_BOILER, HSC_CENTRAL_HEATING, FC_NONE, 0.0, 1, 1.00, HWP_INDEPENDANT, false, true, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_SEDBUK_CHP, HSC_CENTRAL_HEATING, FC_NONE, 0.0, 1, 1.00, HWP_INDEPENDANT, false, true, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_SEDBUK_HEATPUMP_BLR, HSC_CENTRAL_HEATING, FC_NONE, 0.0, 1, 1.00, HWP_INDEPENDANT, false, true, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_SEDBUK_HEATPUMP_WA, HSC_WARM_AIR, FC_NONE, 0.0, 1, 1.00, HWP_INDEPENDANT, false, true, FO_NONE))
    # solid fuel boilers
    self.AddRecord(self.SapTableRecord(HC_SFBLR_MANFEED_INTERNAL, HSC_CENTRAL_HEATING, FC_SOLID, 60.0, 2, 0.75, HWP_INDEPENDANT, false, false, FO_ANY, 65.0))
    self.AddRecord(self.SapTableRecord(HC_SFBLR_MANFEED_EXTERNAL, HSC_CENTRAL_HEATING, FC_SOLID, 55.0, 2, 0.75, HWP_INDEPENDANT, false, false, FO_ANY, 60.0))
    self.AddRecord(self.SapTableRecord(HC_SFBLR_AUTOFEED_INTERNAL, HSC_CENTRAL_HEATING, FC_SOLID, 65.0, 2, 0.75, HWP_INDEPENDANT, false, false, FO_ANY, 70.0))
    self.AddRecord(self.SapTableRecord(HC_SFBLR_AUTOFEED_EXTERNAL, HSC_CENTRAL_HEATING, FC_SOLID, 60.0, 2, 0.75, HWP_INDEPENDANT, false, false, FO_ANY, 65.0))
    self.AddRecord(self.SapTableRecord(HC_SFBLR_WOODCHIP, HSC_CENTRAL_HEATING, FC_SOLID, 63.0, 2, 0.75, HWP_INDEPENDANT, false, false, FO_ANY, 65.0))
    self.AddRecord(self.SapTableRecord(HC_SFBLR_OPEN_BACKBLR_TORADS, HSC_CENTRAL_HEATING, FC_SOLID, 55.0, 3, 0.50, HWP_WINTER, false, false, FO_ANY, 63.0))
    self.AddRecord(self.SapTableRecord(HC_SFBLR_CLOSED_HEATER_TORADS, HSC_CENTRAL_HEATING, FC_SOLID, 65.0, 3, 0.50, HWP_WINTER, false, false, FO_ANY, 67.0))
    self.AddRecord(self.SapTableRecord(HC_SFBLR_STOVE_TORADS, HSC_CENTRAL_HEATING, FC_SOLID, 63.0, 2, 0.75, HWP_WINTER, false, false, FO_ANY, 65.0))
    self.AddRecord(self.SapTableRecord(HC_SFBLR_INTEGRAL_RANGE, HSC_CENTRAL_HEATING, FC_SOLID, 45.0, 3, 0.50, HWP_INDEPENDANT, false, false, FO_ANY, 50.0))
    self.AddRecord(self.SapTableRecord(HC_SFBLR_INDEPENDENT_RANGE, HSC_CENTRAL_HEATING, FC_SOLID, 55.0, 3, 0.50, HWP_INDEPENDANT, false, false, FO_ANY, 60.0))
    # electric boilers
    self.AddRecord(self.SapTableRecord(HC_ELECBLR_DIRECT, HSC_CENTRAL_HEATING, FC_ELECTRIC, 100.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_ELECBLR_CPSU, HSC_CENTRAL_HEATING, FC_ELECTRIC, 100.0, 2, 0.75, HWP_INDEPENDANT, false, false, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_ELECBLR_DRYCORE_INTERNAL, HSC_CENTRAL_HEATING, FC_ELECTRIC, 100.0, 2, 0.75, HWP_INDEPENDANT, false, false, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_ELECBLR_DRYCORE_EXTERNAL, HSC_CENTRAL_HEATING, FC_ELECTRIC, 85.0, 2, 0.75, HWP_INDEPENDANT, false, false, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_ELECBLR_WATER_INTERNAL, HSC_CENTRAL_HEATING, FC_ELECTRIC, 100.0, 2, 0.75, HWP_INDEPENDANT, false, false, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_ELECBLR_WATER_EXTERNAL, HSC_CENTRAL_HEATING, FC_ELECTRIC, 85.0, 2, 0.75, HWP_INDEPENDANT, false, false, FO_NONE))
    # heat-pump (boilers)
    self.AddRecord(self.SapTableRecord(HC_ELECHP_GROUND_TO_WATER, HSC_CENTRAL_HEATING, FC_ELECTRIC, 320.0, 0, 1.00, HWP_INDEPENDANT, false, false, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_ELECHP_GROUND_TO_WATER_AUX, HSC_CENTRAL_HEATING, FC_ELECTRIC, 300.0, 0, 1.00, HWP_INDEPENDANT, false, false, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_ELECHP_WATER_TO_WATER, HSC_CENTRAL_HEATING, FC_ELECTRIC, 300.0, 0, 1.00, HWP_INDEPENDANT, false, false, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_ELECHP_AIR_TO_WATER, HSC_CENTRAL_HEATING, FC_ELECTRIC, 250.0, 0, 1.00, HWP_INDEPENDANT, false, false, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_GASHP_GROUND_SOURCE_BOILER, HSC_CENTRAL_HEATING, FC_GAS, 120.0, 0, 1.00, HWP_INDEPENDANT, false, false, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_GASHP_WATER_SOURCE_BOILER, HSC_CENTRAL_HEATING, FC_GAS, 120.0, 0, 1.00, HWP_INDEPENDANT, false, false, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_GASHP_AIR_SOURCE_BOILER, HSC_CENTRAL_HEATING, FC_GAS, 110.0, 0, 1.00, HWP_INDEPENDANT, false, false, FO_NONE))
    # community heating
    self.AddRecord(self.SapTableRecord(HC_COMMUNITY_BOILERS, HSC_COMMUNITY_HEATING, FC_MULTI, 80.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_COMMUNITY_CHP, HSC_COMMUNITY_HEATING, FC_MULTI, 80.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_COMMUNITY_WASTE_HEAT, HSC_COMMUNITY_HEATING, FC_MULTI, 100.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_COMMUNITY_HEATPUMP, HSC_COMMUNITY_HEATING, FC_MULTI, 300.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_COMMUNITY_GEOTHERMAL, HSC_COMMUNITY_HEATING, FC_MULTI, 100.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_NONE))
    # electric storage heating
    self.AddRecord(self.SapTableRecord(HC_ELECSTG_OLD_LARGE_VOLUME, HSC_STORAGE_HEATING, FC_ELECTRIC, 100.0, 5, 0.00, HWP_NONE, true, false, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_ELECSTG_MODERN_SLIMLINE, HSC_STORAGE_HEATING, FC_ELECTRIC, 100.0, 4, 0.25, HWP_NONE, true, false, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_ELECSTG_CONVECTOR, HSC_STORAGE_HEATING, FC_ELECTRIC, 100.0, 4, 0.25, HWP_NONE, true, false, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_ELECSTG_FAN, HSC_STORAGE_HEATING, FC_ELECTRIC, 100.0, 3, 0.50, HWP_NONE, true, false, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_ELECSTG_SLIMLINE_CELECT, HSC_STORAGE_HEATING, FC_ELECTRIC, 100.0, 3, 0.50, HWP_NONE, true, false, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_ELECSTG_CONVECTOR_CELECT, HSC_STORAGE_HEATING, FC_ELECTRIC, 100.0, 3, 0.50, HWP_NONE, true, false, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_ELECSTG_FAN_CELECT, HSC_STORAGE_HEATING, FC_ELECTRIC, 100.0, 2, 0.75, HWP_NONE, true, false, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_ELECSTG_INTEGRATED, HSC_STORAGE_HEATING, FC_ELECTRIC, 100.0, 2, 0.75, HWP_NONE, true, false, FO_NONE))
    # electric underfloor
    self.AddRecord(self.SapTableRecord(HC_ELECUF_CONCRETE_SLAB, HSC_ELEC_UNDERFLOOR, FC_ELECTRIC, 100.0, 5, 0.00, HWP_NONE, true, false, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_ELECUF_INTEGRATED, HSC_ELEC_UNDERFLOOR, FC_ELECTRIC, 100.0, 4, 0.25, HWP_NONE, true, false, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_ELECUF_INTEGRATED_TARIFF, HSC_ELEC_UNDERFLOOR, FC_ELECTRIC, 100.0, 3, 0.50, HWP_NONE, true, false, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_ELECUF_INSCREED, HSC_ELEC_UNDERFLOOR, FC_ELECTRIC, 100.0, 2, 0.75, HWP_NONE, true, false, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_ELECUF_INTIMBER, HSC_ELEC_UNDERFLOOR, FC_ELECTRIC, 100.0, 1, 1.00, HWP_NONE, true, false, FO_NONE))
    # gas warmair - fan flue
    self.AddRecord(self.SapTableRecord(HC_GASWA_ONOFF_PRE1998_FAN, HSC_WARM_AIR, FC_GAS, 70.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_FAN))
    self.AddRecord(self.SapTableRecord(HC_GASWA_ONOFF_MODERN_FAN, HSC_WARM_AIR, FC_GAS, 76.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_FAN))
    self.AddRecord(self.SapTableRecord(HC_GASWA_MODULATING_PRE1998_FAN, HSC_WARM_AIR, FC_GAS, 72.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_FAN))
    self.AddRecord(self.SapTableRecord(HC_GASWA_MODULATING_MODERN_FAN, HSC_WARM_AIR, FC_GAS, 78.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_FAN))
    self.AddRecord(self.SapTableRecord(HC_GASWA_HEATER_WITH_DUCTS, HSC_WARM_AIR, FC_GAS, 69.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_FAN))
    # gas warmair - open/balanced flue
    self.AddRecord(self.SapTableRecord(HC_GASWA_ONOFF_PRE1998, HSC_WARM_AIR, FC_GAS, 70.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_NON_FAN))
    self.AddRecord(self.SapTableRecord(HC_GASWA_ONOFF_MODERN, HSC_WARM_AIR, FC_GAS, 76.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_NON_FAN))
    self.AddRecord(self.SapTableRecord(HC_GASWA_MODULATING_PRE1998, HSC_WARM_AIR, FC_GAS, 72.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_NON_FAN))
    self.AddRecord(self.SapTableRecord(HC_GASWA_MODULATING_MODERN, HSC_WARM_AIR, FC_GAS, 78.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_NON_FAN))
    self.AddRecord(self.SapTableRecord(HC_GASWA_FLUE_HEAT_RECOVERY, HSC_WARM_AIR, FC_GAS, 85.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_NON_FAN))
    self.AddRecord(self.SapTableRecord(HC_GASWA_CONDENSING, HSC_WARM_AIR, FC_GAS, 81.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_NON_FAN))
    # oil warmair
    #Hot water proivision for OIL warm air changed to meet OA-14
    self.AddRecord(self.SapTableRecord(HC_OILWA_DUCTED_ONOFF, HSC_WARM_AIR, FC_OIL, 70.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_ANY))
    self.AddRecord(self.SapTableRecord(HC_OILWA_DUCTED_MODULATING, HSC_WARM_AIR, FC_OIL, 72.0, 1, 1.00, HWP_NONE, false, false, FO_ANY))
    self.AddRecord(self.SapTableRecord(HC_OILWA_STUB_DUCTED, HSC_WARM_AIR, FC_OIL, 70.0, 1, 1.00, HWP_NONE, false, false, FO_ANY))
    # electric warmair
    self.AddRecord(self.SapTableRecord(HC_ELECWA_ELECTRICARE, HSC_WARM_AIR, FC_ELECTRIC, 100.0, 2, 0.75, HWP_NONE, false, false, FO_NONE))
    # heatpumps (warmair)
    self.AddRecord(self.SapTableRecord(HC_ELECHP_GROUND_TO_AIR, HSC_WARM_AIR, FC_ELECTRIC, 320.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_ELECHP_GROUND_TO_AIR_AUX, HSC_WARM_AIR, FC_ELECTRIC, 300.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_ELECHP_WATER_TO_AIR, HSC_WARM_AIR, FC_ELECTRIC, 300.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_ELECHP_AIR_TO_AIR, HSC_WARM_AIR, FC_ELECTRIC, 250.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_GASHP_GROUND_SOURCE_WARMAIR, HSC_WARM_AIR, FC_ELECTRIC, 120.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_GASHP_WATER_SOURCE_WARMAIR, HSC_WARM_AIR, FC_ELECTRIC, 120.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_GASHP_AIR_SOURCE_WARMAIR, HSC_WARM_AIR, FC_ELECTRIC, 110.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_NONE))
    # gas room heaters
    self.AddRecord(self.SapTableRecord(HC_GASRH_PRE1980_OPEN, HSC_ROOM_HEATERS, FC_GAS, 50.0, 1, 1.00, HWP_NONE, false, false, FO_OPEN))
    self.AddRecord(self.SapTableRecord(HC_GASRH_PRE1980_OPEN_BACKBLR, HSC_ROOM_HEATERS, FC_GAS, 50.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_OPEN))
    self.AddRecord(self.SapTableRecord(HC_GASRH_MODERN_OPEN, HSC_ROOM_HEATERS, FC_GAS, 63.0, 1, 1.00, HWP_NONE, false, false, FO_OPEN))
    self.AddRecord(self.SapTableRecord(HC_GASRH_MODERN_OPEN_BACKBLR, HSC_ROOM_HEATERS, FC_GAS, 63.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_OPEN))
    self.AddRecord(self.SapTableRecord(HC_GASRH_LIVEFUEL_OPEN, HSC_ROOM_HEATERS, FC_GAS, 40.0, 1, 1.00, HWP_NONE, false, false, FO_OPEN))
    self.AddRecord(self.SapTableRecord(HC_GASRH_LIVEFUEL_OPEN_BACKBLR, HSC_ROOM_HEATERS, FC_GAS, 40.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_OPEN))
    self.AddRecord(self.SapTableRecord(HC_GASRH_LIVEFUEL_OPEN_FANFLUE, HSC_ROOM_HEATERS, FC_GAS, 45.0, 1, 1.00, HWP_NONE, false, false, FO_OPEN))
    self.AddRecord(self.SapTableRecord(HC_GASRH_BALANCED_FLUE, HSC_ROOM_HEATERS, FC_GAS, 58.0, 1, 1.00, HWP_NONE, false, false, FO_BALANCED))
    self.AddRecord(self.SapTableRecord(HC_GASRH_CLOSED_FANFLUE, HSC_ROOM_HEATERS, FC_GAS, 72.0, 1, 1.00, HWP_NONE, false, false, FO_BALANCED))
    self.AddRecord(self.SapTableRecord(HC_GASRH_CONDENSING, HSC_ROOM_HEATERS, FC_GAS, 85.0, 1, 1.00, HWP_NONE, false, false, FO_BALANCED))
    self.AddRecord(self.SapTableRecord(HC_GASRH_DECORATIVE_TO_CHIMNEY, HSC_ROOM_HEATERS, FC_GAS, 20.0, 1, 1.00, HWP_NONE, false, false, FO_CHIMNEY))
    self.AddRecord(self.SapTableRecord(HC_GASRH_FLUELESS, HSC_ROOM_HEATERS, FC_GAS, 90.0, 1, 1.00, HWP_NONE, false, false, FO_NONE))
    # oil room heaters
    self.AddRecord(self.SapTableRecord(HC_OILRH_PRE2000, HSC_ROOM_HEATERS, FC_OIL, 55.0, 1, 1.00, HWP_NONE, false, false, FO_OPEN))
    self.AddRecord(self.SapTableRecord(HC_OILRH_PRE2000_BACKBLR, HSC_ROOM_HEATERS, FC_OIL, 65.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_OPEN))
    self.AddRecord(self.SapTableRecord(HC_OILRH_MODERN, HSC_ROOM_HEATERS, FC_OIL, 60.0, 1, 1.00, HWP_NONE, false, false, FO_OPEN))
    self.AddRecord(self.SapTableRecord(HC_OILRH_MODERN_BACKBLR, HSC_ROOM_HEATERS, FC_OIL, 70.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_OPEN))
    self.AddRecord(self.SapTableRecord(HC_OILRH_BIOETHANOL, HSC_ROOM_HEATERS, FC_OIL, 94.0, 1, 1.00, HWP_NONE, false, false, FO_NONE)) # TODO: what is the efficiency of this?
    # solid fuel room heaters
    self.AddRecord(self.SapTableRecord(HC_SFRH_OPEN_FIRE, HSC_ROOM_HEATERS, FC_SOLID, 32.0, 3, 0.50, HWP_NONE, false, false, FO_CHIMNEY, 37.0))
    self.AddRecord(self.SapTableRecord(HC_SFRH_OPEN_FIRE_BACKBLR, HSC_ROOM_HEATERS, FC_SOLID, 50.0, 3, 0.50, HWP_WINTER, false, false, FO_CHIMNEY, 50.0))
    self.AddRecord(self.SapTableRecord(HC_SFRH_CLOSED_HEATER, HSC_ROOM_HEATERS, FC_SOLID, 60.0, 3, 0.50, HWP_NONE, false, false, FO_OPEN, 65.0))
    self.AddRecord(self.SapTableRecord(HC_SFRH_CLOSED_HEATER_BACKBLR, HSC_ROOM_HEATERS, FC_SOLID, 65.0, 3, 0.50, HWP_WINTER, false, false, FO_OPEN, 67.0))
    self.AddRecord(self.SapTableRecord(HC_SFRH_PELLET_STOVE, HSC_ROOM_HEATERS, FC_SOLID, 63.0, 2, 0.75, HWP_NONE, false, false, FO_OPEN, 65.0))
    self.AddRecord(self.SapTableRecord(HC_SFRH_PELLET_STOVE_BACKBLR, HSC_ROOM_HEATERS, FC_SOLID, 63.0, 2, 0.75, HWP_WINTER, false, false, FO_OPEN, 65.0))
    # electric room heaters
    self.AddRecord(self.SapTableRecord(HC_ELECRH_PANEL_HEATERS, HSC_ROOM_HEATERS, FC_ELECTRIC, 100.0, 1, 1.00, HWP_NONE, false, false, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_ELECRH_FILLED_RADS, HSC_ROOM_HEATERS, FC_ELECTRIC, 100.0, 1, 1.00, HWP_NONE, false, false, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_ELECRH_FAN_HEATERS, HSC_ROOM_HEATERS, FC_ELECTRIC, 100.0, 1, 1.00, HWP_NONE, false, false, FO_NONE))
    self.AddRecord(self.SapTableRecord(HC_ELECRH_PORTABLE_HEATERS, HSC_ROOM_HEATERS, FC_ELECTRIC, 100.0, 1, 1.00, HWP_NONE, false, false, FO_NONE))
    # other heating
    self.AddRecord(self.SapTableRecord(HC_ELECOTHER_CEILING_HEATING, HSC_OTHER_SYSTEMS, FC_ELECTRIC, 100.0, 2, 0.75, HWP_NONE, false, false, FO_NONE))
    # gas boilers (1998 or later)
    self.AddRecord(self.SapTableRecord(HC_GASBLR_AUTO, HSC_CENTRAL_HEATING, FC_GAS, 74.0, 64.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_ANY))
    self.AddRecord(self.SapTableRecord(HC_GASBLR_COND_AUTO, HSC_CENTRAL_HEATING, FC_GAS, 84.0, 74.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_ANY))
    self.AddRecord(self.SapTableRecord(HC_GASBLR_COMBI_AUTO, HSC_CENTRAL_HEATING, FC_GAS, 74.0, 65.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_ANY))
    self.AddRecord(self.SapTableRecord(HC_GASBLR_COND_COMBI_AUTO, HSC_CENTRAL_HEATING, FC_GAS, 84.0, 75.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_ANY))
    self.AddRecord(self.SapTableRecord(HC_GASBLR_PERM, HSC_CENTRAL_HEATING, FC_GAS, 70.0, 60.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_ANY))
    self.AddRecord(self.SapTableRecord(HC_GASBLR_COND_PERM, HSC_CENTRAL_HEATING, FC_GAS, 80.0, 70.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_ANY))
    self.AddRecord(self.SapTableRecord(HC_GASBLR_COMBI_PERM, HSC_CENTRAL_HEATING, FC_GAS, 70.0, 61.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_ANY))
    self.AddRecord(self.SapTableRecord(HC_GASBLR_CONDCOMBI_PERM, HSC_CENTRAL_HEATING, FC_GAS, 80.0, 71.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_ANY))
    self.AddRecord(self.SapTableRecord(HC_GASBLR_BACK_TORADS, HSC_CENTRAL_HEATING, FC_GAS, 66.0, 56.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_ANY))
    # gas boilers (pre-1998 with fan flues)
    self.AddRecord(self.SapTableRecord(HC_GASBLR_LOW_THERMAL, HSC_CENTRAL_HEATING, FC_GAS, 73.0, 63.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_FAN))
    self.AddRecord(self.SapTableRecord(HC_GASBLR_HIGH_THERMAL, HSC_CENTRAL_HEATING, FC_GAS, 69.0, 59.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_FAN))
    self.AddRecord(self.SapTableRecord(HC_GASBLR_COMBI_PRE1998_FAN, HSC_CENTRAL_HEATING, FC_GAS, 71.0, 62.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_FAN))
    self.AddRecord(self.SapTableRecord(HC_GASBLR_CONDCOMBI_PRE1998_FAN, HSC_CENTRAL_HEATING, FC_GAS, 84.0, 75.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_FAN))
    self.AddRecord(self.SapTableRecord(HC_GASBLR_COND_PRE1998_FAN, HSC_CENTRAL_HEATING, FC_GAS, 84.0, 74.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_FAN))
    # gas boilers (pre-1998 with open/balanced flues)
    self.AddRecord(self.SapTableRecord(HC_GASBLR_WALL_PRE1998, HSC_CENTRAL_HEATING, FC_GAS, 66.0, 56.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_NON_FAN))
    self.AddRecord(self.SapTableRecord(HC_GASBLR_FLOOR_PRE1979, HSC_CENTRAL_HEATING, FC_GAS, 56.0, 46.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_NON_FAN))
    self.AddRecord(self.SapTableRecord(HC_GASBLR_FLOOR_PRE1998, HSC_CENTRAL_HEATING, FC_GAS, 66.0, 56.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_NON_FAN))
    self.AddRecord(self.SapTableRecord(HC_GASBLR_COMBI_PRE1998_OPEN, HSC_CENTRAL_HEATING, FC_GAS, 66.0, 57.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_NON_FAN))
    self.AddRecord(self.SapTableRecord(HC_GASBLR_BACK_TORADS_PRE1998, HSC_CENTRAL_HEATING, FC_GAS, 66.0, 56.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_NON_FAN))
    # gas CPSUs
    self.AddRecord(self.SapTableRecord(HC_GASCPSU_AUTO, HSC_CENTRAL_HEATING, FC_GAS, 74.0, 72.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_ANY))
    self.AddRecord(self.SapTableRecord(HC_GASCPSU_CONDENSING_AUTO, HSC_CENTRAL_HEATING, FC_GAS, 83.0, 81.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_ANY))
    self.AddRecord(self.SapTableRecord(HC_GASCPSU_PILOT, HSC_CENTRAL_HEATING, FC_GAS, 70.0, 68.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_ANY))
    self.AddRecord(self.SapTableRecord(HC_GASCPSU_CONDENSING_PILOT, HSC_CENTRAL_HEATING, FC_GAS, 79.0, 77.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_ANY))
    # oil boilers
    self.AddRecord(self.SapTableRecord(HC_OILBLR_PRE1985, HSC_CENTRAL_HEATING, FC_OIL, 66.0, 54.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_ANY))
    self.AddRecord(self.SapTableRecord(HC_OILBLR_PRE1997, HSC_CENTRAL_HEATING, FC_OIL, 71.0, 59.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_ANY))
    self.AddRecord(self.SapTableRecord(HC_OILBLR_MODERN, HSC_CENTRAL_HEATING, FC_OIL, 80.0, 68.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_ANY))
    self.AddRecord(self.SapTableRecord(HC_OILBLR_CONDENSING, HSC_CENTRAL_HEATING, FC_OIL, 84.0, 72.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_ANY))
    self.AddRecord(self.SapTableRecord(HC_OILBLR_COMBI_PRE1998, HSC_CENTRAL_HEATING, FC_OIL, 71.0, 62.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_ANY))
    self.AddRecord(self.SapTableRecord(HC_OILBLR_COMBI, HSC_CENTRAL_HEATING, FC_OIL, 77.0, 68.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_ANY))
    self.AddRecord(self.SapTableRecord(HC_OILBLR_CONDENSING_COMBI, HSC_CENTRAL_HEATING, FC_OIL, 82.0, 73.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_ANY))
    self.AddRecord(self.SapTableRecord(HC_OILBLR_HEATER_TORADS_PRE2000, HSC_CENTRAL_HEATING, FC_OIL, 66.0, 54.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_ANY))
    self.AddRecord(self.SapTableRecord(HC_OILBLR_HEATER_TORADS, HSC_CENTRAL_HEATING, FC_OIL, 71.0, 59.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_ANY))
    # gas range cooker boilers
    self.AddRecord(self.SapTableRecord(HC_GASRNG_SINGLE_PILOT, HSC_CENTRAL_HEATING, FC_GAS, 47.0, 37.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_ANY))
    self.AddRecord(self.SapTableRecord(HC_GASRNG_SINGLE_AUTO, HSC_CENTRAL_HEATING, FC_GAS, 51.0, 41.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_ANY))
    self.AddRecord(self.SapTableRecord(HC_GASRNG_TWIN_PILOT_PRE1998, HSC_CENTRAL_HEATING, FC_GAS, 61.0, 51.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_ANY))
    self.AddRecord(self.SapTableRecord(HC_GASRNG_TWIN_AUTO_PRE1998, HSC_CENTRAL_HEATING, FC_GAS, 66.0, 56.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_ANY))
    self.AddRecord(self.SapTableRecord(HC_GASRNG_TWIN_PILOT, HSC_CENTRAL_HEATING, FC_GAS, 66.0, 56.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_ANY))
    self.AddRecord(self.SapTableRecord(HC_GASRNG_TWIN_AUTO, HSC_CENTRAL_HEATING, FC_GAS, 71.0, 61.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_ANY))
    # oil range cooker boilers
    self.AddRecord(self.SapTableRecord(HC_OILRNG_SINGLE, HSC_CENTRAL_HEATING, FC_OIL, 61.0, 49.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_ANY))
    self.AddRecord(self.SapTableRecord(HC_OILRNG_TWIN_PRE1998, HSC_CENTRAL_HEATING, FC_OIL, 71.0, 59.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_ANY))
    self.AddRecord(self.SapTableRecord(HC_OILRNG_TWIN, HSC_CENTRAL_HEATING, FC_OIL, 76.0, 64.0, 1, 1.00, HWP_INDEPENDANT, false, false, FO_ANY))
    # ///////////////////// FINISHED TABLE //////////////////////////////
    # add column B for gas room heaters...
    self.SetFuelSpecificEfficiency(HC_GASRH_MODERN_OPEN, F_GAS_BULK_LPG, 64.0)
    self.SetFuelSpecificEfficiency(HC_GASRH_MODERN_OPEN, F_GAS_BOTTLED_LPG, 64.0)
    self.SetFuelSpecificEfficiency(HC_GASRH_MODERN_OPEN, F_GAS_LPG_SC18, 64.0)
    self.SetFuelSpecificEfficiency(HC_GASRH_MODERN_OPEN_BACKBLR, F_GAS_BULK_LPG, 64.0)
    self.SetFuelSpecificEfficiency(HC_GASRH_MODERN_OPEN_BACKBLR, F_GAS_BOTTLED_LPG, 64.0)
    self.SetFuelSpecificEfficiency(HC_GASRH_MODERN_OPEN_BACKBLR, F_GAS_LPG_SC18, 64.0)
    self.SetFuelSpecificEfficiency(HC_GASRH_LIVEFUEL_OPEN, F_GAS_BULK_LPG, 41.0)
    self.SetFuelSpecificEfficiency(HC_GASRH_LIVEFUEL_OPEN, F_GAS_BOTTLED_LPG, 41.0)
    self.SetFuelSpecificEfficiency(HC_GASRH_LIVEFUEL_OPEN, F_GAS_LPG_SC18, 41.0)
    self.SetFuelSpecificEfficiency(HC_GASRH_LIVEFUEL_OPEN_BACKBLR, F_GAS_BULK_LPG, 41.0)
    self.SetFuelSpecificEfficiency(HC_GASRH_LIVEFUEL_OPEN_BACKBLR, F_GAS_BOTTLED_LPG, 41.0)
    self.SetFuelSpecificEfficiency(HC_GASRH_LIVEFUEL_OPEN_BACKBLR, F_GAS_LPG_SC18, 41.0)
    self.SetFuelSpecificEfficiency(HC_GASRH_LIVEFUEL_OPEN_FANFLUE, F_GAS_BULK_LPG, 46.0)
    self.SetFuelSpecificEfficiency(HC_GASRH_LIVEFUEL_OPEN_FANFLUE, F_GAS_BOTTLED_LPG, 46.0)
    self.SetFuelSpecificEfficiency(HC_GASRH_LIVEFUEL_OPEN_FANFLUE, F_GAS_LPG_SC18, 46.0)
    self.SetFuelSpecificEfficiency(HC_GASRH_BALANCED_FLUE, F_GAS_BULK_LPG, 60.0)
    self.SetFuelSpecificEfficiency(HC_GASRH_BALANCED_FLUE, F_GAS_BOTTLED_LPG, 60.0)
    self.SetFuelSpecificEfficiency(HC_GASRH_BALANCED_FLUE, F_GAS_LPG_SC18, 60.0)
    self.SetFuelSpecificEfficiency(HC_GASRH_CLOSED_FANFLUE, F_GAS_BULK_LPG, 73.0)
    self.SetFuelSpecificEfficiency(HC_GASRH_CLOSED_FANFLUE, F_GAS_BOTTLED_LPG, 73.0)
    self.SetFuelSpecificEfficiency(HC_GASRH_CLOSED_FANFLUE, F_GAS_LPG_SC18, 73.0)
    # condensing = same for all fuels
    # decorative fire to chimney = same for all fuels
    self.SetFuelSpecificEfficiency(HC_GASRH_FLUELESS, F_GAS_BULK_LPG, 92.0)
    self.SetFuelSpecificEfficiency(HC_GASRH_FLUELESS, F_GAS_BOTTLED_LPG, 92.0)
    self.SetFuelSpecificEfficiency(HC_GASRH_FLUELESS, F_GAS_LPG_SC18, 92.0)
    # now update so
    self.SetFuelSpecificResponsiveness(HC_ELECSTG_MODERN_SLIMLINE, F_ELEC_24HOUR, 0.50)
    self.SetFuelSpecificResponsiveness(HC_ELECSTG_CONVECTOR, F_ELEC_24HOUR, 0.50)
    self.SetFuelSpecificResponsiveness(HC_ELECSTG_FAN, F_ELEC_24HOUR, 0.50)
    self.SetFuelSpecificResponsiveness(HC_ELECSTG_SLIMLINE_CELECT, F_ELEC_24HOUR, 0.75)
    self.SetFuelSpecificResponsiveness(HC_ELECSTG_CONVECTOR_CELECT, F_ELEC_24HOUR, 0.75)
    self.SetFuelSpecificResponsiveness(HC_ELECSTG_FAN_CELECT, F_ELEC_24HOUR, 0.75)
  end

  def SetFuelSpecificEfficiency(code, fuel, efficiency)
    it = _table4.find(code)
    if it != _table4.end() then
      it.second.SetFuelSpecificEfficiency(fuel, efficiency / 100.0)
    else
      # can't find <code> in table...
      self._ASSERT(0)
    end
  end

  def SetFuelSpecificResponsiveness(code, fuel, responsiveness)
    it = _table4.find(code)
    if it != _table4.end() then
      it.second.SetFuelSpecificResponsiveness(fuel, responsiveness)
    else
      # can't find <code> in table...
      self._ASSERT(0)
    end
  end

  def AddRecord(record)
    _table4.insert(self.pair(record.GetHeatingCode(), record))
  end

  def Initialise()
    if SpaceHeatingData._table4.size() == 0 then
      SpaceHeatingData.InitTable4()
    end
    _pHeatingRecord = nil
    _pTable4d = nil
    _pValidator = Validator.new(self, _validationController)
  end

  def initialize(id)
    self.@_pWaterInfo = nil
    self.Initialise()
    self.SetProductDbId(id)
  end

  def initialize(id)
    self.@_pWaterInfo = nil
    self.Initialise()
    self.SetProductDbId(id)
  end

  def SetSystemFuel(fuel)
    if Table12.GetFuelCategory(fuel) == FC_ELECTRIC then
      # fuels are always stored as their "on peak" versions
      _heatingFuel = Table12.GetOnPeakEquivalent(fuel)
    else
      _heatingFuel = fuel
    end
    return (true)
  end

  def SetSystemControls(controls)
    # TODO: validate they match the system
    _controls = controls
    return (true)
  end

  def SetEmitters(emitters, pipeConfig)
    _emitters = emitters
    _pipeConfig = pipeConfig
    self.ClearTable4()
    if (_pHeatingRecord.GetHeatingClass() == HSC_CENTRAL_HEATING and _pHeatingRecord.GetFuelCategory() != FC_SOLID and _pHeatingRecord.GetFuelCategory() != FC_ELECTRIC) or (_pHeatingRecord.GetHeatpumpType() != HPT_NOT_HEATPUMP and _pHeatingRecord.GetHeatpumpType() != HPT_COMMUNITY) then
      _pTable4d = Table4d.new(emitters, pipeConfig)
    end
  end

  def SetWarmAirFanCount(count)
    _warmAirFanCount.SetValue(count)
  end

  def SetWaterPumpInHeatedSpace(value)
    _isWaterPumpInHeatedSpace = value
  end

  def SetHasBoilerInterlock(hasBoilerInterlock)
    _hasBoilerInterlock = hasBoilerInterlock
  end

  def SetDeclaredEfficiency(eff, isModulating)
    _declaredEfficiency.SetValue(eff)
    _isModulatingBoiler = isModulating
  end

  def ClearDeclaredEfficiency()
    _declaredEfficiency.Clear()
  end

  def RemoveWaterSystemLink()
    _pWaterInfo = nil
  end

  def SetLinkedWaterSystem(pWaterInfo)
    _pWaterInfo = pWaterInfo
  end

  def SetTable4Code(code)
    cit = const_iterator.new()
    cit = _table4.find(code)
    self.ClearHeatingRecord()
    _pHeatingRecord = SapTableRecord.new(cit.second)
    _validationController.RegisterComponent(_pHeatingRecord)
    return (true)
  end

  def ClearHeatingRecord()
    if _pHeatingRecord != nil then
      _pHeatingRecord = nil
      _pHeatingRecord = nil
    end
  end

  def SetProductDbId(productId)
    begin
      self.ClearHeatingRecord()
      pRec = ProductDatabaseRecord.new(productId)
      _validationController.RegisterComponent(pRec)
      _pHeatingRecord = pRec
    rescue EngineException => ex
      return false
    ensure
    end
    return (true)
  end

  def Dispose()
    self.ClearHeatingRecord()
    self.ClearTable4()
    _pValidator = nil
  end

  def GetClass()
    return (_pHeatingRecord.GetHeatingClass())
  end

  def CanProvideHotWater()
    return (_pHeatingRecord.CanProvideHotWater())
  end

  def GetHotWaterProvision()
    return (_pHeatingRecord.GetHotWaterProvision())
  end

  def CanProvideSecondaryHeating()
    # only room heaters can be secondary systems
    return (_pHeatingRecord.GetHeatingClass() == HSC_ROOM_HEATERS)
  end

  def GetEfficiency()
    if _isHetasApproved.TestValue() then
      return (_pHeatingRecord.GetWinterEfficiency(_isHetasApproved.GetValue()))
    else
      return (self.GetWinterEfficiency())
    end
  end

  def GetHeatingType()
    if _pTable4d != nil and _pTable4d.IsValid() then
      # using table 4d for heating type
      return (_pTable4d.GetHeatingType())
    else
      return (_pHeatingRecord.GetHeatingType())
    end
  end

  def GetResponsiveness()
    if _pTable4d != nil and _pTable4d.IsValid() then
      # using table 4d for responsiveness
      return (_pTable4d.GetResponsiveness())
    else
      if _heatingFuel.TestValue() and _pHeatingRecord.HasFuelSpecificResponsiveness(_heatingFuel.GetValue()) then
        return (_pHeatingRecord.GetFuelSpecificResponsiveness(_heatingFuel.GetValue()))
      else
        return (_pHeatingRecord.GetResponsiveness())
      end
    end
  end

  def IsClass(systemClass)
    return (self.GetClass() == systemClass)
  end

  def GetHeatingCode()
    return (_pHeatingRecord.GetHeatingCode())
  end

  def IsFromProductDatabase()
    return (_pHeatingRecord.IsFromProductDatabase())
  end

  def IsCombiSystem()
    return self.CheckHeatingRecord(_pHeatingRecord.IsCombiSystem(), _isCombi, false)
  end

  def IsFromDirectActingElectric()
    result = _pHeatingRecord.IsFromDirectActingElectric()
    if result.TestValue() then
      return result.GetValue()
    else
      return false
    end
  end

  def IsCPSUSystem()
    return self.CheckHeatingRecord(_pHeatingRecord.IsCPSU(), _isCpsu, false)
  end

  def GetThermalStoreType()
    return (_pHeatingRecord.GetThermalStoreType())
  end

  def GetFuelCategory()
    return (_pHeatingRecord.GetFuelCategory())
  end

  def GetFuel()
    if _heatingFuel.TestValue() == false then
      return (_pHeatingRecord.GetFuel())
    end
    return (_heatingFuel.GetValue())
  end

  def GetHeatingControls()
    return (_controls)
  end

  def GetManufacturersWaterLossFactor()
    return (_pHeatingRecord.GetManufacturersWaterLossFactor())
  end

  def SetHasDelayedStartThermostat(flag)
    _hasDelayedStartThermostat = flag
  end

  def SetHasLoadCompensation(type)
    _loadCompensationType = type
  end

  def SetHasWeatherCompensation(flag)
    _hasWeatherCompensator = flag
  end

  def SetHetasApproved(flag)
    _isHetasApproved = flag
  end

  def SetFlueType(type)
    if type == FT_FAN then
      # tidy up - if just fam assume balanced fan
      type = (FT_FAN | FT_BALANCED)
    elsif (type & FT_CHIMNEY) != 0 then
      # tidy up - if chimney clear the fan bit
      type = FT_CHIMNEY
    end
    _flueType.SetValue(type)
  end

  def SetFuelPumpType(type)
    _fuelPumpType = type
  end

  def IsProvidingSpaceHeating()
    if _isProvidingSpaceHeating.TestValue() then
      return (_isProvidingSpaceHeating)
    else
      return (false)
    end
  end

  def SetIsProvidingSpaceHeating(val)
    _isProvidingSpaceHeating = val
  end

  def HasWaterPumpInHeatedSpace()
    # Appendix N states that pumps included in the test data should not be included in internal gains or electricity consumed, so effectively they're not here
    if _pHeatingRecord.IsFromProductDatabase() and (_pHeatingRecord.IsMicrogenSystem() or _pHeatingRecord.IsHeatpump()) and _pHeatingRecord.GetAppendixNInterfaceRecord().IsSeperateCirculatorIncludedInTestData() then
      return false
    end
    return (self.GetClass() == HSC_CENTRAL_HEATING and _isWaterPumpInHeatedSpace)
  end

  def ClearTable4()
    if _pTable4d != nil then
      _pTable4d = nil
      _pTable4d = nil
    end
  end

  def CheckTariffConsistency(fuel)
    result = TARIFF_CONSISTENCY_RESULT.new()
    if Table12.GetFuelCategory(fuel) == FC_ELECTRIC then
      if Table12.GetOnPeakEquivalent(self.GetFuel()) == Table12.GetOnPeakEquivalent(fuel) then
        result = TCR_CONSISTENT
      else
        # TODO: check for "conflicts" i.e. 10h from Electric CPSU
        result = TCR_INCONSISTENT
      end
    else # not electric
      result = TCR_NOT_ELECTRIC
    end
    return (result)
  end

  def HasRoomThermostat()
    if _controls.TestValue() == false then
      _pValidator.NotifyItem(VSC_SERIOUS, CVL_SPACE_HEATING, SE10010_HEATING_CONTROLS_MISSING, "Heating system controls not specified - assuming no control")
      return (false)
    end
    case _controls
      when CG0_NONE
        result = false
        break
      when CG1_NO_CONTROLS, CG1_PROG_ONLY, CG1_TRVS_BYPASS, CG1_PROG_TRVS_BYPASS, CG1_PROG_TRVS_FLOWSWITCH
        result = false
        break
      when CG1_ROOMSTAT_ONLY, CG1_PROG_ROOMSTAT, CG1_PROG_MULTISTAT, CG1_PROG_ROOMSTAT_TRVS, CG1_ZONE_CONTROL, CG1_PROG_TRVS_BEM
        result = true
        break
      when 			# GROUP 2 (Heatpumps - wet systems)
      CG2_NO_CONTROLS, CG2_PROG_ONLY, CG2_ROOMSTAT_ONLY, CG2_PROG_TRVS_BYPASS
        result = false
        break
      when CG2_PROG_ROOMSTAT, CG2_PROG_MULTISTAT, CG2_ZONE_CONTROL
        result = true
        break
      when 			# GROUP 3 (Community HeatingHeatpumps - wet systems)
      CG3_FRC_NO_CONTROLS, CG3_FRC_PROG_ONLY, CG3_FRC_TRVS_ONLY, CG3_FRC_PROG_TRVS, CG3_UBC_TRVS_ONLY, CG3_UBC_PROG_TRVS
        result = false
        break
      when CG3_FRC_ROOMSTAT_ONLY, CG3_FRC_PROG_ROOMSTAT, CG3_UBC_ROOMSTAT_ONLY, CG3_UBC_PROG_ROOMSTAT
        result = true
        break
      when 			# GROUP 4 (electric storage)
      CG4_MANUAL_CHARGE, CG4_AUTO_CHARGE, CG4_CELECT
        result = false
        break
      when 			# GROUP 5 (warm air systems - including heatpumps with warm-air distribution)
      CG5_NO_CONTROLS, CG5_PROG_ONLY
        result = false
        break
      when CG5_ROOMSTAT_ONLY, CG5_PROG_ROOMSTAT, CG5_PROG_MULTISTAT, CG5_ZONE_CONTROL
        result = false
        break
      when 			# GROUP 6 (room heater systems)
      CG6_NO_CONTROLS, CG6_APPLSTATS, CG6_PROG_APPLSTATS
        result = false
        break
      when CG6_ROOMSTAT_ONLY, CG6_PROG_ROOMSTAT
        result = true
        break
      when 			# GROUP 7 (other systems)
      CG7_NO_CONTROLS, CG7_PROG_ONLY
        result = false
        break
      when CG7_ROOMSTAT_ONLY, CG7_PROG_ROOMSTAT, CG7_TEMP_ZONE_CONTROL, CG7_FULL_ZONE_CONTROL
        result = true
        break
      else
        _pValidator.NotifyItem(VSC_SERIOUS, CVL_SPACE_HEATING, SE10010_HEATING_CONTROLS_MISSING, "Heating system controls not specified - assuming no control")
        result = false
        break
    end
    return (result)
  end

  def HasFanFlue()
    result = _pHeatingRecord.HasFanFlue()
    if not result.TestValue() then # heating record cannot be certain of FanFlue Type so use user setting
      if _flueType.TestValue() then
        return ((_flueType.GetValue() & FT_FAN) != 0)
      else
        _pValidator.NotifyItem(VSC_SERIOUS, CVL_SPACE_HEATING, SE20002_HEATING_FANFLUE_DEFAULTED, "Fan flue was not specified - assumed no fan flue")
        return false
      end
    else
      if _flueType.TestValue() then
        clientSpecifiedFan = ((_flueType.GetValue() & FT_FAN) != 0)
        # client fan specification does not match the record options so raise validation warning
        if clientSpecifiedFan != result.GetValue() then
          _pValidator.NotifyItem(VSC_WARNING, CVL_SPACE_HEATING, SE90001_FANFLUE_CONFLICT_BETWEEN_RECORD_AND_USER_DATA, "Fan flue specification set by client but is not compatible with the record type - record type was used in calculation")
        end
        return (result.GetValue())
      end
      return (result.GetValue())
    end
  end

  def HasFlueGasHeatRecovery()
    return (_pHeatingRecord.HasFlueGasHeatRecovery())
  end

  def HasWeatherCompensation()
    if self.IsClass(HSC_CENTRAL_HEATING) == false then
      return (false)
    end
    if _hasWeatherCompensator.TestValue() then
      return (_hasWeatherCompensator.GetValue())
    else
      _pValidator.NotifyItem(VSC_ERROR, CVL_SPACE_HEATING, SE10014_WEATHER_COMPENSATION_SPECIFICATION_MISSING, "Client has failed to record whether a weather compensation system is present or not for this system - assuming no weather compensation")
      return (false)
    end
  end

  def GetLoadCompensationType()
    if self.IsClass(HSC_CENTRAL_HEATING) == false then
      return (LCT_NO_LOAD_COMPENSATION)
    end
    if _loadCompensationType.TestValue() then
      return (_loadCompensationType.GetValue())
    else
      _pValidator.NotifyItem(VSC_ERROR, CVL_SPACE_HEATING, SE10015_LOAD_COMPENSATION_SPECIFICATION_MISSING, "Client has failed to record whether a load compensation system is present or not for this system - assuming no load compensation")
    end
    return (_loadCompensationType)
  end

  def GetFuelPumpType()
    if _fuelPumpType.TestValue() == false then
      if self.GetFuelCategory() == FC_OIL then
        _pValidator.NotifyItem(VSC_WARNING, CVL_SPACE_HEATING, SE10016_FUEL_PUMP_SPECIFICATION_MISSING, "Client has failed to record whether a fuel pump is required by the system - assuming fuel pump in unheated space")
        return (FPT_PUMP_UNHEATED_SPACE)
      else
        _pValidator.NotifyItem(VSC_WARNING, CVL_SPACE_HEATING, SE10016_FUEL_PUMP_SPECIFICATION_MISSING, "Client has failed to record whether a fuel pump is required by the system - assuming no fuel pump required")
        return (FPT_NO_FUEL_PUMP)
      end
    else
      return (_fuelPumpType.GetValue())
    end
  end

  def HasBoilerInterlock()
    interlock = N[System::Boolean].new()
    heatSysClass = self.GetClass()
    if heatSysClass != HSC_CENTRAL_HEATING and heatSysClass != HSC_WARM_AIR then
      # no boiler interlock for other systems
      interlock.SetValue(false)
    end
    if _hasBoilerInterlock.TestValue() then
      # user specified
      return (_hasBoilerInterlock)
    elsif self.IsCombiSystem() or self.IsCPSUSystem() or self.GetThermalStoreType() != TST_NO_THERMAL_STORE then
      # combi, CPSU and thermal store assume cylinder stats if there is a room stat
      interlock.SetValue(self.HasRoomThermostat())
    else
      result = self.HasRoomThermostat()
      if result == true then
        if _pWaterInfo != nil then
          if _pWaterInfo.GetCylinderInfo().HasThermostat() == false then
            # if water from this system and no cylinder stat then interlock = false
            result = false
          end
        end
      end
      interlock.SetValue(result)
    end
    return (interlock)
  end

  def HasChimney()
    if _flueType.TestValue() then
      return ((_flueType.GetValue() & FT_CHIMNEY) != 0)
    elsif _pHeatingRecord != nil then
      return (_pHeatingRecord.HasChimney())
    end
    # no info...
    return (false)
  end

  def HasOpenFlue()
    if _flueType.TestValue() then
      return (_flueType.GetValue() & FT_OPEN)
    elsif _pHeatingRecord != nil then
      return (_pHeatingRecord.HasOpenFlue())
    end
    # no info...
    return (false)
  end

  def CheckForEfficiencyConflict()
    result = false
    if _declaredEfficiency.TestValue() and _pHeatingRecord.IsFromProductDatabase() then
      _pValidator.NotifyItem(VSC_ERROR, CVL_SPACE_HEATING, SE90002_USING_DECLARED_EFFICIENCY_WITH_DATABASE_BOILER, "Using declared efficiency to override a boiler from Product Database, should be using SAP tables - calculation is ignoring declared value")
      result = true
    end
    return (result)
  end

  def IsFromSedbuk2005()
    if self.CheckForEfficiencyConflict() then
      return (false)
    end
    # TODO: check this - it might not be that all declared efficiencies are SEDBUK2005 (e.g. boiler improvements in RDSAP)
    rv = _declaredEfficiency.TestValue()
    if rv then # I'm not sure why declared efficiency being set always indicates the system was from Sedbuk2005.  This is causing problems later on for some fuel types where asserts are thrown.  I'm only allowing the fuel types I know to be ok
      FuelCat = _pHeatingRecord.GetFuelCategory()
      if FuelCat != FC_GAS and FuelCat != FC_OIL then
        rv = false
      end
    end
    return rv
  end

  def GetSummerEfficiency()
    if self.CheckForEfficiencyConflict() then
      return (_pHeatingRecord.GetSummerEfficiency())
    end
    return ((_declaredEfficiency.TestValue()) ? _declaredEfficiency.GetValue() : _pHeatingRecord.GetSummerEfficiency())
  end

  def GetWinterEfficiency()
    if self.CheckForEfficiencyConflict() == false and _declaredEfficiency.TestValue() == true then
      result = _declaredEfficiency.GetValue()
    else
      if _pHeatingRecord.HasFuelSpecificEfficiency(_heatingFuel) then
        result = _pHeatingRecord.GetFuelSpecificEfficiency(_heatingFuel)
      else
        result = _pHeatingRecord.GetWinterEfficiency()
      end
    end
    return (result)
  end

  def IsHeatingUnitInHeatedSpace()
    # has not been entered directly - can it be defaulted
    if self.GetClass() == HSC_CENTRAL_HEATING then
      askRecord = _pHeatingRecord.IsUnitInHeatedSpace()
      if askRecord.TestValue() then
        # explict from system definition
        result = askRecord.GetValue()
        return (result)
      end
    end
    if self.GetClass() == HSC_COMMUNITY_HEATING then
      result = false
    elsif self.GetClass() == HSC_ROOM_HEATERS then
      # room heaters have to be in the heated space to heat the space!
      result = true
    elsif _pHeatingRecord.IsBackBoiler() then
      # all back boilers are in heated space
      result = true
    elsif _pHeatingRecord.IsStoveOrRange() then
      # all stoves/ranges are in heated space
      result = true
    elsif _isWaterPumpInHeatedSpace.TestValue() == false then
      _pValidator.NotifyItem(VSC_WARNING, CVL_SPACE_HEATING, SE20001_HEATING_UNIT_IN_HEATED_SPACE_DEFAULTED, "Water pump in heated space - not specified and cannot ascertain from other data (assumed \'yes\')")
      result = true
    else
      result = _isWaterPumpInHeatedSpace.GetValue()
    end
    return (result)
  end

  def GetCombiType()
    return (_pHeatingRecord.GetCombiType())
  end

  def IsMicrogenSystem()
    return (_pHeatingRecord.IsMicrogenSystem())
  end

  def IsHeatpump()
    return (_pHeatingRecord.IsHeatpump())
  end

  def IsElectricCPSU()
    return (_pHeatingRecord.IsElectricCPSU())
  end

  def IsUnderfloorHeating()
    return (_pHeatingRecord.IsUnderfloorHeating())
  end

  def IsPre98System()
    return self.CheckHeatingRecord(_pHeatingRecord.IsPre98System(), _pre98System, false)
  end

  def IsCondensingBoiler()
    return self.CheckHeatingRecord(_pHeatingRecord.IsCondensingBoiler(), _condensingBoiler, false)
  end

  def IsModulatingBoiler()
    if self.IsClass(HSC_CENTRAL_HEATING) == false then
      return (false)
    end
    if _isModulatingBoiler.TestValue() == false then
      # TODO: add validation here
      return (false)
    end
    return (_isModulatingBoiler.GetValue())
  end

  def IsHotWaterOnlyThermalStore()
    return ((_isProvidingSpaceHeating == false) and (_pHeatingRecord.GetThermalStoreType() != TST_NO_THERMAL_STORE))
  end

  def IsOffPeakOnlySystem()
    return _pHeatingRecord.IsOffPeakOnlySystem()
  end

  def GetStorageHeatingType()
    return (_pHeatingRecord.GetStorageHeatingType())
  end

  def IsElectricaireSystem()
    return (_pHeatingRecord.IsElectricaireSystem())
  end

  def GetHeatpumpType()
    return (_pHeatingRecord.GetHeatpumpType())
  end

  def GetEmitterType()
    return (_emitters)
  end

  def MakeTariffConsistent(fuel)
    onPeak = Table12.GetOnPeakEquivalent(fuel)
    if Table12.GetFuelCategory(_heatingFuel) == FC_ELECTRIC then
      _heatingFuel = onPeak
    end
    return (true)
  end

  def CheckHeatingRecord(result, CheckMember, Default)
    if not result.TestValue() then # heating record cannot be certain of requested item so use user setting or default
      if CheckMember.TestValue() then
        return CheckMember.GetValue()
      else
        #_pValidator->NotifyItem(VSC_SERIOUS...
        return Default
      end
    else
      # Compare User set flag against record type to determine if they match
      if CheckMember.TestValue() then
        clientSpecified = CheckMember.GetValue()
        # client specification does not match the record options so raise validation warning
        if clientSpecified != CheckMember.GetValue() then
        end
      end
      #_pValidator->NotifyItem(VSC_WARNING...
      return (result.GetValue())
    end
  end

  def GetStoreVolume()
    return _pHeatingRecord.GetStoreVolume()
  end

  def GetStoreInsThick()
    return _pHeatingRecord.GetStoreInsThick()
  end

  def GetStorageLossFactor()
    return _pHeatingRecord.GetStorageLossFactor()
  end

  def GetAppendixNInterfaceRecord()
    return _pHeatingRecord.GetAppendixNInterfaceRecord()
  end

  def SetCommunityHeatingLink(pCommunityData)
    _pCommunityHeatingData = pCommunityData
  end

  def GetCommunityHeatingData()
    return (_pCommunityHeatingData)
  end

  def GetCookerCaseLossAtFullOutput()
    return _pHeatingRecord.GetCookerCaseLossAtFullOutput()
  end

  def GetCookerFullOutput()
    return _pHeatingRecord.GetCookerFullOutput()
  end

  def GetKeepHotFacility()
    return _pHeatingRecord.GetKeepHotFacility()
  end

  def GetIsSeperateStore()
    result = false
    isSeperate = _pHeatingRecord.GetIsSeperateStore()
    if isSeperate.TestValue() then
      if isSeperate.GetValue() then
        return true
      end
    end
    return result
  end

  def GetKeepHotSource()
    return _pHeatingRecord.GetKeepHotSource()
  end

  def GetKeepHotPower()
    return _pHeatingRecord.GetKeepHotPower()
  end

  def HasSeperateDHWTestsBeenConducted()
    return _pHeatingRecord.HasSeperateDHWTestsBeenConducted()
  end

  def IsSeperateDHWTestsUsing2Schedules()
    return _pHeatingRecord.IsSeperateDHWTestsUsing2Schedules()
  end

  def GetRejectedEnergyR1InHWTest1()
    return _pHeatingRecord.GetRejectedEnergyR1InHWTest1()
  end

  def GetStorageLossFactorF1()
    return _pHeatingRecord.GetStorageLossFactorF1()
  end

  def GetStorageLossFactorF2()
    return _pHeatingRecord.GetStorageLossFactorF2()
  end

  def GetStorageLossFactorF3()
    return _pHeatingRecord.GetStorageLossFactorF3()
  end

  def GetSeparateDHWtests()
    return _pHeatingRecord.GetSeparateDHWtests()
  end

  def HasPFGHRSInstalled()
    return _pHeatingRecord.HasPFGHRSInstalled()
  end

  def GetPFGHRSIndex()
    return _pHeatingRecord.GetPFGHRSIndex()
  end
end
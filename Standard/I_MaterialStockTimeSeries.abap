CDS         : I_MaterialStockTimeSeries
Definition  : Material Stock For Periods
Using       : I_MaterialStockTimeSeries( P_StartDate: $session.system_date, P_EndDate: $session.system_date , P_PeriodType: 'D' ) as _Stock on _Stock.Material          = vbrp.matnr
                                                                                                                                           and _Stock.Plant             = vbrp.werks
                                                                                                                                           and _Stock.StorageLocation   = vbrp.lgort
Fields      : cast(_Stock.MatlWrhsStkQtyInMatlBaseUnit as abap.dec(13,3)) as stock_amount
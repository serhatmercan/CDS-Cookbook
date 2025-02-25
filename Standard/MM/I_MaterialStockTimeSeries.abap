CDS         :   I_MaterialStockTimeSeries
Description :   Material Stock For Periods

Using       :   as select distinct from I_MaterialStockTimeSeries(  P_StartDate:    $session.system_date, 
                                                                    P_EndDate:      $session.system_date, 
                                                                    P_PeriodType:   'D' ) as Stock on Stock.Material        = Vbrp.Matnr
                                                                                                  and Stock.Plant           = Vbrp.Werks
                                                                                                  and Stock.StorageLocation = Vbrp.Lgort
Fields      :   key Stock.Plant                                                     as Werks,
                key Stock.Material                                                  as Matnr,
                key Stock.StorageLocation                                           as Lgort,
                    
                    Stock.Batch,
                    Stock.InventorySpecialStockType,

                    @Semantics.quantity.unitOfMeasure: 'MEINS'
                    cast( Stock.MatlWrhsStkQtyInMatlBaseUnit as abap.dec(13,3) )    as StockAmount,
                    sum( Stock.MatlWrhsStkQtyInMatlBaseUnit )                       as StockAmount,
                    Stock.MaterialBaseUnit                                          as Meins,

                    Stock.WBSElementInternalID

Where       :   Stock.InventoryStockType = '01' and
                ( Stock.InventorySpecialStockType = ' ' or Stock.InventorySpecialStockType = 'Q' or Stock.InventorySpecialStockType = 'W' or Stock.InventorySpecialStockType = 'O' )

Group       :   Stock.Plant,
                Stock.Material,
                Stock.StorageLocation,
                Stock.MaterialBaseUnit,
                Stock.InventorySpecialStockType,
                Stock.Batch,
                Stock.WBSElementInternalID

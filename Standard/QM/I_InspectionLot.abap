CDS         :   I_InspectionLot
Description :   Inspection Lot

Using       :   inner join I_InspectionLot on IL.DeliveryDocument = I_DeliveryDocumentItem.DeliveryDocument " or IL.DeliveryDocument = I_DeliveryDocument.DeliveryDocumentBySupplier

Fields      :   key IL.InspectionLot,
                    
                    IL.Batch,
                    IL.Material,
                    IL.Plant

Where       :   

Group       :   
CDS         :   I_InspectionLot
Description :   Inspection Lot

Using       :   inner join I_InspectionLot as IL on IL.DeliveryDocument = I_DeliveryDocumentItem.DeliveryDocument // or IL.DeliveryDocument = I_DeliveryDocument.DeliveryDocumentBySupplier

Fields      :   key IL.InspectionLot,
                    
                    IL.Batch,
                    IL.Material,
                    IL.Plant

Where       :   

Group By    :   

Module           :   QM
Business Object  :   Inspection Lot
Common Use Cases :   - Quality inspection lot reporting linked to inbound delivery / batch / material
Related CDS      :   I_InspectionLotItem, I_DeliveryDocumentItem

CDS         :   I_MaterialDocumentRecord
Description :   Basis View for MATDOC Table

Using       :   as select from I_MaterialDocumentRecord as MDR

                    inner join mara on mara.matnr = MDR.Material

Fields      :   key MDR.Material,
                key MDR.Plant,
                key MDR.StorageLocation,

                    " Basis View for MATDOC Table
                    MDR.MaterialDocument,
                    MDR.MaterialDocumentYear,
                    
                    @Semantics.quantity.unitOfMeasure: 'MEINS'
                    MDR.MatlStkChangeQtyInBaseUnit,
                    MDR.MaterialBaseUnit                                    as Meins,

                    MDR.PostingDate,

                    " General Material Data
                    mara.mtart                                              as MaterialType

Where       :   ( MDR.GoodsMovementType = 'Y05' or MDR.GoodsMovementType = 'Y07' or MDR.GoodsMovementType = '921' ) and  
                MDR.GoodsMovementIsCancelled = ' '

Group       :   
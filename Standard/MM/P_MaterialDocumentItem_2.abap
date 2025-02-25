CDS         :   P_MaterialDocumentItem_2
Description :   RAP Material Document Item

Using       :   association [0..1] to P_MaterialDocumentItem_2 as _MatDocItem on _MatDocItem.MaterialDocument       = I_TicketDocFlow.NominationReferenceDocument
                                                                             and _MatDocItem.MaterialDocumentYear   = I_TicketDocFlow.MaterialDocumentYear

Fields      :   _MatDocItem.GoodsMovementType,
                _MatDocItem.InventoryValuationType,
                _MatDocItem.MaterialBaseUnit,
                _MatDocItem.MaterialDocumentParentLine,
                _MatDocItem.PostingDate,

                @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
                max(_MatDocItem.QuantityInBaseUnit)                     as QuantityInBaseUnit

Where       :   _MatDocItem.GoodsMovementType           = $parameters.p_move_ype and 
                _MatDocItem.MaterialDocumentParentLine  = '000000'

Group       :   
CDS         :   I_MaterialDocumentRecord
Description :   Basis View for MATDOC Table

Using       :   as select from I_MaterialDocumentRecord as MDR

                    inner join mara on mara.matnr = MDR.Material

Fields      :   key MDR.Material,
                key MDR.Plant,
                key MDR.StorageLocation,

                    // Basis View for MATDOC Table
                    MDR.MaterialDocument,
                    MDR.MaterialDocumentYear,
                    
                    @Semantics.quantity.unitOfMeasure: 'MEINS'
                    MDR.MatlStkChangeQtyInBaseUnit,
                    MDR.MaterialBaseUnit                                    as Meins,

                    MDR.PostingDate,

                    // General Material Data
                    mara.mtart                                              as MaterialType

Where       :   MDR.GoodsMovementIsCancelled = ' '
                // Movement-type scope is configuration - MATDOC is large, so always add one:
                //   and MDR.GoodsMovementType in ( ... )

Group By    :

Module           :   MM
Business Object  :   Material Document (MATDOC)
Common Use Cases :   - Reporting on selected goods movement types, excluding cancelled documents
Notes            :   - MATDOC-based; a movement type filter is essential given the table volume.
                     - Movement types are configuration and are intentionally not hard-coded.
Related CDS      :   I_MaterialDocumentHeader, I_MaterialDocumentItem
Release note     :   Nsdm_e_* are S/4HANA compatibility views. Verify their status and
                     extensibility in your release.

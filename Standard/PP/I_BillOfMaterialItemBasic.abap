CDS         :   I_BillOfMaterialItemBasic
Description :   BOM Item Details

Using       :   as select distinct from I_BillOfMaterialItemBasic as BOMItem   

Fields      :   key BOMItem.BillOfMaterialCategory,
                key BOMItem.BillOfMaterial,
                key BOMItem.BillOfMaterialItemNodeNumber,
                key BOMItem.BOMItemInternalChangeCount,

                    BOMItem.BillOfMaterialComponent,

                    BOMItem._Product,

Where       :   BOMItem.BillOfMaterialCategory = 'E';

Group By    :   

Module           :   PP
Business Object  :   Bill of Material Item
Associations Used:   _Product
Common Use Cases :   - BOM component / material list reporting
Notes            :   - Filtered to BillOfMaterialCategory 'E' (Engineering/Material BOM) only
Related CDS      :   I_BillOfMaterial, I_EquipmentBOMLink
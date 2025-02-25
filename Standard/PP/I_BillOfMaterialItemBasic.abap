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

Group       :   
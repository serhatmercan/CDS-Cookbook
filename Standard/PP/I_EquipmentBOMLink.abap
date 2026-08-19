CDS         :   I_EquipmentBOMLink
Description :   Equipment to BOM Link

Using       :   inner join I_EquipmentBOMLink as EquipmentBOM on EquipmentBOM.BillOfMaterial = I_BillOfMaterialItemBasic.BillOfMaterial   

Fields      :   key EquipmentBOM.BillOfMaterial,
                key EquipmentBOM.BillOfMaterialVariant,
                key EquipmentBOM.Equipment,
                key EquipmentBOM.Plant,
                key EquipmentBOM.BillOfMaterialVariantUsage,
                    
                    EquipmentBOM.BillOfMaterialCategory    

Where       :   

Group By    :   

Module           :   PP
Business Object  :   Equipment-to-BOM Assignment
Common Use Cases :   - Link equipment to its assigned BOM variant, e.g. for spare-parts / maintenance BOM reporting
Related CDS      :   I_BillOfMaterialItemBasic, I_Equipment

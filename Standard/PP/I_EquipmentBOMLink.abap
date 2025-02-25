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

Group       :   
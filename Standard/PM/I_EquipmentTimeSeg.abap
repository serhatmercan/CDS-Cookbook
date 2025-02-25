CDS         :   I_EquipmentTimeSeg
Description :   Equipment Time Segment

Using       :   inner join I_EquipmentTimeSeg as EquipmentTimeSeg on EquipmentTimeSeg.Equipment = I_EquipmentBOMLink.Equipment   

Fields      :   key EquipmentTimeSeg.Equipment,
                key EquipmentTimeSeg.ValidityEndDate,
                key EquipmentTimeSeg.EquipUsagePeriodSequenceNumber,    

                    EquipmentTimeSeg._Equipment
                    
Where       :   

Group       :   
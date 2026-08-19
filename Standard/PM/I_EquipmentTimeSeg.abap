CDS         :   I_EquipmentTimeSeg
Description :   Equipment Time Segment

Using       :   inner join I_EquipmentTimeSeg as EquipmentTimeSeg on EquipmentTimeSeg.Equipment = I_EquipmentBOMLink.Equipment   

Fields      :   key EquipmentTimeSeg.Equipment,
                key EquipmentTimeSeg.ValidityEndDate,
                key EquipmentTimeSeg.EquipUsagePeriodSequenceNumber,    

                    EquipmentTimeSeg._Equipment
                    
Where       :   

Group By    :   

Module           :   PM
Business Object  :   Equipment
Associations Used:   _Equipment
Common Use Cases :   - Time-dependent equipment usage period / installation history reporting
Related CDS      :   I_Equipment, I_EquipmentBOMLink

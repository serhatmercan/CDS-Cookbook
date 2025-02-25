CDS         :   I_TimeDepdntMatlAssign
Description :   Time Dependent Material Assignment to SOC

Using       :   inner join I_TimeDepdntMatlAssign as TDMA on TDMA.StorageObjSgmntNmbr       =  oib_tankdip.socnr    " or TDMA.StorageObjSgmntNmbr       = I_StorageLocationIndex.StorageObjSgmntNmbr
                                                         and TDMA.TankMaterialFromTimestamp <= oib_tankdip.etmstm   " or TDMA.TankMaterialFromTimestamp = tstmp_current_utctimestamp()  
                                                         and TDMA.TankMaterialToTimestamp   >= oib_tankdip.etmstm   " or TDMA.TankMaterialToTimestamp   = tstmp_current_utctimestamp()  

Fields      :   key TDMA.StorageObjSgmntNmbr,
                key TDMA.TankMaterialFromTimestamp,
                key TDMA.TankMaterialAssignmentCounter,
                
                TDMA.Material

Where       :   

Group       :   
CDS         :   I_TimeDepdntMatlAssign
Definition  :   Time Dependent Material Assignment to SOC

Using       :   inner join I_TimeDepdntMatlAssign as TDMA on TDMA.StorageObjSgmntNmbr       =  oib_tankdip.socnr
                                                         and TDMA.TankMaterialFromTimestamp <= oib_tankdip.etmstm
                                                         and TDMA.TankMaterialToTimestamp   >= oib_tankdip.etmstm

Fields      :   key TDMA.StorageObjSgmntNmbr,
                key TDMA.TankMaterialFromTimestamp,
                key TDMA.TankMaterialAssignmentCounter,
                
                TDMA.Material

Where       :   

Group       :   
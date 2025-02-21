CDS         :   I_MaintOrderOperation_DEX
Definition  :   Maintenance Order Operation Data

Using       :   as select from I_MaintOrderOperation_DEX as MOODEX " or MOODEX.MaintenanceOrder = I_MaintOrderTP.MaintenanceOrder

Fields      :   key MOODEX.MaintOrderRoutingNumber,
                key MOODEX.MaintenanceOrderRoutingNode,
                
                sum( case when MOODEX.OperationPlannedWorkUnit = 'MIN' then MOODEX.OperationPlannedWork
                          when MOODEX.OperationPlannedWorkUnit = 'H'   then MOODEX.OperationPlannedWork * 60 end ) as OperationPlannedWork_MIN

Where       :   MOODEX.OperationControlKey <> 'PMXX'  

Group       :   MOODEX.MaintenanceOrder
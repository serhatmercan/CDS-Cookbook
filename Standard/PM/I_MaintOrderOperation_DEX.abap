CDS         :   I_MaintOrderOperation_DEX
Description :   Maintenance Order Operation Data

Using       :   as select from I_MaintOrderOperation_DEX as MOODEX " or MOODEX.MaintenanceOrder = I_MaintOrderTP.MaintenanceOrder

Fields      :   key MOODEX.MaintOrderRoutingNumber,
                key MOODEX.MaintenanceOrderRoutingNode,
                
                sum( case when MOODEX.OperationPlannedWorkUnit = 'MIN' then MOODEX.OperationPlannedWork
                          when MOODEX.OperationPlannedWorkUnit = 'H'   then MOODEX.OperationPlannedWork * 60 end ) as OperationPlannedWork_MIN

Where       :   MOODEX.OperationControlKey <> 'PMXX'  

Group By    :   MOODEX.MaintenanceOrder

Module           :   PM
Business Object  :   Maintenance Order Operation
Common Use Cases :   - Maintenance order operation / planned work reporting, work unit normalization to minutes
Related CDS      :   I_MaintenanceOrderDEX, I_MaintTaskListOperation
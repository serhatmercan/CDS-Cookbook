CDS         :   I_MaintTaskListOperation
Description :   Maintenance Task List Operation

Using       :   as select from I_MaintTaskListOperation as MTLO

Fields      :   key MTLO.TaskListType,
                key MTLO.TaskListGroup,
                key MTLO.TaskListGroupCounter, 
                key MTLO.TaskListSequence,
                key MTLO.TaskListOperationInternalId,   

                    'MIN' as OpWorkQuantityUnitMIN,
                    
                    @Semantics.quantity.unitOfMeasure: 'OpWorkQuantityUnitMIN'
                    sum( case when MTLO.OpWorkQuantityUnit = 'MIN' then MTLO.OpPlannedWorkQuantity
                              when MTLO.OpWorkQuantityUnit = 'H'   then MTLO.OpPlannedWorkQuantity * 60 end ) as OpPlannedWorkQuan

Where       :   // Operation control profile scope is configuration:
                //   MTLO.OperationControlProfile <> '...'

Group By    :   MTLO.TaskListType,
                MTLO.TaskListGroup,
                MTLO.TaskListGroupCounter,
                MTLO.TaskListSequence,
                MTLO.TaskListOperationInternalId

Module           :   PM
Business Object  :   Maintenance Task List Operation
Common Use Cases :   - Task list / routing operation planned work analysis, work unit normalization to minutes
Related CDS      :   I_MaintenanceTaskList, I_MaintOrderOperation_DEX

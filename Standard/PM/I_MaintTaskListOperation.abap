CDS         :   I_MaintTaskListOperation
Definition  :   Maintenance Task List Operation

Using       :   as select from I_MaintTaskListOperation as MTLO

Fields      :   key MTLO.TaskListType,
                key MTLO.TaskListGroup,
                key MTLO.TaskListGroupCounter, 
                key MTLO.TaskListSequence,
                key MTLO.TaskListOperationInternalId,   

                    'MIN' as MTLO.OpWorkQuantityUnitMIN, 
                    
                    @DefaultAggregation: #SUM
                    sum( case when MTLO.OpWorkQuantityUnit = 'MIN' then MTLO.OpPlannedWorkQuantity
                              when MTLO.OpWorkQuantityUnit = 'H'   then MTLO.OpPlannedWorkQuantity * 60 end ) as OpPlannedWorkQuan

Where       :   MTLO.OperationControlProfile <> 'PMXX'

Group       :   MTLO.TaskListType, 
                MTLO.TaskListGroup, 
                MTLO.TaskListGroupCounter
CDS         :   I_WorkCenterHierStructure
Description :   Hierarchy Structure

Using       :   as select from I_WorkCenterHierStructure as WCHC

Fields      :   key WCHC.WrkCtrHierParentType,
                key WCHC.WrkCtrHierParentID,
                key WCHC.WrkCtrHierChildType,
                key WCHC.WrkCtrHierChildID,
                key WCHC.WrkCtrHierUpObjType,
                key WCHC.WrkCtrHierUpObjID            

Where       :   

Group       :   

Module           :   PP
Business Object  :   Work Center Hierarchy
Common Use Cases :   - Work center hierarchy navigation / parent-child structure reporting
Related CDS      :   I_WorkCenter
CDS         :   I_TechnicalObject
Description :   Technical Object

Using       :   as select from I_TechnicalObject as TObj

Fields      :   key TObj.TechnicalObject                  as Tplnr, 
                key TObj.TechObjIsEquipOrFuncnlLoc,

                    TObj.Equipment,
                    TObj.FunctionalLocation,
                    TObj.MaintObjectInternalID            as Objnr,
                    TObj.TechnicalObjectCategory,
                    TObj.TechnicalObjectType

Where       :   TObj.IsDeleted                    = ''            and
                TObj.TechObjIsEquipOrFuncnlLoc    = 'EAMS_FL'     and
                TObj.TechObjStatusIsInactive      = '' 
                

Group By    :   

Module           :   PM
Business Object  :   Technical Object (Equipment / Functional Location)
Common Use Cases :   - Unified technical object master data reporting across equipment and functional locations
Notes            :   - Where clause here filters to active, non-deleted functional locations only
Related CDS      :   I_Equipment, I_FunctionalLocation

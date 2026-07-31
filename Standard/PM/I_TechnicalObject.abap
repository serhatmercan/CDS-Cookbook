CDS         :   I_TechnicalObject
Description :   Technical Object

Using       :   as select from I_TechnicalObject as TO   

Fields      :   key TO.TechnicalObject                  as Tplnr, 
                key TO.TechObjIsEquipOrFuncnlLoc,

                    TO.Equipment,
                    TO.FunctionalLocation,
                    TO.MaintObjectInternalID            as Objnr,
                    TO.TechnicalObjectCategory,
                    TO.TechnicalObjectType

Where       :   TO.IsDeleted                    = ''            and
                TO.TechObjIsEquipOrFuncnlLoc    = 'EAMS_FL'     and
                TO.TechObjStatusIsInactive      = '' 
                

Group       :   

Module           :   PM
Business Object  :   Technical Object (Equipment / Functional Location)
Common Use Cases :   - Unified technical object master data reporting across equipment and functional locations
Notes            :   - Where clause here filters to active, non-deleted functional locations only
Related CDS      :   I_Equipment, I_FunctionalLocation
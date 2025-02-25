CDS         :   I_TechnicalObject
Definition  :   Technical Object

Using       :   as select from I_TechnicalObject as TO   

Fields      :   key TO.TechnicalObject, 
                key TO.TechObjIsEquipOrFuncnlLoc,

                    TO.Equipment,
                    TO.FunctionalLocation,
                    TO.TechnicalObjectCategory,
                    TO.TechnicalObjectType

Where       :   TO.TechObjIsEquipOrFuncnlLoc = 'EAMS_FL'   

Group       :   
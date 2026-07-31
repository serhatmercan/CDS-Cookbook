CDS         :   I_FunctionalLocation & I_FunctionalLocationLabel
Description :   Functional Location  & Functional Location Label

Using       :   as select from  I_FunctionalLocation            as FL  

                association [0..1] to I_FunctionalLocationLabel as _FLL on _FLL.FunctionalLocation = FL.TechnicalObject

Fields      :   key FL.FunctionalLocation                                                                       as TechnicalObject,

                    "Functional Location
                    FL.AuthorizationGroup,
                    FL.MaintObjectLocAcctAssgmtNmbr,
                    FL.MaintenancePlannerGroup,
                    FL.MaintenancePlanningPlant,
                    
                    FL._FunctionalLocationText[1:Language = $session.system_language].FunctionalLocationName,
                    FL._FunctionalLocationText,

                    FL._LocationAccountAssignment,

                    " Functional Location Label
                    cast( _FLL.FunctionalLocationLabelName as eams_tech_obj_conv )                              as TechnicalObjectLabel

Where       :   

Group       :   

Module           :   PM
Business Object  :   Functional Location
Associations Used:   _FunctionalLocationText, _LocationAccountAssignment, _FunctionalLocationLabel
Common Use Cases :   - Functional location master data reporting, EAM hierarchy navigation
Related CDS      :   I_Equipment, I_TechnicalObject, I_FunctionalLocationLabel
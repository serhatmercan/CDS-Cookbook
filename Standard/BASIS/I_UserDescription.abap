CDS         :   I_UserDescription
Description :   User Information

Using       :   as select from I_UserDescription as UD  

Fields      :   key UD.UserID,
                    
                    UD.UserDescription,
                    UD.IsTechnicalUser

Where       :   

Group       :

Module           :   BC (Basis)
Business Object  :   User
Common Use Cases :   - Resolve a user ID (e.g. created-by/changed-by) to its description/name and technical-user flag
Related CDS      :   I_CalendarDate
CDS         :   I_HCMCommunication
Description :   HCM Communication

Using       :   inner join I_HCMCommunication as HCM on HCM.HCMPersonnelNumber      = IHPA.parnr 
                                                    and HCM.HCMCommunicationType    = '0001'
                                                    and HCM.StartDate              <= $session.system_date
                                                    and HCM.EndDate                >= $session.system_date
                                                    and HCM.HCMCommunicationID      = $session.user   

Fields      :   key HCM.HCMPersonnelNumber,
                key HCM.HCMSubtype,
                key HCM.HCMObjectIdentification,
                key HCM.HCMRecordIsLocked,
                key HCM.EndDate,
                key HCM.StartDate,
                key HCM.HCMSequentialNumber

Where       :   

Group       :   
Module          :   HCM / PA (Personnel Administration - Communication, infotype 0105)
Business Object :   Employee Communication Data
Common Use Cases:   Resolve the current logged-on user ($session.user) to their personnel number via communication type '0001' (system user ID), for employee self-service "who am I" scenarios
Notes           :   StartDate/EndDate filter restricts to the communication record valid on the current system date
Related CDS     :   I_Employee
CDS         :   I_HCMCommunication
Definition  :   HCM Communication

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
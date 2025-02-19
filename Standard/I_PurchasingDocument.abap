CDS         :   I_PurchasingDocument
Definition  :   Purchasing Document

Using       :   left outer join I_PurchasingDocument as PD on PD.PurchasingDocument = $projection.NominationReferenceDocumentOq

Fields      :   key PD.PurchasingDocument,            
                    PD.CashDiscount1Days,           
                    PD.CompanyCode,                   
                    PD.DocumentCurrency,             
                    PD.IncotermsClassification,       
                    PD.IncotermsTransferLocation,     
                    PD.PaymentTerms,                  
                    PD.PurchasingDocumentCondition,   
                    PD.PurchasingOrganization,        
                    PD.PurchasingGroup 

Where       :   

Group       :   
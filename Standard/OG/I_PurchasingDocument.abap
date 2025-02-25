CDS         :   I_PurchasingDocument
Description :   Purchasing Document

Using       :   as select from I_PurchasingDocument     as PD   on PD.PurchasingDocument  = I_NominationLineItem.NominationReferenceDocument
                    inner join I_PurchasingDocumentItem as PDI  on PDI.PurchasingDocument = PD.PurchasingDocument

Fields      :   key PD.PurchasingDocument,
                key PD.PurchasingDocumentItem,

                    " Purchasing Document            
                    PD.CashDiscount1Days,           
                    PD.CompanyCode,                   
                    PD.DocumentCurrency,             
                    PD.IncotermsClassification,       
                    PD.IncotermsTransferLocation,     
                    PD.PaymentTerms,                  
                    PD.PurchasingDocumentCondition,
                    PD.PurchasingDocumentOrderDate,   
                    PD.PurchasingOrganization,          " Key (Optional)        
                    PD.PurchasingGroup,
                    PD.Supplier,
                    
                    " Purchasing Document Item
                    PDI.DocumentCurrency,
                    PDI.Material,

                    @Semantics.amount.currencyCode: 'DocumentCurrency'
                    PDI.NetAmount,
      
                    @Semantics.amount.currencyCode: 'DocumentCurrency'
                    PDI.NetPriceAmount,

                    PDI.Plant,
                    PDI.PurchasingDocumentItemText

Where       :   PD.PurchasingDocumentType = 'YN01' and  
                PD.PurchasingOrganization = '1200' and
                ( PDI.MaterialGroup = 'U002' or PDI.MaterialGroup = 'U003' or PDI.MaterialGroup = 'U006' )

Group       :   
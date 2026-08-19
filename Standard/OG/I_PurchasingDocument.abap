CDS         :   I_PurchasingDocument
Description :   Purchasing Document

Using       :   as select from I_PurchasingDocument     as PD   on PD.PurchasingDocument  = I_NominationLineItem.NominationReferenceDocument
                    inner join I_PurchasingDocumentItem as PDI  on PDI.PurchasingDocument = PD.PurchasingDocument

Fields      :   key PD.PurchasingDocument,
                key PD.PurchasingDocumentItem,

                    // Purchasing Document            
                    PD.CashDiscount1Days,           
                    PD.CompanyCode,                   
                    PD.DocumentCurrency,             
                    PD.IncotermsClassification,       
                    PD.IncotermsTransferLocation,     
                    PD.PaymentTerms,                  
                    PD.PurchasingDocumentCondition,
                    PD.PurchasingDocumentOrderDate,   
                    PD.PurchasingOrganization,          // Key (Optional)        
                    PD.PurchasingGroup,
                    PD.Supplier,
                    
                    // Purchasing Document Item
                    PDI.DocumentCurrency,
                    PDI.Material,

                    @Semantics.amount.currencyCode: 'DocumentCurrency'
                    PDI.NetAmount,
      
                    @Semantics.amount.currencyCode: 'DocumentCurrency'
                    PDI.NetPriceAmount,

                    PDI.Plant,
                    PDI.PurchasingDocumentItemText

Where       :   // Purchasing document type, organisation and material-group scope are
                // installation-specific and intentionally not hard-coded here. Add your own:
                //   PD.PurchasingDocumentType in ( ... ) and
                //   PD.PurchasingOrganization in ( ... ) and
                //   PDI.MaterialGroup         in ( ... )

Group By    :   

Module           :   MM
Business Object  :   Purchasing Document (header + item)
Common Use Cases :   - PO header/item enrichment for OG nomination reference-document reporting
                   (incoterms, payment terms, net price/amount, plant, material)
Notes            :   - Document type, purchasing organisation and material-group scope were all
                     installation configuration and are intentionally not hard-coded here.
Related CDS      :   I_PurchasingDocumentItem, I_PurchaseOrder, I_PurchaseOrderItem

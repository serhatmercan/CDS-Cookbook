CDS         :   I_SupplierQuotation
Description :   Supplier Quotation

Using       :   inner join I_SupplierQuotation as SQ on SQ.SupplierQuotation = Ekpo.Anfnr

Fields      :   key Ekpo.ebeln,
                key Ekpo.ebelp,
                key SQ.SupplierQuotation,   
                
                    SQ.RequestForQuotation

Where       :

Group By    :

Module           :   MM
Business Object  :   Supplier Quotation (RFQ response)
Common Use Cases :   - Linking a PO item (EKPO) back to the RFQ it originated from via Supplier Quotation
Related CDS      :   I_PurchaseOrderItem, C_PurOrdItemEnh

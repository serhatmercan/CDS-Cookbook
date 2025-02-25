CDS         :   I_SupplierQuotation
Definition  :   Supplier Quotation

Using       :   inner join I_SupplierQuotation as SQ on SQ.SupplierQuotation = Ekpo.Anfnr

Fields      :   key Ekpo.ebeln,
                key Ekpo.ebelp,
                key SQ.SupplierQuotation,   
                
                    SQ.RequestForQuotation

Where       :   

Group       :   
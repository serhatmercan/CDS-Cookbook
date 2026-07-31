CDS         :   I_ProductTrdClassfctn
Description :   Product Classfication

Using       :   left outer join I_ProductTrdClassfctn as PTC on PTC.Product               = VBRP.Matnr                              " or I_SupplierInvoiceItemPurOrdRef.PurchaseOrderItemMaterial
                                                            and PTC.TrdClassfctnNmbrSchm  = 'TR02'
                                                            and PTC.ValidityStartDate    <= I_BillingDocument.BillingDocumentDate   " or I_SupplierInvoice.PostingDate || $session.system_date
                                                            and PTC.ValidityEndDate      >= I_BillingDocument.BillingDocumentDate   " or I_SupplierInvoice.PostingDate || $session.system_date

Fields      :   key PTC.Product,
                key PTC.TrdClassfctnNmbrSchm,
                key PTC.ValidityStartDate,

                    PTC.TrdClassfctnNmbr        as GTIPNo

Where       :   

Group       :   

Module           :   SD / GTS (Foreign Trade / Global Trade Services)
Business Object  :   Product Trade Classification (commodity/HS code)
Common Use Cases :   - Retrieve a foreign-trade classification number for a material, valid on a
                   given (billing) document date, for tax/customs reporting
Notes            :   - TrdClassfctnNmbrSchm 'TR02' is a client-specific classification scheme (e.g.
                   Turkish GTIP code); validity dates compared against billing document date

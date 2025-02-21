CDS         :   I_ProductTrdClassfctn
Definition  :   Product Classfication

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
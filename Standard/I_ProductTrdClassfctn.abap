CDS         :   I_ProductTrdClassfctn
Definition  :   Product Classfication

Using       :   left outer join I_ProductTrdClassfctn as PTC on PTC.Product               = VBRP.Matnr
                                                            and PTC.TrdClassfctnNmbrSchm  = 'TR02'
                                                            and PTC.ValidityStartDate    <= I_BillingDocument.BillingDocumentDate
                                                            and PTC.ValidityEndDate      >= I_BillingDocument.BillingDocumentDate

Fields      :   key PTC.Product,
                key PTC.TrdClassfctnNmbrSchm,
                key PTC.ValidityStartDate,

                    PTC.TrdClassfctnNmbr

Where       :   

Group       :   
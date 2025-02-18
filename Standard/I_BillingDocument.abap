CDS         :   I_BillingDocument & I_BillingDocumentItem
Definition  :   Billing Document & Items

Using       :   as select from I_BillingDocument     as BD   
                    inner join I_BillingDocumentItem as BDI on BDI.BillingDocument     = $projection.VbelnVf
                                                           and BDI.BillingDocumentItem = $projection.PosnrVf

Fields      :   key BDI.BillingDocument                                                                                          as VbelnVf,
                key BDI.BillingDocumentItem                                                                                      as PosnrVf,

                    BD.BillingDocumentDate,
                    BD.BillingDocumentType,
                    
                    @Semantics.quantity.unitOfMeasure: 'BILLINGQUANTITYUNIT'
                    BDI.BillingQuantity,
                    BDI.BillingQuantityUnit,
                    
                    BD.DistributionChannel,
                    BD.Division,
                    BD.SDDocumentCategory,

                    BDI.BillingDocumentItemText                                                                                  as Arktx,
                    
                    BDI.BusinessArea                                                                                             as Gsber, 

                    BDI._BillingDocument.AccountingDocument                                                                      as Belnr,

                    BDI._BillingDocument.BillingDocumentDate                                                                     as Fkdat,
                    BDI._BillingDocument.BillingDocumentIsCancelled,                                                      
                    BDI._BillingDocument._BillingDocumentType.BillingDocumentType                                                as Fkart,
                    BDI._BillingDocument._BillingDocumentType._Text[Language = $session.system_language].BillingDocumentTypeName as FkartText,              
                    
                    BDI._BillingDocument.CancelledBillingDocument,
                    BDI._BillingDocument.CreationDate                                                                            as Erdat,
                    BDI._BillingDocument.CreatedByUser                                                                           as Ernam,

                    BDI._BillingDocument._CustomerGroup.CustomerGroup                                                            as Kdgrp,
                    BDI._BillingDocument._CustomerGroup._Text[Language = $session.system_language].CustomerGroupName             as KdgrpText,

                    BDI._BillingDocument.CustomerPaymentTerms                                                                    as Zterm,

                    BDI._BillingDocument._DistributionChannel.DistributionChannel                                                as Vtweg,
                    BDI._BillingDocument._DistributionChannel._Text[Language = $session.system_language].DistributionChannelName as VtwegText,

                    BDI._BillingDocument.DocumentReferenceID                                                                     as Xblnr,

                    BDI._BillingDocument.FiscalYear                                                                              as Gjahr,

                    BDI._BillingDocument.PayerParty                                                                              as Kunrg,
                    BDI._BillingDocument._PayerParty.CityName                                                                    as Ort01,
                    BDI._BillingDocument._PayerParty.DistrictName                                                                as Ort02,
                    BDI._BillingDocument._PayerParty.OrganizationBPName1                                                         as Name1,
                    BDI._BillingDocument._PayerParty.OrganizationBPName2                                                         as Name2,
                    BDI._BillingDocument._PayerParty.PostalCode                                                                  as Pstlz,
                    BDI._BillingDocument._PayerParty.TaxNumber1                                                                  as Stcd1,
                    BDI._BillingDocument._PayerParty.TaxNumber2                                                                  as Stcd2,

                    BDI._BillingDocument._PriceListType.PriceListType                                                            as Pltyp,
                    BDI._BillingDocument._PriceListType._Text[Language = $session.system_language].PriceListTypeName             as PltypText,

                    BDI._BillingDocument.SalesDistrict                                                                           as Bzirk,

                    BDI._BillingDocument._SalesOrganization.SalesOrganization                                                    as Vkorg,
                    BDI._BillingDocument._SalesOrganization._Text[Language = $session.system_language].SalesOrganizationName     as VkorgText,
                    
                    BDI._BillingDocument.SoldToParty                                                                             as Kunag,

                    @Semantics.amount.currencyCode: 'WAERK'
                    BDI._BillingDocument.TotalNetAmount                                                                          as Netwr,

                    BDI._BillingDocument.TransactionCurrency                                                                     as Waerk,
                    
                    @Semantics.quantity.unitOfMeasure: 'GEWEI'
                    BDI.ItemGrossWeight                                                                                          as Brgew,
                    BDI.ItemWeightUnit                                                                                           as Gewei,

                    @Semantics.quantity.unitOfMeasure: 'ITEMWEIGHTUNIT'
                    BDI.ItemNetWeight,
                    BDI.ItemWeightUnit,

                    @Semantics.quantity.unitOfMeasure: 'VOLEH'
                    BDI.ItemVolume                                                                                               as Volum,
                    BDI.ItemVolumeUnit                                                                                           as Voleh,

                    BDI.Material,
                    BDI.Plant,
                    
                    @Semantics.amount.currencyCode: 'WAERK'
                    BDI._PricingElement.ConditionAmount,

                    BDI._PricingElement.ConditionInactiveReason,
                    BDI._PricingElement.ConditionIsForStatistics,
                    BDI._PricingElement.ConditionType,

                    BDI.Product                                                                                                  as Matnr,
                    BDI._Product.BaseUnit                                                                                        as Meins,

                    BDI.ReturnItemProcessingType,
                    BDI.SalesDocument,      " Key
                    BDI.SalesDocumentItem,  " Key  

                    BDI._SalesDocument._ShippingType.ShippingType                                                                as Vsart,
                    BDI._SalesDocument._ShippingType._Text[Language = $session.system_language].ShippingTypeName                 as VsartText

Where       :       BD.BillingDocumentIsCancelled = ' ' and
                    BD.CancelledBillingDocument   = ' '    

Group       :                       

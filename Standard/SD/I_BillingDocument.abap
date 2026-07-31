CDS         :   I_BillingDocument & I_BillingDocumentItem
Description :   Billing Document & Items

Using       :   as select from I_BillingDocument     as BD                                                   " or BD.BillingDocument  = I_BillingDocumentItemPrcgElmnt.BillingDocument          
                    inner join I_BillingDocumentItem as BDI on BDI.BillingDocument     = $projection.VbelnVf " or BDI.BillingDocument = BD.BillingDocument
                                                           and BDI.BillingDocumentItem = $projection.PosnrVf

Fields      :   key BDI.BillingDocument                                                                                          as VbelnVf,
                key BDI.BillingDocumentItem                                                                                      as PosnrVf,

                    " Billing Document
                    BD.BillingDocumentDate,
                    BD.BillingDocumentIsCancelled,
                    BD.BillingDocumentType,
                    BD.CancelledBillingDocument,
                    BD.CompanyCode,
                    BD.DistributionChannel,
                    BD.Division,
                    BD.DocumentReferenceID,
                    BD.FiscalYear,
                    BD.PriceListType, 
                    BD.SalesOrganization,
                    BD.SDDocumentCategory,
                    
                    " Billing Document Items
                    @Semantics.quantity.unitOfMeasure: 'BILLINGQUANTITYUNIT'
                    BDI.BillingQuantity,
                    BDI.BillingQuantityUnit,

                    BDI.BillingDocumentItemText                                                                                  as Arktx,
                    BDI.BusinessArea                                                                                             as Gsber,
                    
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

                    BDI.Product                                                                                                  as Matnr,
                    BDI._Product.BaseUnit                                                                                        as Meins,

                    BDI.ReturnItemProcessingType,
                    BDI.SalesDocument,      " Key
                    BDI.SalesDocumentItem,  " Key 

                    " Billing Document Items -> Billing Document
                    BDI._BillingDocument.AccountingDocument                                                                      as Belnr,
                    BDI._BillingDocument.BillingDocumentDate                                                                     as Fkdat,
                    BDI._BillingDocument.BillingDocumentIsCancelled,
                    BDI._BillingDocument.CancelledBillingDocument,
                    BDI._BillingDocument.CreationDate                                                                            as Erdat,
                    BDI._BillingDocument.CreatedByUser                                                                           as Ernam,
                    BDI._BillingDocument.CustomerPaymentTerms                                                                    as Zterm,
                    BDI._BillingDocument.DocumentReferenceID                                                                     as Xblnr,
                    BDI._BillingDocument.FiscalYear                                                                              as Gjahr,
                    BDI._BillingDocument.PayerParty                                                                              as Kunrg,
                    BDI._BillingDocument.SalesDistrict                                                                           as Bzirk,
                    BDI._BillingDocument.SoldToParty                                                                             as Kunag,

                    @Semantics.amount.currencyCode: 'WAERK'
                    BDI._BillingDocument.TotalNetAmount                                                                          as Netwr,

                    BDI._BillingDocument.TransactionCurrency                                                                     as Waerk,
                    
                    " Billing Document Items -> Billing Document -> Billing Document Type
                    BDI._BillingDocument._BillingDocumentType.BillingDocumentType                                                as Fkart,
                    BDI._BillingDocument._BillingDocumentType._Text[Language = $session.system_language].BillingDocumentTypeName as FkartText,              
                    
                    " Billing Document Items -> Billing Document -> Customer Group
                    BDI._BillingDocument._CustomerGroup.CustomerGroup                                                            as Kdgrp,
                    BDI._BillingDocument._CustomerGroup._Text[Language = $session.system_language].CustomerGroupName             as KdgrpText,

                    " Billing Document Items -> Billing Document -> Distribution Channel
                    BDI._BillingDocument._DistributionChannel.DistributionChannel                                                as Vtweg,
                    BDI._BillingDocument._DistributionChannel._Text[Language = $session.system_language].DistributionChannelName as VtwegText,

                    " Billing Document Items -> Billing Document -> Payer Party                 
                    BDI._BillingDocument._PayerParty.CityName                                                                    as Ort01,
                    BDI._BillingDocument._PayerParty.DistrictName                                                                as Ort02,
                    BDI._BillingDocument._PayerParty.OrganizationBPName1                                                         as Name1,
                    BDI._BillingDocument._PayerParty.OrganizationBPName2                                                         as Name2,
                    BDI._BillingDocument._PayerParty.PostalCode                                                                  as Pstlz,
                    BDI._BillingDocument._PayerParty.TaxNumber1                                                                  as Stcd1,
                    BDI._BillingDocument._PayerParty.TaxNumber2                                                                  as Stcd2,

                    " Billing Document Items -> Billing Document -> Price List Type 
                    BDI._BillingDocument._PriceListType.PriceListType                                                            as Pltyp,
                    BDI._BillingDocument._PriceListType._Text[Language = $session.system_language].PriceListTypeName             as PltypText,

                    " Billing Document Items -> Billing Document -> Sales Organization 
                    BDI._BillingDocument._SalesOrganization.SalesOrganization                                                    as Vkorg,
                    BDI._BillingDocument._SalesOrganization._Text[Language = $session.system_language].SalesOrganizationName     as VkorgText,                    
                    
                    " Billing Document Items -> Pricing Element
                    @Semantics.amount.currencyCode: 'WAERK'
                    BDI._PricingElement.ConditionAmount,

                    BDI._PricingElement.ConditionInactiveReason,
                    BDI._PricingElement.ConditionIsForStatistics,
                    BDI._PricingElement.ConditionType,

                    " Billing Document Items -> Product
                    BDI._Product.ExternalProductGroup,
                    BDI._Product.ProductHierarchy,

                    " Billing Document Items -> Reference Delivery Document Item
                    BDI._ReferenceDeliveryDocumentItem.InventoryValuationType,

                    " Billing Document Items -> Sales Document
                    BDI._SalesDocument._ShippingType.ShippingType                                                                as Vsart,
                    BDI._SalesDocument._ShippingType._Text[Language = $session.system_language].ShippingTypeName                 as VsartText

Where       :       BD.AccountingTransferStatus   = 'C'     and
                    BD.BillingDocumentIsCancelled = ' '     and
                    BD.CancelledBillingDocument   = ' '     and
                    BD.CompanyCode                = '1000'  and 
                    BD.Division                   = '10'    and
                    BD.SalesOrganization          = '1200'  and
                    ( BD.SDDocumentCategory = 'M' or BD.SDDocumentCategory = 'O' ) and
                    BDI._ReferenceDeliveryDocumentItem.InventoryValuationType = 'PROC_TA_IM'

Group       :

Module           :   SD
Business Object  :   Billing Document
Associations Used:   _BillingDocumentType, _CustomerGroup, _DistributionChannel, _PayerParty, _PriceListType, _SalesOrganization, _PricingElement, _Product, _ReferenceDeliveryDocumentItem, _SalesDocument
Common Use Cases :   - Billing document / revenue reporting with header and item detail combined
Notes            :   - Where-clause hardcodes CompanyCode 1000, Division 10, SalesOrganization 1200 and AccountingTransferStatus 'C' (posted only) - limits reuse to that org unit
Related CDS      :   I_BillingDocumentItemBasic, I_BillingDocumentItemPrcgElmnt, I_SalesDocument, I_DeliveryDocument

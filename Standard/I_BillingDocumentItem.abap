CDS         : I_BillingDocumentItem
Definition  : Billing Document Item

Using       : I_BillingDocumentItem as _BDI on _BDI.BillingDocument     = $projection.vbeln_vf
                                           and _BDI.BillingDocumentItem = $projection.posnr_vf

Fields      : _BDI.BillingDocument                                                                                          as vbeln_vf,
              _BDI.BillingDocumentItem                                                                                      as posnr_vf,

              _BDI.BillingDocumentItemText                                                                                  as arktx,
              
              _BDI.BusinessArea                                                                                             as gsber, 

              _BDI._BillingDocument.AccountingDocument                                                                      as belnr,

              _BDI._BillingDocument.BillingDocumentDate                                                                     as fkdat,
              _BDI._BillingDocument.BillingDocumentIsCancelled,                                                      
              _BDI._BillingDocument._BillingDocumentType.BillingDocumentType                                                as fkart,
              _BDI._BillingDocument._BillingDocumentType._Text[Language = $session.system_language].BillingDocumentTypeName as fkart_text,              
              
              _BDI._BillingDocument.CancelledBillingDocument,
              _BDI._BillingDocument.CreationDate                                                                            as erdat,
              _BDI._BillingDocument.CreatedByUser                                                                           as ernam,

              _BDI._BillingDocument._CustomerGroup.CustomerGroup                                                            as kdgrp,
              _BDI._BillingDocument._CustomerGroup._Text[Language = $session.system_language].CustomerGroupName             as kdgrp_text,

              _BDI._BillingDocument.CustomerPaymentTerms                                                                    as zterm,

              _BDI._BillingDocument._DistributionChannel.DistributionChannel                                                as vtweg,
              _BDI._BillingDocument._DistributionChannel._Text[Language = $session.system_language].DistributionChannelName as vtweg_text,

              _BDI._BillingDocument.DocumentReferenceID                                                                     as xblnr,

              _BDI._BillingDocument.FiscalYear                                                                              as gjahr,

              _BDI._BillingDocument.PayerParty                                                                              as kunrg,
              _BDI._BillingDocument._PayerParty.CityName                                                                    as ort01,
              _BDI._BillingDocument._PayerParty.DistrictName                                                                as ort02,
              _BDI._BillingDocument._PayerParty.OrganizationBPName1                                                         as name1,
              _BDI._BillingDocument._PayerParty.OrganizationBPName2                                                         as name2,
              _BDI._BillingDocument._PayerParty.PostalCode                                                                  as pstlz,
              _BDI._BillingDocument._PayerParty.TaxNumber1                                                                  as stcd1,
              _BDI._BillingDocument._PayerParty.TaxNumber2                                                                  as stcd2,

              _BDI._BillingDocument._PriceListType.PriceListType                                                            as pltyp,
              _BDI._BillingDocument._PriceListType._Text[Language = $session.system_language].PriceListTypeName             as pltyp_text,

              _BDI._BillingDocument.SalesDistrict                                                                           as bzirk,

              _BDI._BillingDocument._SalesOrganization.SalesOrganization                                                    as vkorg,
              _BDI._BillingDocument._SalesOrganization._Text[Language = $session.system_language].SalesOrganizationName     as vkorg_text,
              
              _BDI._BillingDocument.SoldToParty                                                                             as kunag,

              @Semantics.amount.currencyCode: 'WAERK'
              _BDI._BillingDocument.TotalNetAmount                                                                          as netwr,

              _BDI._BillingDocument.TransactionCurrency                                                                     as waerk,
              
              @Semantics.quantity.unitOfMeasure: 'GEWEI'
              _BDI.ItemGrossWeight                                                                                          as brgew,
              _BDI.ItemWeightUnit                                                                                           as gewei,

              @Semantics.quantity.unitOfMeasure: 'VOLEH'
              _BDI.ItemVolume                                                                                               as volum,
              _BDI.ItemVolumeUnit                                                                                           as voleh,
              
              @Semantics.amount.currencyCode: 'WAERK'
              _BDI._PricingElement.ConditionAmount,

              _BDI._PricingElement.ConditionInactiveReason,
              _BDI._PricingElement.ConditionIsForStatistics,
              _BDI._PricingElement.ConditionType,

              _BDI.Product                                                                                                  as matnr,
              _BDI._Product.BaseUnit                                                                                        as meins,

              _BDI.ReturnItemProcessingType,

              _BDI._SalesDocument._ShippingType.ShippingType                                                                as vsart,
              _BDI._SalesDocument._ShippingType._Text[Language = $session.system_language].ShippingTypeName                 as vsart_text,

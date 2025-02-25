@AbapCatalog.sqlViewAppendName: 'ZSM_V_EXT_SFC_SALES'
@EndUserText.label: 'P_SOTFIELDCATALOG_SALES Extend View'

extend view P_SOTFIELDCATALOG_SALES with ZSM_I_EXT_SFC_SALES
{   
    " Sales Document Header
    _SalesDocument.CREATEDBYUSER                                                AS CreatedByUser, 
    _SalesDocument.CREATIONDATE                                                 AS OrderCreationDate, 
    _SalesDocument.CREATIONTIME                                                 AS OrderCreationTime, 
    _SalesDocument.PURCHASEORDERBYCUSTOMER                                      AS PurchaseOrderByCustomer,     
    _SalesDocument.SDDOCUMENTREASON                                             AS SDDocumentReason, 
    _SalesDocument.SOLDTOPARTY                                                  AS SoldToParty, 

    " Sales Document Header - Foreign Key
    _SalesDocument._DELIVERYBLOCKREASON.DELIVERYBLOCKREASON                     AS DeliveryBlockReason, 
    _SalesDocument._DISTRIBUTIONCHANNEL.DISTRIBUTIONCHANNEL                     AS DistributionChannel,
    _SalesDocument._ORGANIZATIONDIVISION.DIVISION                               AS Division, 
    _SalesDocument._SALESDOCUMENTTYPE.SALESDOCUMENTTYPE                         AS SDDocumentType, 
    _SalesDocument._SALESGROUP.SALESGROUP                                       AS SalesGroup, 
    _SalesDocument._SALESOFFICE.SALESOFFICE                                     AS SalesOffice, 
    _SalesDocument._SALESORGANIZATION.SALESORGANIZATION                         AS SalesOrganization, 
    _SalesDocument._SDDOCUMENTCATEGORY.SDDOCUMENTCATEGORY                       AS SDDocumentCategory, 
    _SalesDocument._SHIPPINGTYPE.SHIPPINGTYPE                                   AS ShippingType,

    " Sales Document Item        
    _SalesDocumentItem.COMPLETIONRULE                                           AS CompletionRule, 
    _SalesDocumentItem.DELIVERYDATEQUANTITYISFIXED                              AS DeliveryDateQuantityIsFixed, 
    _SalesDocumentItem.DELIVERYGROUP                                            AS DeliveryGroup, 
    _SalesDocumentItem.FASHIONCANCELDATE                                        AS FashionCancelDate, 
    _SalesDocumentItem.SALESDOCUMENTRJCNREASON                                  AS SalesDocumentRJCNReason,

    " Sales Document Item - Foreign Key
    _SalesDocumentItem._BATCH.BATCH                                             AS Batch, 
    _SalesDocumentItem._CUSTOMERGROUP.CUSTOMERGROUP                             AS CustomerGroup, 
    _SalesDocumentItem._DELIVERYPRIORITY.DELIVERYPRIORITY                       AS DeliveryPriority, 
    _SalesDocumentItem._ITEMCATEGORY.SALESDOCUMENTITEMCATEGORY                  AS ItemCategory, 
    _SalesDocumentItem._MATERIAL.MATERIAL                                       AS Material, 
    _SalesDocumentItem._MATERIALGROUP.MATERIALGROUP                             AS MaterialGroup, 
    _SalesDocumentItem._MATERIALSUBSTITUTIONREASON.MATERIALSUBSTITUTIONREASON   AS MaterialSubstitutionReason, 
    _SalesDocumentItem._ORIGINALLYREQUESTEDMATERIAL.MATERIAL                    AS OriginallyRequestedMaterial, 
    _SalesDocumentItem._PLANT.PLANT                                             AS Plant, 
    _SalesDocumentItem._SHIPPINGPOINT.SHIPPINGPOINT                             AS ShippingPoint, 
    _SalesDocumentItem._STORAGELOCATION.STORAGELOCATION                         AS StorageLocation, 

    " Product
    PRODUCTAVAILABILITYDATE                                                     AS ProductAvailabilityDate     
}

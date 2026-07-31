CDS         :   I_SalesDocumentScheduleLine
Description :   Sales Document Schedule Line

Module           :   SD
Business Object  :   Sales Document Schedule Line

Using       :   as select from I_SalesDocumentScheduleLine as SDSchedule

Fields      :   key SDSchedule.SalesDocument,
                key SDSchedule.SalesDocumentItem,
                key SDSchedule.ScheduleLine,

                DeliveryDate                                                                        as RequestedDeliveryDate,
                ProductAvailabilityDate,

                " Sales Document Schedule Line - Sales Document
                SDSchedule._SalesDocument.CreatedByUser,
                SDSchedule._SalesDocument.CreationDate,
                SDSchedule._SalesDocument.CreationTime,
                SDSchedule._SalesDocument.PurchaseOrderByCustomer,
                SDSchedule._SalesDocument.SDDocumentReason,
                SDSchedule._SalesDocument.SoldToParty,

                " Sales Document Schedule Line - Sales Document - Fields
                SDSchedule._SalesDocument._DeliveryBlockReason.DeliveryBlockReason,
                SDSchedule._SalesDocument._DistributionChannel.DistributionChannel,
                SDSchedule._SalesDocument._OrganizationDivision.Division,
                SDSchedule._SalesDocument._SalesDocumentType.SalesDocumentType,
                SDSchedule._SalesDocument._SalesGroup.SalesGroup,
                SDSchedule._SalesDocument._SalesOffice.SalesOffice,
                SDSchedule._SalesDocument._SalesOrganization.SalesOrganization,
                SDSchedule._SalesDocument._SDDocumentCategory.SDDocumentCategory,
                SDSchedule._SalesDocument._ShippingType.ShippingType,

                " Sales Document Schedule Line - Sales Document Item
                SDSchedule._SalesDocumentItem.CompletionRule,
                SDSchedule._SalesDocumentItem.DeliveryDateQuantityIsFixed,
                SDSchedule._SalesDocumentItem.DeliveryGroup,
                SDSchedule._SalesDocumentItem.FashionCancelDate,
                SDSchedule._SalesDocumentItem.SalesDocumentRjcnReason,

                " Sales Document Schedule Line - Sales Document Item - Fields
                SDSchedule._SalesDocumentItem._Batch.Batch,
                SDSchedule._SalesDocumentItem._CustomerGroup.CustomerGroup,
                SDSchedule._SalesDocumentItem._DeliveryPriority.DeliveryPriority,
                SDSchedule._SalesDocumentItem._ItemCategory.SalesDocumentItemCategory,
                SDSchedule._SalesDocumentItem._Material.Material,
                SDSchedule._SalesDocumentItem._MaterialGroup.MaterialGroup,
                SDSchedule._SalesDocumentItem._MaterialSubstitutionReason.MaterialSubstitutionReason,
                SDSchedule._SalesDocumentItem._OriginallyRequestedMaterial.Material,
                SDSchedule._SalesDocumentItem._Plant.Plant,
                SDSchedule._SalesDocumentItem._ShippingPoint.ShippingPoint,
                SDSchedule._SalesDocumentItem._StorageLocation.StorageLocation

Associations Used:   _SalesDocument, _SalesDocumentItem (and their onward navigations to type/org/material/plant texts)

Where       :

Group By    :

Common Use Cases :   - Requested vs. confirmed (ATP) delivery date reporting per schedule line

Related CDS      :   I_SalesDocument, P_ABOPStaticWhereConditionSls

Notes            :

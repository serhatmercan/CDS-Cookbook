CDS         :   I_PurchaseReqnChgDocAPI01                   & I_PurchaseReqnChgDocItmAPI01
Description :   Change Document for Purchase Requisition    & Change Document Item for Purchase Requisition

Using       :   as select from I_PurchaseReqnChgDocAPI01    as PRHeader
                    inner join I_PurchaseReqnChgDocItmAPI01 as PRItem   on PRItem.ChangeDocObject       = PRHeader.ChangeDocObject     
                                                                       and PRItem.ChangeDocObjectClass  = PRHeader.ChangeDocObjectClass 
                                                                       and PRItem.ChangeDocument        = PRHeader.ChangeDocument

Fields      :   key PRItem.ChangeDocObject,
                key PRItem.ChangeDocObjectClass,
                key PRItem.ChangeDocument,
                key PRItem.DatabaseTable,
                key PRItem.ChangeDocTableKey,
                key PRItem.ChangeDocDatabaseTableField,
                key PRItem.ChangeDocItemChangeType,   

                // PR Header
                PRHeader.CreatedByUser,

                max ( PRHeader.CreationDate ) as CreationDate,
                max ( PRHeader.CreationTime ) as CreationTime

Where       :   PRHeader.ChangeDocObjectClass      = 'BANF'  and 
                PRItem.ChangeDocDatabaseTableField = 'BANPR' and
                PRItem.ChangeDocItemChangeType     = 'U'     and 
                PRItem.ChangeDocNewFieldValue      = '03'    and
                PRItem.DatabaseTable               = 'EBAN' 

Group By    :   PRItem.ChangeDocObject,
                PRItem.ChangeDocObjectClass,
                PRItem.ChangeDocument,
                PRItem.DatabaseTable,
                PRItem.ChangeDocTableKey,
                PRItem.ChangeDocDatabaseTableField,
                PRItem.ChangeDocItemChangeType,
                PRHeader.CreatedByUser

Module           :   MM
Business Object  :   Purchase Requisition Change Document
Common Use Cases :   - Tracking changes to a specific PR field (here: release status field BANPR set to '03')
Notes            :   - Change document views expose CDHDR/CDPOS; filtering by object class and field is important for performance
Related CDS      :   I_PurchaseReqnChgDocItmAPI01, I_PurchaseRequisitionItemAPI01

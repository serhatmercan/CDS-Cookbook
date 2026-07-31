CDS         :   I_PurchaseOrderHistoryBasic
Description :   Purchase Order History

Using       :   as select from I_PurchaseOrderHistoryBasic as POHB

Fields      :   key POHB.PurchaseOrder,
                key POHB.PurchaseOrderItem,
              
                key case 
                         when POHB.PurchasingHistoryCategory = '6' then 'F'
                         when POHB.PurchasingHistoryCategory = '7' then 'P'
                         else '' 
                    end                                                                                     as Category,
              
                    concat('0', POHB.PurchaseOrderItem)                                                     as PurchaseOrderItemX,
                
                    POHB.PurchasingHistoryDocument,
                    POHB.PurchasingHistoryDocumentYear,
                    POHB.Currency,

                    @Semantics.amount.currencyCode: 'Currency'
                    cast( sum( case 
                                    when POHB.DebitCreditCode = 'H' then POHB.PurchaseOrderAmount * (-1)
                                    when POHB.DebitCreditCode = 'S' then POHB.PurchaseOrderAmount
                                end ) as abap.curr(13,2) )                                                  as PurchaseOrderAmount

Module           :   MM
Business Object  :   Purchase Order History (GR/IR)
Common Use Cases :   - Aggregating goods receipt / invoice receipt amounts per PO item, netting debit/credit sign
Related CDS      :   I_PurchaseOrderItem, I_PurchaseOrderHistoryAPI01
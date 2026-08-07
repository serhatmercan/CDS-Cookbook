CDS         :   I_SupplierInvoice   & I_SupplierInvoiceItemPurOrdRef
Description :   Supplier Invoice    & Supplier Invoice Item Purchase Order Reference

Module           :   MM (Invoice Verification / Logistics Invoice Verification)
Business Object  :   Supplier Invoice

Using       :   as select from  I_SupplierInvoice               as SIHeader
                    inner join  I_SupplierInvoiceItemPurOrdRef  as SIItem       on  SIItem.SupplierInvoice  = SIHeader.SupplierInvoice
                                                                               and  SIItem.FiscalYear       = SIHeader.FiscalYear
                left outer join I_MaterialText                  as MaterialText on  MaterialText.Material   = SIItem.PurchaseOrderItemMaterial
                                                                               and  MaterialText.Language   = 'T'

Fields      :   key SIItem.SupplierInvoice,
                key SIItem.FiscalYear,
                key SIItem.SupplierInvoiceItem,

                " Supplier Invoice
                SIHeader.DocumentCurrency,
                SIHeader.InvoicingParty,
                SIHeader.PostingDate,
                SIHeader.SupplierInvoiceIDByInvcgParty,

                " Supplier Invoice -> Supplier
                SIHeader.Supplier.SupplierName,
                SIHeader.Supplier.TaxNumber2,

                " Supplier Items
                SIItem.InventoryValuationType,

                SIItem.PurchaseOrderItemMaterial,
                MaterialText.MaterialName,

                @Semantics.amount.currencyCode: 'DocumentCurrency'
                SIItem.SupplierInvoiceItemAmount,

                @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
                SIItem.QuantityInPurchaseOrderUnit,
                SIItem.PurchaseOrderQuantityUnit,

                @Semantics.amount.currencyCode: 'DocumentCurrency'
                case SIItem.QuantityInPurchaseOrderUnit
                    when 0  then cast( 0 as abap.curr( 13, 2 ) )
                            else cast( division( cast( SIItem.SupplierInvoiceItemAmount as abap.dec(15,2) ), cast(SIItem.QuantityInPurchaseOrderUnit as abap.dec(13,3) ), 2 ) as abap.curr( 13, 2 ) )
                end as UnitPrice

Associations Used:

Where       :   SIHeader.CompanyCode           = '1000' and
                SIHeader.IsInvoice             = 'X'    and
                SIHeader.ReverseDocument       = ' '    and
                SIHeader.SupplierInvoiceStatus = '5'    and
                ( SIItem._Material.MaterialGroup = 'U007' or SIItem._Material.MaterialGroup = 'U008' )

Group By    :

Common Use Cases :   - Supplier invoice item reporting with PO-reference material and computed unit price

Related CDS      :   I_SupplierInvoiceItemPurOrdRef, C_PurOrdItemEnh

Notes            :   - Where-clause hardcodes CompanyCode 1000 and MaterialGroup U007/U008 - scoped to specific material groups; UnitPrice division guards against division by zero

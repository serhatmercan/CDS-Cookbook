CDS         :   sepm_sddl_so_invoice_header & sepm_sddl_so_invoice_item
Description :   Sales Order Invoice Header  & Sales Order Invoice Item

Using       :   as select from sepm_sddl_so_invoice_header as SOInvoiceHeader

                    left outer join sepm_sddl_so_invoice_item as SOInvoiceItem on SOInvoiceItem.sales_order_invoice_key = SOInvoiceHeader.sales_order_invoice_key        

Fields      :   key SOInvoiceHeader.sales_order_invoice_key                     as SalesOrderInvoiceKey,
                key SOInvoiceItem.sales_order_invoice_item_key                  as SalesOrderInvoiceItemKey,
                key SOInvoiceHeader.buyer.business_partner_id                   as CustomerID,                  " Optional

                    " Sales Order Invoice Header 
                    count( distinct SOInvoiceHeader.sales_order_invoice_key)    as InvoiceCount,

                    " Sales Order Invoice Header - Buyer                     
                    SOInvoiceHeader.buyer.address_key                           as AddressKey,
                    SOInvoiceHeader.buyer.company_name                          as CustomerName,

                    " Sales Order Invoice Item
                    SOInvoiceItem.currency_code                                 as CurrencyCode,
                    SOInvoiceItem.gross_amount                                  as GrossAmount,
                    SOInvoiceItem.net_amount                                    as NetAmount,
                    SOInvoiceItem.tax_amount                                    as TaxAmount,
                    SOInvoiceItem.quantity                                      as Quantity,                    

Where       :   SOInvoiceHeader.payment_status <> 'P'   

Group       :   SOInvoiceHeader.buyer.business_partner_id,
                SOInvoiceHeader.buyer.company_name,
                SOInvoiceHeader.buyer.address_key

Module           :   SD (SEPM - SAP EPM demo/training data model, not a productive standard view)
Business Object  :   Sales Order Invoice (demo)
Common Use Cases :   - Fiori/ABAP programming model tutorials and demo apps built on the SEPM flight/EPM sample data
Notes            :   - sepm_sddl_* views ship with the SAP EPM demo model, intended for learning purposes only
Related CDS      :   sepm_sddl_address
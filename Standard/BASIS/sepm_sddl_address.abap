CDS         :   sepm_sddl_address
Description :   Address

Using       :   association [1] to sepm_sddl_address as _Address on _Address.address_key = sepm_sddl_so_invoice_header.buyer.address_key

Fields      :   key _Address.address_key    as AddressKey,

                    _Address.street         as Street,
                    _Address.postal_code    as PostalCode,
                    _Address.city           as City,
                    _Address.country        as Country,
                    
                    _Address

Where       :   

Group       :   
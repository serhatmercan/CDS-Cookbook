CDS         :   A_BusinessPartner & I_BusinessPartner & A_BusinessPartnerTaxNumber 
Description :   Business Partner  & Business Partner  & Tax Number

Using       :   as select distinct from A_BusinessPartner as BP
                
                    association [1..1] to I_BusinessPartner             as _BPI     on _BPI.BusinessPartner     = BP.BusinessPartner
                    association [0..*] to A_BusinessPartnerTaxNumber    as _BPTax   on _BPTax.BusinessPartner   = BP.BusinessPartner
                                                                                   and _BPTax.BPTaxType         = $parameters.p_bp_tax_type   // configuration

Fields      :   key BP.BusinessPartner                  as InternalID,

                    // Business Partner
                    BP.BusinessPartnerFullName                                  as Title,
                    BP.BusinessPartnerGrouping                                  as Grouping,    
                    BP.BusinessPartnerIDByExtSystem                             as OldInternalID,
                    BP.BusinessPartnerIsBlocked,
                    BP.Customer,
                    BP.IsNaturalPerson,
                    BP.Supplier,

                    // Business Partner - Business Partner Address
                    BP._BusinessPartnerAddress.AdditionalStreetPrefixName,
                    BP._BusinessPartnerAddress.CityName,
                    BP._BusinessPartnerAddress.Country                          as Country,
                    BP._BusinessPartnerAddress.District,
                    BP._BusinessPartnerAddress.PostalCode,  
                    BP._BusinessPartnerAddress.StreetName,
                    BP._BusinessPartnerAddress.StreetPrefixName,
                    BP._BusinessPartnerAddress.StreetSuffixName,

                    // Email address and phone number are available through
                    // BP._BusinessPartnerAddress._EmailAddress / ._PhoneNumber.
                    // They are deliberately NOT projected here: do not expose contact
                    // data in a reporting view unless the use case requires it.

                    // Business Partner - Customer
                    BP._Customer.PostingIsBlocked,

                    // Business Partner - Customer - Customer Company
                    BP._Customer._CustomerCompany.CompanyCode                   as ParentCode,
  
                    // Business Partner - Customer - Customer Sales Area
                    BP._Customer._CustomerSalesArea.BillingIsBlockedForCustomer,
                    BP._Customer._CustomerSalesArea.DeliveryIsBlockedForCustomer,
                    BP._Customer._CustomerSalesArea.OrderIsBlockedForCustomer,

                    // Business Partner I
                    _BPI.BusinessPartnerSalutation                              as BaseID,

                    // Tax Number
                    _BPTax.BPTaxNumber


Where       :   // Grouping scope is configuration - add your own, e.g.
                // BP.BusinessPartnerGrouping between '...' and '...' and
                BP.Customer is not initial

Group By    :   
Module           :   MD / Cross-Application (Business Partner)
Business Object  :   Business Partner (Customer/Supplier)
Associations Used:   _BusinessPartnerAddress, _EmailAddress, _PhoneNumber, _Customer, _CustomerCompany, _CustomerSalesArea (standard BP associations)
                     _BPI -> I_BusinessPartner   on BusinessPartner = BusinessPartner
                     _BPTax -> A_BusinessPartnerTaxNumber   on BusinessPartner = BusinessPartner and BPTaxType = $parameters.p_bp_tax_type
Common Use Cases :   Flatten Business Partner + Customer + address/contact + tax number into a single row for customer master reporting
Notes            :   select distinct with 1:n address/email/phone/tax associations can still yield duplicate rows if a BP has more than one address, email, phone, or TR2 tax number
Related CDS      :   I_Customer, I_CustomerCompany, I_CustomerSalesArea

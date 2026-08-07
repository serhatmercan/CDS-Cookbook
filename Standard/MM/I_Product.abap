CDS         :   I_Product   & I_ProductDescription
Description :   Product     & Product Descriptions   

Using       :   inner join I_Product            as Product      on Product.Product      = I_EWM_InbDeliveryItemBasic.product
                inner join I_ProductDescription as ProductDesc  on ProductDesc.Product  = Product.Product
                                                               and ProductDesc.Language = 'T'

Fields      :   key Product.Product,
                    
                    Product.ProductOldID,
                    ProductDesc.ProductDescription

Where       :

Group By    :

Module           :   MM
Business Object  :   Product / Material
Common Use Cases :   - Product number and language-specific description lookup/enrichment
Related CDS      :   I_ProductBasicText, I_ProductPlant
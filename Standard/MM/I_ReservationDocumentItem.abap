CDS         :   I_ReservationDocumentItem
Description :   Reservation Document Item

Using       :   as select from I_ReservationDocumentItem as RDI

                left outer join t001w       as PlantDesc   on PlantDesc.Werks       = RDI.Plant
                left outer join iprddescr   as ProductDesc on ProductDesc.Product   = RDI.Product 
                                                          and ProductDesc.Language  = 'T'
                                        

Fields      :   key RDI.Reservation,
                key RDI.ReservationItem,
                key RDI.RecordType,

                    RDI.Plant,
                    PlantDesc.Name1                     as PlantDescription,

                    RDI.Product,
                    ProductDesc.ProductDescription,

                    RDI.StorageLocation    

Where       :   RDI.DebitCreditCode                = 'H' and 
                RDI.GoodsMovementIsAllowed         = 'X' and
                RDI.ReservationItemIsFinallyIssued = ''  and
                RDI.ReservationItmIsMarkedForDeltn = '' 

Group       :   
CDS         :   I_StorageLocationIndex
Description :   Index for Storage Location / Sequence No

Using       :   inner join I_StorageLocationIndex as SLI on SLI.Plant          = $projection.Plant
                                                        and SLI.Location       = $projection.Location
                                                        and SLI.SequenceNumber = $projection.SequenceNumber

Fields      :   @Consumption.valueHelpDefinition: [{
                  entity: {
                      name: 'I_Plant',
                      element: 'Plant'
                  }
                }]
                key SLI.Plant,

                @Consumption.valueHelpDefinition: [{
                  entity: {
                      name: 'I_StorageLocation',
                      element: 'StorageLocation'
                  }
                }]
                key SLI.Location,
                key SLI.SequenceNumber

Where       : 

Group       : 

Module           :   MM (Inventory Management) / OG
Business Object  :   Storage Location Index (Plant / Location / Sequence Number)
Common Use Cases :   - Value-help / key lookup for a Plant + Storage Location + Sequence Number
                   combination

CDS         :   I_StorageLocationIndex
Definition  :   Index for Storage Location / Sequence No

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
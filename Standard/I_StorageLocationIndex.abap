CDS         : I_StorageLocationIndex
Definition  : Index for Storage Location / Sequence No

Using       : I_StorageLocationIndex as _SLI on _SLI.Plant          = $projection.Plant
                                            and _SLI.Location       = $projection.Location
                                            and _SLI.SequenceNumber = $projection.SequenceNumber

Fields      : @Consumption.valueHelpDefinition: [{
                entity: {
                    name: 'I_Plant',
                    element: 'Plant'
                }
              }]
              key _SLI.Plant,

              @Consumption.valueHelpDefinition: [{
                entity: {
                    name: 'I_StorageLocation',
                    element: 'StorageLocation'
                }
              }]
              key _SLI.Location,
              key _SLI.SequenceNumber

Where       : 

Group       : 
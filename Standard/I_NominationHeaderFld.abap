CDS         : I_NominationHeaderFld
Definition  : Nomination Header Table Fields

Using       : I_NominationHeaderFld   as _NHF    on _NHF.NominationDoc = $projection.nominationDocOQ

              I_NominationVehicleIdVH as _NVHIVH on _NVHIVH.VehicleId  = $projection.VehicleId

Fields      : _NHF.NominationPipelineCycleID,
              _NHF.TransportSystem,

              _NHF.VehicleId,
              _NVHIVH.VehicleDescription            as VehicleDescription

Where       : 
Group       : 
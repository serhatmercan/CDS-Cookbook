CDS         :   I_MaintenanceOrderDEX
Definition  :   Maintenance Order Data

Using       :   inner join      I_MaintenanceOrderDEX       as MO               on MO.MaintenanceOrder                          = Aufk.Aufnr
                left outer join C_MaintOrdProcSubPhaseVH    as MOProcSubPhase   on MOProcSubPhase.MaintOrdProcessSubPhaseCode   = I_MaintenanceOrderDEX.MaintOrdProcessSubPhaseCode

Fields      :   key MO.MaintenanceOrder,   

                    MO.MaintOrdProcessSubPhaseCode              as SubPhase
                    MOProcSubPhase.EAMProcessSubPhaseCodeDesc   as SubPhaseDesc

Where       :   

Group       :   
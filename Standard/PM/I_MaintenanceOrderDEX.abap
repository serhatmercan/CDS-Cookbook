CDS         :   I_MaintenanceOrderDEX
Description :   Maintenance Order Data

Using       :   inner join      I_MaintenanceOrderDEX       as MO               on MO.MaintenanceOrder                          = Aufk.Aufnr
                left outer join C_MaintOrdProcSubPhaseVH    as MOProcSubPhase   on MOProcSubPhase.MaintOrdProcessSubPhaseCode   = I_MaintenanceOrderDEX.MaintOrdProcessSubPhaseCode

Fields      :   key MO.MaintenanceOrder,   

                    MO.MaintOrdProcessSubPhaseCode              as SubPhase,
                    MOProcSubPhase.EAMProcessSubPhaseCodeDesc   as SubPhaseDesc

Where       :   

Group By    :   

Module           :   PM
Business Object  :   Maintenance Order
Common Use Cases :   - Maintenance order process sub-phase status reporting
Notes            :   - DEX (data extraction) view; denormalized fields intended for embedded analytics
Related CDS      :   I_MaintOrderTP, I_MaintOrderOperation_DEX, C_MaintOrdProcSubPhaseVH

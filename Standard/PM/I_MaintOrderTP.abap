CDS         :   I_MaintOrderTP
Definition  :   Maintenance Order w/ Technical Object

Using       :   left outer join I_MaintOrderTP as MaintOrderTP on MaintOrderTP.MaintenanceOrder = I_MaintOrderOperation_DEX.MaintenanceOrder   

Fields      :   key MaintenanceOrder,

                    MaintOrder.MaintenancePlanningPlant,
                    MaintOrder.Equipment,
                    MaintOrder.MaintOrdMainWorkCenter,

Where       :   

Group       :   
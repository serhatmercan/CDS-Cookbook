CDS         :   I_MaintOrderTP
Description :   Maintenance Order w/ Technical Object

Using       :   left outer join I_MaintOrderTP as MaintOrderTP on MaintOrderTP.MaintenanceOrder = I_MaintOrderOperation_DEX.MaintenanceOrder   

Fields      :   key MaintOrderTP.MaintenanceOrder,

                    MaintOrderTP.MaintenancePlanningPlant,
                    MaintOrderTP.Equipment,
                    MaintOrderTP.MaintOrdMainWorkCenter

Where       :   

Group By    :   

Module           :   PM
Business Object  :   Maintenance Order
Common Use Cases :   - Maintenance order reporting enriched with technical object / work center attributes
Related CDS      :   I_MaintenanceOrderDEX, I_MaintOrderOperation_DEX

CDS         :   I_CalendarDate
Description :   Date

Using       :   association [0..1] to I_CalendarDate as _CalendarDate on _CalendarDate.CalendarDate = Sbook.Fldate

Fields      :   key _CalendarDate.CalendarDate,  

                    _CalendarDate.CalendarMonth,
                    _CalendarDate.CalendarYear

Where       :         

Group By    :

Module           :   CA / BC (Cross-Application, Basis)
Business Object  :   Calendar Date
Common Use Cases :   - Derive calendar month/year for a given date field (here Sbook.Fldate from the ABAP flight demo model)
Related CDS      :   I_UserDescription
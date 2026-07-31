CDS         :   P_ABOPStaticWhereConditionSls
Description :   ATP BOP Field Catalog for Sales Document Schedule Line

Module           :   SD (aATP - advanced Available-to-Promise / Backorder Processing)
Business Object  :   ATP Backorder Processing Static Where Condition

Using       :   inner join P_ABOPStaticWhereConditionSls as Static on Static.ATPRelevantDocument        = I_SalesDocumentScheduleLine.SalesDocument
                                                                  and Static.ATPRelevantDocumentItem    = I_SalesDocumentScheduleLine.SalesDocumentItem
                                                                  and Static.ATPRelevantDocScheduleLine = I_SalesDocumentScheduleLine.ScheduleLine

Fields      :

Associations Used:

Where       :

Group By    :

Common Use Cases :   - Join helper to restrict a sales schedule-line based query to items relevant for a Backorder Processing (BOP) run

Related CDS      :   I_SalesDocumentScheduleLine

Notes            :

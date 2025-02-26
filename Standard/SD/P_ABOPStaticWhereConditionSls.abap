CDS         :   P_ABOPStaticWhereConditionSls
Description :   ATP BOP Field Catalog for Sales Document Schedule Line

Using       :   inner join P_ABOPStaticWhereConditionSls as Static on Static.ATPRelevantDocument        = I_SalesDocumentScheduleLine.SalesDocument 
                                                                  and Static.ATPRelevantDocumentItem    = I_SalesDocumentScheduleLine.SalesDocumentItem 
                                                                  and Static.ATPRelevantDocScheduleLine = I_SalesDocumentScheduleLine.ScheduleLine    

Fields      :    

Where       :   

Group       :   
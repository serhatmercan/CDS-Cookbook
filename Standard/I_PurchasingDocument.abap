CDS         : I_PurchasingDocument
Definition  : Purchasing Document

Using       : I_PurchasingDocument as _PD on _PD.PurchasingDocument = $projection.NominationReferenceDocumentOq

Fields      : _PD.PurchasingDocument            as PurchasingDocument,
              _PD.CashDiscount1Days             as PaymentTermsDays,
              _PD.CompanyCode                   as CompanyCode,
              _PD.DocumentCurrency              as DocumentCurrency,
              _PD.IncotermsClassification       as IncotermsClassification,
              _PD.IncotermsTransferLocation     as IncotermsTransferLocation,
              _PD.PaymentTerms                  as PaymentTerms,
              _PD.PurchasingDocumentCondition   as PurchasingDocumentCondition,
              _PD.PurchasingOrganization        as PurchasingOrganization,
              _PD.PurchasingGroup               as PurchasingGroup
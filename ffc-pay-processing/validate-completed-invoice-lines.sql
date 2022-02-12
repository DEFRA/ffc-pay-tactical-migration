SELECT
    "description",
    COUNT("completedInvoiceLineId") AS "totalInvoiceLines",
    SUM("value") AS "totalValue"
FROM public."completedInvoiceLines"
GROUP BY "description"

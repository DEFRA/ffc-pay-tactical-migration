INSERT INTO public."completedInvoiceLines" (
    "completedPaymentRequestId", "accountCode", "fundCode", "description", "value", "schemeCode"
)
SELECT DISTINCT
    headers."completedPaymentRequestId",
    lines."accountCode",
    lines."fundCode",
    lines."description",
    lines."value",
    lines."schemeCode"
FROM public."invoiceLines" AS lines
INNER JOIN public."completedPaymentRequests" AS headers
    ON headers."paymentRequestId" = lines."paymentRequestId"
INNER JOIN public."tempLines" AS temp
    ON headers."invoiceNumber" = temp."Invoice Number"

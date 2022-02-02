INSERT INTO public."invoiceLines" (
    "paymentRequestId", "accountCode", "fundCode", "description", "value", "schemeCode"
)
SELECT DISTINCT
    headers."paymentRequestId",
    lines."MSDaxAccountCode",
    lines."Fund",
    lines."LineDescription",
    TRUNC(lines."Value" * 100, 0),
    lines."SchemeCode"
FROM public."tempHoldLines" AS lines
INNER JOIN public."paymentRequests" AS headers
    ON headers."invoiceNumber" = lines."InvoiceNumber"

INSERT INTO public."schedule" (
    "paymentRequestId", "planned"
)
SELECT DISTINCT
    headers."paymentRequestId",
    NOW()
FROM public."tempHoldHeaders" AS temp
INNER JOIN public."paymentRequests" AS headers
    ON headers."invoiceNumber" = temp."InvoiceNumber"

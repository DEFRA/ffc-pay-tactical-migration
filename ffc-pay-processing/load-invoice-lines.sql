INSERT INTO public."invoiceLines" (
    "paymentRequestId", "accountCode", "fundCode", "description", "value", "schemeCode"
)
SELECT DISTINCT
    headers."paymentRequestId",
    lines."MSDax Account Code",
    lines."Fund",
    lines."Line Type Description",
    TRUNC(lines."Value" * 100, 0),
    lines."Scheme"
FROM public."tempLines" AS lines
INNER JOIN public."paymentRequests" AS headers
    ON headers."invoiceNumber" = lines."Invoice Number"

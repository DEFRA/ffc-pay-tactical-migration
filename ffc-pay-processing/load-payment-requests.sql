INSERT INTO public."paymentRequests" (
    "schemeId", "sourceSystem", "deliveryBody", "invoiceNumber", "frn", "agreementNumber", "contractNumber", "currency", "schedule", "dueDate", "value", "received", "marketingYear", "paymentRequestNumber", "ledger"
)
SELECT DISTINCT
    2,
    headers."Creator ID",
    headers."Delivery Body",
    headers."Invoice Number",
    headers."FRN",
    lines."Agreement Number",
    headers."Claim Number",
    headers."Calculation Currency",
    headers."Payment Schedule",
    lines."Batch To Customer Date",
    TRUNC(headers."Value" * 100, 0),
    NOW(),
    lines."Marketing Year",
    headers."Request Number",
    'AP'
FROM public."tempHeaders" AS headers
INNER JOIN public."tempLines" AS lines
    ON headers."Invoice Number" = lines."Invoice Number"



INSERT INTO public."completedPaymentRequests" (
    "paymentRequestId", "schemeId", "ledger", "sourceSystem", "deliveryBody", "invoiceNumber", "frn", "agreementNumber", "contractNumber", "currency", "schedule", "dueDate", "value", "acknowledged", "marketingYear", "submitted", "paymentRequestNumber", "invalid", "correlationId", "referenceId"
)
SELECT DISTINCT
    headers."paymentRequestId",
    headers."schemeId",
    headers.ledger,
    headers."sourceSystem",
    headers."deliveryBody",
    headers."invoiceNumber",
    headers.frn,
    headers."agreementNumber",
    headers."contractNumber",
    headers.currency,
    headers.schedule,
    headers."dueDate",
    headers.value,
    NOW(),
    headers."marketingYear",
    NOW(),
    headers."paymentRequestNumber",
    false,
    CAST(headers."correlationId" AS UUID),
    CAST(headers."referenceId" AS UUID)
FROM public."paymentRequests" AS headers
INNER JOIN public."tempHeaders" AS temp
    ON headers."invoiceNumber" = temp."Invoice Number"



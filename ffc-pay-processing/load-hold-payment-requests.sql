INSERT INTO public."paymentRequests" (
    "schemeId", "sourceSystem", "deliveryBody", "invoiceNumber", "frn", "agreementNumber", "contractNumber", "currency", "schedule", "dueDate", "value", "received", "marketingYear", "paymentRequestNumber", "ledger", "correlationId", "referenceId"
)
SELECT DISTINCT
    2,
    'SFIP',
    headers."DeliveryBodyCode",
    headers."InvoiceNumber",
    headers."FRN",
    lines."AgreementNumber",
    headers."ClaimNumber",
    headers."CalculationCurrency",
    headers."PaymentSchedule",
    lines."BatchToCustomerDate",
    TRUNC(headers."TotalValue" * 100, 0),
    NOW(),
    lines."MarketingYear",
    headers."PaymentType",
    'AP',
    CAST(headers."correlationId" AS UUID),
    CAST(headers."referenceId" AS UUID)
FROM public."tempHoldHeaders" AS headers
INNER JOIN public."tempHoldLines" AS lines
    ON headers."Id" = lines."WithheldPayeeId"

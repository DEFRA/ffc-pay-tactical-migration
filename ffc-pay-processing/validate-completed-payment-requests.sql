SELECT
    COUNT("completedPaymentRequestId") AS "totalPaymentRequests",
    SUM("value") AS "totalValue"
FROM public."completedPaymentRequests"

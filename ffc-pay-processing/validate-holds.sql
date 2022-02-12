SELECT
    COUNT(p."paymentRequestId") AS "totalPaymentRequests",
    SUM(p."value") AS "totalValue"
FROM public."paymentRequests" p
LEFT JOIN public."completedPaymentRequests" c
    ON p."paymentRequestId" = c."paymentRequestId"
INNER JOIN public.holds h
    ON h.frn = p.frn
WHERE c."paymentRequestId" IS NULL
    AND h.closed IS NULL
    AND h."holdCategoryId" = 9

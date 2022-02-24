DELETE FROM public."completedInvoiceLines" WHERE "paymentRequestId" = 1;
DELETE FROM public."completedPaymentRequests" WHERE "paymentRequestId" = 1;

DELETE FROM public."invoiceLines" WHERE "paymentRequestId" = 1;
DELETE FROM public."paymentRequests" WHERE "paymentRequestId" = 1;

UPDATE public."debtData" SET "paymentRequestId" = NULL WHERE "paymentRequestId" = 1;
DELETE FROM public."qualityChecks" WHERE "paymentRequestId" = 1;
DELETE FROM public."invoiceLines" WHERE "paymentRequestId" = 1;
DELETE FROM public."paymentRequests" WHERE "paymentRequestId" = 1;

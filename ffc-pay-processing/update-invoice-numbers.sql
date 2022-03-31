UPDATE public."completedPaymentRequests"
SET "invoiceNumber" = 'S' || SUBSTRING("invoiceNumber", 5) || "contractNumber" || 'V001' 
WHERE LENGTH("invoiceNumber") = 11;

UPDATE public."paymentRequests"
SET "invoiceNumber" = 'S' || SUBSTRING("invoiceNumber", 5) || "contractNumber" || 'V001' 
WHERE LENGTH("invoiceNumber") = 11;

UPDATE public."completedPaymentRequests"
SET "dueDate" = to_char("dueDate"::date, 'DD/MM/YYYY')
WHERE "dueDate" LIKE '%-%';

UPDATE public."paymentRequests"
SET "dueDate" = to_char("dueDate"::date, 'DD/MM/YYYY')
WHERE "dueDate" LIKE '%-%';

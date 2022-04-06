CREATE TABLE "tempHeaders"
(  
  "ID" INTEGER,
  "File ID" INTEGER,
  "Line Type" VARCHAR,
  "Invoice Number" VARCHAR,
  "Request Number" INTEGER,
  "Claim Number" VARCHAR,
  "Payment Type" INTEGER,
  "FRN" BIGINT,
  "Calculation Currency" VARCHAR,
  "Value" NUMERIC(18, 2),
  "Delivery Body" VARCHAR,
  "Payment Preference Currency" VARCHAR,
  "Creator ID" VARCHAR,
  "Payment Schedule" VARCHAR,
  "correlationId" VARCHAR,
  "referenceId" VARCHAR
);

CREATE TABLE "tempLines"
(
  "ID" INTEGER,
  "File ID" INTEGER,
  "Line Type" VARCHAR,
  "Invoice Number" VARCHAR,
  "Value" NUMERIC(18, 2),
  "Marketing Year" INTEGER,
  "Scheme" VARCHAR,
  "Fund" VARCHAR,
  "Agreement Number" VARCHAR,
  "Delivery Body" VARCHAR,
  "Convergence" VARCHAR,
  "Line ID" INTEGER,
  "Line Type Description" VARCHAR,
  "Due Date" VARCHAR,
  "Batch To Customer Date" VARCHAR,
  "MSDax Account Code" VARCHAR
);

CREATE TABLE "tempHoldHeaders"
(  
  "Id" INTEGER,
  "WithheldBatchId" INTEGER,
  "BatchId" VARCHAR,
  "BatchFilename" VARCHAR,
  "LineType" VARCHAR,
  "InvoiceNumber" VARCHAR,
  "InvoiceVersion" INTEGER,
  "ClaimNumber" VARCHAR,
  "FRN" BIGINT,
  "PaymentType" INTEGER,
  "PaymentSchedule" VARCHAR,
  "TotalValue" NUMERIC(18, 2),
  "DeliveryBodyCode" VARCHAR,
  "PaymentPreferenceCurrency" VARCHAR,
  "CalculationCurrency" VARCHAR,
  "Reason" VARCHAR,
  "MarkedForRelease" INTEGER,
  "DateMarkedForRelease" VARCHAR,
  "Released" INTEGER,
  "DateReleased" VARCHAR,
  "correlationId" VARCHAR,
  "referenceId" VARCHAR
);

CREATE TABLE "tempHoldLines"
(
  "Id" INTEGER,
  "WithheldPayeeId" INTEGER,
  "LineType" VARCHAR,
  "InvoiceNumber" VARCHAR,
  "Value" NUMERIC(18, 2),
  "MarketingYear" INTEGER,
  "SchemeCode" VARCHAR,
  "Fund" VARCHAR,
  "AgreementNumber" VARCHAR,
  "DeliveryBodyCode" VARCHAR,
  "Convergence" VARCHAR,
  "LineNumber" INTEGER,
  "LineDescription" VARCHAR,
  "DueDate" VARCHAR,
  "BatchToCustomerDate" VARCHAR,
  "MSDaxAccountCode" VARCHAR 
);

CREATE TABLE "tempHolds"
(
  "FRN" BIGINT
);

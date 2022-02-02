
SELECT 
  i.*
FROM [DEFRA.Payments.SFI].[dbo].[WithheldInvoice] i
INNER JOIN [DEFRA.Payments.SFI].[dbo].WithheldPayee p
  ON i.WithheldPayeeId = p.Id
WHERE p.Released = 0

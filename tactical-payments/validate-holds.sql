SELECT COUNT([Id]) AS [TotalPaymentRequests]
    ,SUM([TotalValue]) AS [TotalValue]
FROM [DEFRA.Payments.SFI].[dbo].[WithheldPayee]
WHERE Released = 0

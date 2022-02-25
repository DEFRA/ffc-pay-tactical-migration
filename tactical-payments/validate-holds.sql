SELECT COUNT([Id]) AS [TotalPaymentRequests]
    ,SUM(CAST([TotalValue] AS DECIMAL(18, 2))) AS [TotalValue]
FROM [DEFRA.Payments.SFI].[dbo].[WithheldPayee]
WHERE Released = 0

-- NOTE that line 4 will need to change if running in environments other than production
SELECT COUNT([ID]) AS [TotalPaymentRequests]
    ,SUM(CAST([Value] AS DECIMAL(18, 2))) AS [TotalValue]
FROM [Transformation Layer (Production)].[Stage].[SITISFI AP Headers]

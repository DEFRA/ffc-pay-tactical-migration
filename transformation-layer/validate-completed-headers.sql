-- NOTE that line 4 will need to change if running in environments other than production
SELECT COUNT([ID]) AS [TotalPaymentRequests]
    ,SUM([Value]) AS [TotalValue]
FROM [Transformation Layer (Production)].[Stage].[SITISFI AP Headers]

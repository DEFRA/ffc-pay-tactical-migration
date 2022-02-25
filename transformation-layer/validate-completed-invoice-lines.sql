-- NOTE that line 16 will need to change if running in environments other than production
SELECT [Line Type Description]
    ,COUNT([ID]) AS [TotalInvoiceLines]
    ,SUM(CAST([Value] AS DECIMAL(18, 2))) AS [TotalValue]
FROM [Transformation Layer (Production)].[Stage].[SITISFI AP Lines]
GROUP BY [Line Type Description]

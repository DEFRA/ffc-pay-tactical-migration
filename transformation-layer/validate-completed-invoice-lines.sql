-- NOTE that line 16 will need to change if running in environments other than production
SELECT [Line Type Description]
    ,COUNT([ID]) AS [TotalInvoiceLines]
    ,SUM([Value]) AS [TotalValue]
FROM [Transformation Layer (Production)].[Stage].[SITISFI AP Lines]
GROUP BY [Line Type Description]

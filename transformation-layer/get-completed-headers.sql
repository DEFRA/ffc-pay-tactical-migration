-- NOTE that line 16 will need to change if running in environments other than production
SELECT [ID]
      ,[File ID]
      ,[Line Type]
      ,[Invoice Number]
      ,[Request Number]
      ,[Claim Number]
      ,[Payment Type]
      ,[FRN]
      ,[Calculation Currency]
      ,[Value]
      ,[Delivery Body]
      ,[Payment Preference Currency]
      ,[Creator ID]
      ,[Payment Schedule]
      ,NEWID() AS correlationId
      ,NEWID() AS referenceId
  FROM [Transformation Layer (Production)].[Stage].[SITISFI AP Headers]

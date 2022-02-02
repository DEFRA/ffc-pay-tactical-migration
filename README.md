# FFC Pay tactical data migration scripts
Migration scripts to support migration of tactical payment data to strategic.

## Process
This data migration is part of a wider migration strategy document in [Confluence](https://eaflood.atlassian.net/wiki/spaces/SFI/pages/3825860623/Tactical+to+strategic+payment+service+migration+plan)

The following steps should be executed in order to ensure data consistency.

### Extract completed payment requests from Transformation Layer

1. Connect to Production Transformation Layer SQL Server with SSMS
   
2. Execute [transformation-layer/get-completed-headers.sql](transformation-layer/get-completed-headers.sql)

3. Save results as CSV with name `tempHeaders.csv`

4. Execute [transformation-layer/get-completed-headers.sql](transformation-layer/get-completed-invoice-lines.sql)

5. Save results as CSV with name `tempLines.csv`

### Extract holds from tactical payment service

6. Connect to Production tactical payment SQL Server with SSMS

7. Execute [tactical-payments/get-hold-headers.sql](tactical-payments/get-hold-headers.sql)

8. Save results as CSV with name `tempHoldHeaders.csv`

9.  Execute [tactical-payments/get-hold-invoice-lines.sql](tactical-payments/get-hold-invoice-lines.sql)

10. Save results as CSV with name `tempHoldLines.csv`

11. Execute [tactical-payments/get-holds.sql](tactical-payments/get-holds.sql)

12. Save results as CSV with name `tempHolds.csv`

### Convert CSV files to PostgreSQL insert scripts
13. Clone repository https://github.com/johnwatson484/csv-to-postgresql with:
     ```
     git clone https://github.com/johnwatson484/csv-to-postgresql.git
     ```

14. Create required directories in root of repository with:    
    ```
    mkdir -p ./input
    mkdir -p ./output
    ```

15. Copy all CSV files to `input` directory

16. Run `node app/index.js`

17. Scripts will be output to the `output` directory

### Update Payment Processing

18. Connect to target FFC Azure PostgreSQL server using client of choice

19. Connect to `ffc-pay-processing` database

20. Execute generated script `tempHeaders.sql`

21. Execute generated script `tempLines.sql`

22. Execute generated script `tempHoldHeaders.sql`

23. Execute generated script `tempHoldLines.sql`

24. Execute generated script `tempHolds.sql`

25. Execute [ffc-pay-processing/create-temp-tables.sql](ffc-pay-processing/create-temp-tables.sql)

26. Execute [ffc-pay-processing/load-payment-requests.sql](ffc-pay-processing/load-payment-requests.sql)

27. Execute [ffc-pay-processing/load-invoice-lines.sql](ffc-pay-processing/load-invoice-lines.sql)

28. Execute [ffc-pay-processing/load-completed-payment-requests.sql](ffc-pay-processing/load-completed-payment-requests.sql)

29. Execute [ffc-pay-processing/load-completed-invoice-lines.sql](ffc-pay-processing/load-completed-invoice-lines.sql)

30. Execute [ffc-pay-processing/load-holds.sql](ffc-pay-processing/load-holds.sql)

31. Execute [ffc-pay-processing/load-hold-payment-requests.sql](ffc-pay-processing/load-hold-payment-requests.sql)

32. Execute [ffc-pay-processing/load-completed-invoice-lines.sql](ffc-pay-processing/load-hold-invoice-lines.sql)

33. Execute [ffc-pay-processing/create-hold-schedule.sql](ffc-pay-processing/create-hold-schedule.sql)

34. Execute [ffc-pay-processing/delete-temp-tables.sql](ffc-pay-processing/delete-temp-tables.sql)

### Update Payment Batch Processor

35. Connect to target FFC Azure PostgreSQL server using client of choice

36. Connect to `ffc-pay-batch-processor` database

37. Amend `next` sequence number in [ffc-pay-batch-processor/update-batch-sequence.sql](ffc-pay-batch-processor/update-batch-sequence.sql)

38. Execute [ffc-pay-batch-processor/update-batch-sequence.sql](ffc-pay-batch-processor/update-batch-sequence.sql)

### Update Payment Submission

39. Connect to target FFC Azure PostgreSQL server using client of choice

40. Connect to `ffc-pay-submission` database

41. Amend `nextAP` sequence number in [ffc-pay-submission/update-dax-sequence.sql](ffc-pay-submission/update-dax-sequence.sql)

42. Execute [ffc-pay-submission/update-dax-sequence.sql](ffc-pay-submission/update-dax-sequence.sql)

# FFC Pay tactical data migration scripts
Migration scripts to support migration of tactical payment data to strategic.

## Process
This data migration is part of a wider migration strategy document in [Confluence](https://eaflood.atlassian.net/wiki/spaces/SFI/pages/3825860623/Tactical+to+strategic+payment+service+migration+plan)

The following steps should be executed in order to ensure data consistency.

### Extract completed payment requests from Transformation Layer

1. Connect to Production Transformation Layer SQL Server with SSMS

2. Execute [transformation-layer/get-completed-headers.sql](transformation-layer/get-completed-headers.sql)

3. Save results as CSV with name `tempHeaders.csv`

4. Execute [transformation-layer/get-completed-invoice-lines.sql](transformation-layer/get-completed-invoice-lines.sql)

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

16. Run `npm run start` to run with Node.js or `./scripts/start -b` to run with Docker

17. Scripts will be output to the `output` directory

### Build return file for settlement data

18. Request settlement report from CPAT covering all SFI pilot payments

. Clone repository https://github.com/defra/ffc-pay-settlement-to-return-file with:
     ```
     git clone https://github.com/ffc-pay-settlement-to-return-file.git
     ```

19. Create required directories in root of repository with:
    ```
    mkdir -p ./input
    mkdir -p ./output
    ```

20. Copy all CPAT report files to `input` directory

21. Run `npm run start` to run with Node.js or `./scripts/start -b` to run with Docker
   
22. Return file will be output to the `output` directory

### Update Payment Processing

23. Connect to target FFC Azure PostgreSQL server using client of choice

24. Connect to `ffc-pay-processing` database

25. Execute [ffc-pay-processing/create-temp-tables.sql](ffc-pay-processing/create-temp-tables.sql)

26. Execute generated script `tempHeaders.sql`

27. Execute generated script `tempLines.sql`

28. Execute generated script `tempHoldHeaders.sql`

29. Execute generated script `tempHoldLines.sql`

30. Execute generated script `tempHolds.sql`

31. Execute [ffc-pay-processing/load-payment-requests.sql](ffc-pay-processing/load-payment-requests.sql)

32. Execute [ffc-pay-processing/load-invoice-lines.sql](ffc-pay-processing/load-invoice-lines.sql)

33. Execute [ffc-pay-processing/load-completed-payment-requests.sql](ffc-pay-processing/load-completed-payment-requests.sql)

34. Execute [ffc-pay-processing/load-completed-invoice-lines.sql](ffc-pay-processing/load-completed-invoice-lines.sql)

35. Execute [ffc-pay-processing/load-holds.sql](ffc-pay-processing/load-holds.sql)

36. Execute [ffc-pay-processing/load-hold-payment-requests.sql](ffc-pay-processing/load-hold-payment-requests.sql)

37. Execute [ffc-pay-processing/load-completed-invoice-lines.sql](ffc-pay-processing/load-hold-invoice-lines.sql)

38. Execute [ffc-pay-processing/create-hold-schedule.sql](ffc-pay-processing/create-hold-schedule.sql)

39. Execute [ffc-pay-processing/update-invoice-numbers.sql](ffc-pay-processing/update-invoice-numbers.sql)

40. Execute [ffc-pay-processing/update-due-dates.sql](ffc-pay-processing/update-due-dates.sql)

41. Execute [ffc-pay-processing/delete-temp-tables.sql](ffc-pay-processing/delete-temp-tables.sql)

### Update Payment Batch Processor

42. Connect to target FFC Azure PostgreSQL server using client of choice

43. Connect to `ffc-pay-batch-processor` database

44. Amend `next` sequence number in [ffc-pay-batch-processor/update-batch-sequence.sql](ffc-pay-batch-processor/update-batch-sequence.sql)

45. Execute [ffc-pay-batch-processor/update-batch-sequence.sql](ffc-pay-batch-processor/update-batch-sequence.sql)

### Update Payment Submission

46. Connect to target FFC Azure PostgreSQL server using client of choice

47. Connect to `ffc-pay-submission` database

48. Amend `nextAP` sequence number in [ffc-pay-submission/update-dax-sequence.sql](ffc-pay-submission/update-dax-sequence.sql)

49. Execute [ffc-pay-submission/update-dax-sequence.sql](ffc-pay-submission/update-dax-sequence.sql)

### Process return file

50. Navigate to Azure payment blob storage account

51. Upload return file created at `22` to `dax` container in `inbound` virtual directory

52. Within 1 minute, file should be consumed by `ffc-pay-responses` Kubernetes pod and moved to `archive` subdirectory

### Validate migration success

53. Connect to target FFC Azure PostgreSQL server using client of choice

54. Connect to `ffc-pay-processing` database

55. Execute [ffc-pay-processing/validate-completed-payment-requests.sql](ffc-pay-processing/validate-completed-payment-requests.sql)

56. Execute [ffc-pay-processing/validate-completed-invoice-lines.sql](ffc-pay-processing/validate-completed-invoice-lines.sql)

57. Execute [ffc-pay-processing/validate-holds.sql](ffc-pay-processing/validate-holds.sql)

58. Connect to Production Transformation Layer SQL Server with SSMS

59. Execute [transformation-layer/validate-completed-headers.sql](transformation-layer/validate-completed-headers.sql)

60. Compare output to step `52`, ignoring decimal place of value

61. Execute [transformation-layer/validate-completed-invoice-lines.sql](transformation-layer/validate-completed-invoice-lines.sql)

62. Compare output to step `55`, ignoring decimal place of value

63. Connect to Production tactical payment SQL Server with SSMS

64. Execute [tactical-payments/validate-holds.sql](tactical-payments/validate-holds.sql)

65. Compare output to step `56`, ignoring decimal place of value

66. Execute [tactical-payments/validate-settlement-values.sql](ffc-pay-processing/validate-settlement-values.sql)

67. Compare output to CPAT settlement report at `18`, ignoring decimal place of value

## Reset databases

In the event the migration needs to be reversed or to support creating a "clean" environment, the following scripts can be run.

- [ffc-pay-batch-processor](ffc-pay-batch-processor/reset.sql)
- [ffc-pay-processing](ffc-pay-processing/reset.sql)
- [ffc-pay-submission](ffc-pay-submission/reset.sql)
- [ffc-pay-request-editor](ffc-pay-request-editor/reset.sql)

## Delete single payment request

In the event a single payment request needs to be removed to support testing, then the following scripts can be run.

> They will need the `paymentRequestId` to be updated first.

- [ffc-pay-processing](ffc-pay-processing/delete-payment-request.sql)
- [ffc-pay-submission](ffc-pay-submission/delete-payment-request.sql)
- [ffc-pay-request-editor](ffc-pay-request-editor/delete-payment-request.sql)

# UC-11 Record traceability details (included by UC-02)

| Field | Content |
|-------|---------|
| **ID / slice** | UC-11 · S1 Receive delivery |
| **Level** | Subfunction (always included by UC-02 step 5) |
| **Primary actor** | Hub volunteer |
| **Stakeholders and interests** | Traceability coordinator and regulator: every allocated item can be traced to producer and batch (E-07, BR-03). Volunteer: receipt is not blocked by small producers' incomplete records (CON-03). |
| **Preconditions** | A receipt is open and a line is being recorded. |
| **Success guarantee** | The line's traceability details hold the producer, delivery date, and either a batch code or `batchMissing = true`; harvest and use-by dates are stored when supplied. |
| **Requirements / rules** | FR-05 · BR-03 · A-03 |
| **Gherkin** | GH-10 |

## Main success scenario

1. The system fills in the producer and delivery date from the receipt.
2. The volunteer enters the batch code.
3. The volunteer enters the harvest date and/or use-by date if the producer supplied them.
4. The system attaches the details to the line, to be copied onto its stock lot.

## Extensions

- **2a. No batch code supplied:** the volunteer marks the batch as missing; the system sets `batchMissing = true` and the line is flagged for follow-up.
- **3a. Use-by date is before the delivery date:** the system refuses the details (`INVALID_TRACE`) and the volunteer corrects or omits the date.

## Note for the contract owner

`INVALID_TRACE` is a new error code proposed by S1. It needs adding to the integration contract's error table (ENB-02) or replacing with an agreed code.
# UC-02 Receive delivery (fully dressed, CA2 revision)

| Field | Content |
|-------|---------|
| **ID / slice** | UC-02 · S1 Receive delivery |
| **Scope** | Kerry Local Food Hub Stock and Order System |
| **Level** | User goal |
| **Primary actor** | Hub volunteer (also hub staff member and hub manager by generalisation) |
| **Stakeholders and interests** | Hub manager: accurate accepted quantities and visible differences from expected (E-02). Producer: a fair record of what was delivered (E-03). Traceability coordinator: producer and batch captured at receipt (E-07). Customers: only checked goods are allocated (E-04). |
| **Trigger** | A producer's delivery arrives at the hub. |
| **Preconditions** | The actor is identified and has a role (NFR-05). The producer exists. Each product on the delivery exists and has a selling unit. |
| **Success guarantee** | Every received line has a received quantity, an outcome and traceability details. One stock lot exists per received line, with its accepted quantity available and its held quantity not available (BR-01). The receipt and every line outcome record who did it and when (NFR-05). |
| **Minimal guarantee** | No quantity becomes available unless an actor recorded it as accepted. Lines recorded before an interruption keep their outcomes. |
| **Requirements / rules** | FR-02, FR-03, FR-04, FR-05, FR-06 · BR-01, BR-03 · A-02, A-03, A-04 · NFR-04, NFR-05 |
| **Gherkin** | GH-01, GH-02, GH-06 to GH-12 (`features/receive_delivery.feature`) |

## Main success scenario

1. The volunteer identifies the producer and selects the matching expected delivery.
2. The system starts the receipt and lists the expected lines with products and expected quantities.
3. For a line, the volunteer enters the received quantity in the supplied unit.
4. The system converts it to the product's selling unit (FR-04, A-02).
5. The volunteer records the traceability details: batch code and, where supplied, harvest or use-by date (include UC-11).
6. The volunteer records the outcome *Accepted*.
7. The system creates a stock lot for the line with the accepted quantity available and the traceability details attached, and records who and when.
8. Steps 3–7 repeat for each line that arrived.
9. The volunteer completes the receipt.
10. The system records the receipt as complete with user and time, and returns a summary: available and held quantity per product, differences from expected, and lines needing batch follow-up.

## Extensions

- **1a. No expected delivery exists (unannounced):**
  1. The volunteer starts an unannounced receipt for the producer.
  2. For each product, the volunteer adds a line; the system creates it with no expected quantity. Continue at step 3.
- **3a. Received quantity differs from expected:** the system stores both and marks the difference for the manager summary (FR-13). Continue.
- **3b. A line did not arrive:** the volunteer skips it. At step 10 it is reported as *not received*; nothing is created.
- **4a. The product has no conversion for the supplied unit:** the system refuses the line (`INVALID_QUANTITY`) and the volunteer enters it in the selling unit.
- **5a. Batch information is missing (A-03):** the volunteer records that the batch is missing. The lot is created with `batchMissing = true` and the line is listed for follow-up at step 10. Continue.
- **6a. Only part of the line is acceptable:** the volunteer records *Partially accepted* with the accepted quantity. The remainder is held: the lot's accepted quantity is available and its held quantity is not (BR-01).
- **6b. Quality check cannot be completed now:** the volunteer records *Held* with a reason. The lot is created with the whole quantity held; UC-03 later releases or rejects it.
- **6c. A volunteer or staff member tries to record *Rejected* (A-04):** the system refuses (`NOT_PERMITTED`) and nothing changes. The actor records *Held* with a reason instead, and the manager decides in UC-03.
- **6d. The hub manager records *Rejected*:** the system records the outcome and reason; no stock lot is created.
- **6e. Accepted quantity is greater than received:** the system refuses (`INVALID_QUANTITY`) and nothing changes.
- **9a. The volunteer abandons the receipt:** lines already recorded keep their outcomes and lots; unrecorded lines stay *expected*. The receipt stays open and can be resumed. *(Changes CA1, see RC-07.)*

## Special requirements

- NFR-02: one line recorded in under 60 seconds after a 15-minute briefing.
- NFR-01: the volunteer sees no price or commercial terms on any step.

## Open issues

- Q-02 conversion factors per product are still assumptions (A-02).
- SPK-01 decides how partial acceptance is held in the model. This use case assumes one stock lot per received line with separate held and accepted quantities.
# Operation contracts – S1 Receive delivery

One contract per system event in `design/ssd/SSD-S1-receive-delivery.puml`. Every operation returns `Result<T>`; expected business failures are `Failure(code)` and change nothing. Error codes follow the integration contract §3, plus `INVALID_TRACE` (proposed by S1, see UC-11).

The actor's identity and role come from `AuditContext`; the time comes from `Clock`. Neither is passed as a parameter.

---

## OC-01 startReceipt

| Field | Content |
|-------|---------|
| **Operation** | `startReceipt(producerId: ProducerId, deliveryId: DeliveryId?): Result<ReceiptView>` |
| **Cross-references** | UC-02 steps 1–2, extension 1a · GH-06, GH-11 · FR-01 |
| **Preconditions** | The producer exists. If `deliveryId` is given, that delivery exists, belongs to the producer and is not complete. |
| **Postconditions** | *Expected delivery:* `delivery.receiptStartedAt` set to `Clock.now()`; `delivery.receivedBy` associated with the current user. *Unannounced (`deliveryId` absent):* a `Delivery` instance `d` was created with `unannounced = true`, `receivedDate = today`; `d` was associated with the producer; `d.receivedBy` was associated with the current user. |
| **Controlled failures** | `NOT_FOUND` – producer or delivery does not exist · `INVALID_STATE` – delivery belongs to another producer or is already complete (proposed code) |

## OC-02 addLine

| Field | Content |
|-------|---------|
| **Operation** | `addLine(deliveryId: DeliveryId, productId: ProductId): Result<DeliveryLineId>` |
| **Cross-references** | UC-02 extension 1a · GH-11 |
| **Preconditions** | The delivery exists, is unannounced and not complete. The product exists. |
| **Postconditions** | A `DeliveryLine` instance `dl` was created with no expected quantity; `dl` was associated with the delivery (composition) and with the product. |
| **Controlled failures** | `NOT_FOUND` – delivery or product · `INVALID_STATE` – delivery is announced or complete |

## OC-03 recordLineReceipt

| Field | Content |
|-------|---------|
| **Operation** | `recordLineReceipt(deliveryLineId: DeliveryLineId, supplied: Quantity, trace: TraceDetails, outcome: ReceiptOutcome, accepted: Quantity?, reason: String?): Result<LineReceiptResult>` |
| **Cross-references** | UC-02 steps 3–7, extensions 3a, 4a, 5a, 6a–6e · UC-11 · GH-01, GH-02, GH-06 to GH-10, GH-12 · FR-02 to FR-06 · BR-01, BR-03 · A-02, A-03, A-04 · NFR-04, NFR-05 |
| **Preconditions** | The line exists, belongs to an open receipt and has no outcome yet. |
| **Postconditions** | `dl.suppliedQuantity` = `supplied`; `dl.receivedQuantity` = `supplied` converted to the product's selling unit; `dl.outcome` = `outcome` (a *Partially accepted* line whose accepted quantity equals received is stored as *Accepted*); `dl.acceptedQuantity` set (= received for *Accepted*, = `accepted` for *Partially accepted*, = 0 for *Held* and *Rejected*); `dl.outcomeReason` = `reason`; `dl.recordedBy` associated with the current user and `dl.recordedAt` = `Clock.now()`. **Unless the outcome is *Rejected***: a `StockLot` instance `lot` was created; `lot.acceptedQuantity` = `dl.acceptedQuantity`; `lot.heldQuantity` = received − accepted; `lot.writtenOffQuantity` = 0; `lot.trace` = `trace` completed with producer and delivery date; `lot` was associated with `dl` (yields) and with the product. |
| **Controlled failures** | `NOT_FOUND` – line · `INVALID_STATE` – line already has an outcome or receipt is complete · `NOT_PERMITTED` – `outcome` is *Rejected* and the current role is not `MANAGER` (A-04) · `INVALID_QUANTITY` – supplied ≤ 0; no conversion from the supplied unit; *Partially accepted* with `accepted` ≤ 0 or > received; *Held* or *Rejected* with no `reason` · `INVALID_TRACE` – use-by date before delivery date, or batch code given and `batchMissing` true |
| **Invariant checked** | NFR-04: `lot.availableQuantity` (accepted − allocated − written off) ≤ `lot.acceptedQuantity`, and held quantity never counts as available (BR-01). |

## OC-04 completeReceipt

| Field | Content |
|-------|---------|
| **Operation** | `completeReceipt(deliveryId: DeliveryId): Result<ReceiptSummary>` |
| **Cross-references** | UC-02 steps 9–10, extensions 3a, 3b, 5a · GH-10 · FR-13 (data for) · NFR-05 |
| **Preconditions** | The delivery exists, its receipt was started and is not complete. |
| **Postconditions** | `delivery.status` = `COMPLETE`; `delivery.completedAt` = `Clock.now()`; `delivery.completedBy` associated with the current user. Lines with no outcome are marked `NOT_RECEIVED`. No stock lot was created or changed. |
| **Returns** | Per product: available and held quantity created by this receipt; lines whose received quantity differs from expected; lines not received; lines with `batchMissing`. |
| **Controlled failures** | `NOT_FOUND` – delivery · `INVALID_STATE` – receipt not started or already complete |

---

## Notes for other slices and the contract owner

- **S2 (Member B)** consumes `StockLot.heldQuantity` created here; quality release moves quantity from held to accepted.
- **Proposed additions to the integration contract (ENB-02):** `DeliveryId`, `DeliveryLineId`, `TraceDetails` (already listed), error codes `INVALID_STATE` and `INVALID_TRACE`, `ReceiptOutcome` enum (`ACCEPTED`, `PARTIALLY_ACCEPTED`, `HELD`, `REJECTED`), `DeliveryRepository` port (`findById`, `findLine`, `save`).
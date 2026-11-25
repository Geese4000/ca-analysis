# Operation contracts – S2 Release held stock

One contract per state-changing system event in `design/ssd/SSD-S2-release-held-stock.puml`. `listHeldLots` only reads data. Every operation returns `Result<T>`; a failure changes nothing. Error codes follow the S1 contracts and the integration contract.

The actor's identity and role come from `AuditContext`; the time comes from `Clock`.

---

## OC-05 recordQualityCheck

| Field | Content |
|-------|---------|
| **Operation** | `recordQualityCheck(lotId: StockLotId, released: Quantity, rejected: Quantity, reason: String?): Result<QualityCheckResult>` |
| **Cross-references** | UC-03 steps 3–5, extensions 1a, 3a, 4a–4e · GH-13 to GH-17 · FR-06 · BR-01, BR-03 · A-04, A-08 · NFR-04, NFR-05 · RC-01, RC-04, RC-06 |
| **Preconditions** | The actor is identified and has a role. |
| **Postconditions** | A `QualityCheck` instance `qc` was created; `qc.releasedQuantity` = `released`; `qc.rejectedQuantity` = `rejected`; `qc.reason` = `reason`; `qc.checkedAt` = `Clock.now()`; `qc` was associated with the stock lot and with the current user. `lot.heldQuantity` decreased by `released` + `rejected`; `lot.acceptedQuantity` increased by `released`; `lot.writtenOffQuantity` increased by `rejected`. The lot's trace details (producer, batch) are unchanged. |
| **Controlled failures** | `NOT_FOUND` – lot does not exist · `NOT_PERMITTED` – current role is `VOLUNTEER`, or `rejected` > 0 and the role is not `MANAGER` (A-04, RC-06) · `INVALID_STATE` – lot has no held quantity · `INVALID_QUANTITY` – `released` or `rejected` < 0; both are 0; `released` + `rejected` > held; `rejected` > 0 with no `reason` |
| **Invariant checked** | NFR-04 and BR-01: held quantity never counts as available; available = accepted − allocated − written off. |
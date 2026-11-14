# S1 – Receive delivery

| Field | Content |
|-------|---------|
| Owner | Philip Dawson-Gariepy |
| Reviewer | Member D |
| Use cases | UC-02 Receive delivery, UC-11 Record traceability details |
| Requirements / rules | FR-02, FR-03, FR-04, FR-05, FR-06 · BR-01, BR-03 · A-02, A-03, A-04 · NFR-04, NFR-05 |
| Gherkin | GH-01, GH-02, GH-06 to GH-12 (`features/receive_delivery.feature`) |
| Status | Proposed – for approval in the slice approval session |

## 1. System events

From `design/ssd/SSD-S1-receive-delivery.puml` and `design/contracts/OC-S1-receive-delivery.md`:

| Event | Contract |
|-------|----------|
| `startReceipt(producerId, deliveryId?)` | OC-01 |
| `addLine(deliveryId, productId)` | OC-02 |
| `recordLineReceipt(deliveryLineId, supplied, trace, outcome, accepted?, reason?)` | OC-03 |
| `completeReceipt(deliveryId)` | OC-04 |

## 2. Responsibilities

`ReceiveDeliveryHandler` is the use-case controller; it holds no rules. `Delivery` is the aggregate root and completes trace details; `DeliveryLine` validates and creates the `StockLot`; `ReceiptOutcome` owns the rejection rule; `Product` owns unit conversion. Full rationale: `design/crc/CRC-S1-receive-delivery.md`.

## 3. Output

- `LineReceiptResult`: received quantity in selling unit, available quantity, held quantity, stock lot id (none if rejected).
- `ReceiptSummary`: per product available and held, differences from expected, lines not received, lines needing batch follow-up.
- Failures: `NOT_FOUND`, `NOT_PERMITTED`, `INVALID_QUANTITY`, `INVALID_TRACE`, `INVALID_STATE`. A failure changes nothing.

## 4. Business rules enforced

| Rule | Where enforced | Test |
|------|----------------|------|
| BR-01 held goods are not available | `StockLot.availableQuantity()` excludes `held` | GH-01, GH-02; unit test on StockLot |
| BR-03 lot linked to producer and batch | `Delivery.recordLine` completes `TraceDetails`; lot keeps it | GH-06, GH-10 |
| A-03 receipt not blocked by missing batch | `TraceDetails.batchMissing`; summary lists follow-ups | GH-10 |
| A-04 only manager rejects | `ReceiptOutcome.permittedFor(role)` | GH-07, GH-08 |
| NFR-04 accepted ≤ received, > 0 when partial | `DeliveryLine.validateAccepted` | GH-09 outline |
| FR-04 / A-02 conversion to selling unit | `Product.toSellingUnit` | GH-12 |
| NFR-05 who and when | `recordedBy`/`recordedAt` from `AuditContext` and `Clock` | GH-06 |

## 5. Interfaces

| Port | Consumed or provided | Contract section |
|------|----------------------|------------------|
| `DeliveryRepository` | Consumed | Proposed addition to §4 |
| `ProducerRepository` | Consumed | Proposed addition to §4 |
| `StockLotRepository` | Consumed (`save`) | §4 |
| `AuditContext`, `Clock` | Consumed | §4 |
| Stock lots created | **Provided** to S2 and S3 through `StockLotRepository` / `StockQueryPort` | §4 |

## 6. Dependencies and independent fallback

S1 depends on no other slice. It is the upstream producer of stock lots.

| Dependency | Fallback |
|------------|----------|
| Persistence | `InMemoryDeliveryRepository`, `InMemoryStockLotRepository`, `InMemoryProducerRepository` |
| Time | `FixedClock` set to 2026-11-14 09:30 |
| Identity / role | `FixedAuditContext` (Aoife, VOLUNTEER) and (Niamh, MANAGER) |

## 7. Fixtures and seed data

Owned by S1, in `src/test/resources/fixtures/s1/`:

- Producers: Ballyheigue Greens, Lispole Hens.
- Products: Rooster potatoes (kg, no conversion), Free-range eggs (each, 1 box = 12 each).
- Deliveries: Ballyheigue Greens expected today, 1 line, 20 kg Rooster potatoes; Lispole Hens expected today, 1 line, 5 box Free-range eggs.

## 8. Test plan

- **Unit tests (domain):** `ReceiptOutcome.permittedFor` for all four roles × outcomes; `DeliveryLine.recordReceipt` for each outcome and the GH-09 boundaries; `Product.toSellingUnit` with and without a conversion; `TraceDetails.validate` (use-by before delivery, batch code with batch missing); `StockLot.availableQuantity` never includes held.
- **BDD:** all scenarios in `features/receive_delivery.feature` run through `ReceiveDeliveryHandler` with in-memory fakes.
- **Failure cases:** completing a receipt twice; recording a line twice; adding a line to an announced delivery.

## 9. Demonstration route

1. `mvn test` (or the agreed DR-004 test command) runs the unit tests and every S1 Gherkin scenario.
2. A console runner `ReceiveDeliveryDemo` plays the Ballyheigue Greens delivery: partial acceptance of 15 of 18 kg, then prints the receipt summary showing 15 kg available and 3 kg held.

## 10. Design artefacts

| Artefact | File |
|----------|------|
| Fully dressed use cases | `analysis/use-cases/UC-02-receive-delivery.md`, `UC-11-record-traceability-details.md` |
| SSD | `design/ssd/SSD-S1-receive-delivery.puml` |
| Operation contracts | `design/contracts/OC-S1-receive-delivery.md` |
| CRC | `design/crc/CRC-S1-receive-delivery.md` |
| Sequence diagrams | `design/sequence/SD-S1-record-line-receipt.puml`, `SD-S1-complete-receipt.puml` |
| Class fragment for the DCD | `design/DCD-fragment-S1.puml` |
# CA2 Traceability Matrix

One row per selected use case, following the chain backlog → use case/Gherkin → SSD → operation contract → CRC/GRASP → object-interaction sequence → design classes. Requirement-level traceability from CA1 is in [report/06-traceability.md](../report/06-traceability.md) and is not repeated here.

Status: **Done** = reviewed and merged · **Draft** = on a branch or awaiting review · **To do** = not started.

## Matrix

| Use case | Backlog | Requirements / rules | Gherkin | SSD | Contracts | CRC / GRASP | Sequence diagrams | Design classes | Owner / reviewer | Status |
|----------|---------|----------------------|---------|-----|-----------|-------------|-------------------|----------------|------------------|--------|
| [UC-02 Receive delivery](use-cases/UC-02-receive-delivery.md) + [UC-11](use-cases/UC-11-record-traceability-details.md) | US-01, US-02 · DES-06, DES-08, DES-09, DES-11, DES-19 | FR-02 to FR-06 · BR-01, BR-03 · A-02, A-03, A-04 · NFR-04, NFR-05 | [GH-01, GH-02, GH-06 to GH-12](../features/receive_delivery.feature) | [SSD-S1](../design/ssd/SSD-S1-receive-delivery.puml) | [OC-01 to OC-04](../design/contracts/OC-S1-receive-delivery.md) | [CRC-S1](../design/crc/CRC-S1-receive-delivery.md) · [DR-005](../decisions/DR-005-receive-delivery-controller.md) Controller · [DR-006](../decisions/DR-006-stock-lot-creator.md) Creator | [SD-S1a](../design/sequence/SD-S1-record-line-receipt.puml), [SD-S1b](../design/sequence/SD-S1-complete-receipt.puml), [SD-S1c](../design/sequence/SD-S1-start-receipt.puml) | [DCD-fragment-S1](../design/DCD-fragment-S1.puml): ReceiveDeliveryHandler, Delivery, DeliveryLine, ReceiptOutcome, StockLot, TraceDetails, Product | Philip / Zak | Done (DEF-01 open) |
| UC-03 Release held stock | US-02 · DES-06, DES-08 | FR-06 · BR-01, BR-03 · A-04, A-08 · NFR-04, NFR-05 · RC-01, RC-04, RC-06 | GH-13 to GH-17 (`features/release_held_stock.feature`) | SSD-S2 (`design/ssd/SSD-S2-release-held-stock.puml`) | OC-05 – to do | CRC-S2 – to do · DR-007 Expert (StockLot guards held vs available) – to do | SD-S2 – to do | StockLot, QualityCheck, ReleaseHeldStockHandler – to do | Danil / Philip | Draft (branch `design/s2-stock-decisions`) |
| UC-05 Allocate stock (+ UC-09 Trace item) | US-05 | FR-07, FR-09, FR-12 · BR-01, BR-03 · NFR-04 | [GH-03, GH-04](../features/allocate_stock.feature), [GH-05](../features/trace_item.feature) (CA1, to revise) | – to do | – to do | – to do | – to do | Allocation, OrderLine, StockLot – to do | Alex / Danil | To do |
| UC-06 Handle shortfall | US-03, US-04 · SPK-02 | FR-08, FR-10 · BR-05 · RC-02 | — | — | — | — | — | — | — | **Descoped** ([DR-011](../decisions/DR-011-scope-three-use-cases.md)) |

Links for UC-03 to UC-06 are added when each branch is merged, so every link points to a file in the submitted repository.

## Consistency evidence – UC-02

Every message in the UC-02 sequence diagrams maps to an operation in the design classes and realises a contract effect.

| Message (sequence diagram) | Receiver and DCD operation | Realises |
|----------------------------|----------------------------|----------|
| `recordLineReceipt(deliveryLineId, …)` (SD-S1a, first message) | `ReceiveDeliveryHandler.recordLineReceipt` | SSD-S1 system event; OC-03 |
| `findByLine(deliveryLineId)` | `DeliveryRepository.findByLine` | OC-03 `NOT_FOUND` failure |
| `recordLine(…)` | `Delivery.recordLine` | Routes to the line; Delivery is aggregate root (DR-005) |
| `completedWith(producerId, receivedDate)` | `TraceDetails.completedWith` | OC-03 `lot.trace` completed with producer and date; UC-11; `INVALID_TRACE` failure |
| `permittedFor(role)` | `ReceiptOutcome.permittedFor` | OC-03 `NOT_PERMITTED` failure (A-04) |
| `toSellingUnit(supplied)` | `Product.toSellingUnit` | OC-03 `receivedQuantity` set (FR-04) |
| `validateAccepted(received, accepted)` | `DeliveryLine.validateAccepted` | OC-03 `INVALID_QUANTITY` failure (NFR-04) |
| `<<create>> StockLot(…)` | `StockLot` constructor, called by `DeliveryLine` | OC-03 "a StockLot was created … associated with dl" (DR-006) |
| `save(lot)`, `save(d)` | `StockLotRepository.save`, `DeliveryRepository.save` | Persistence boundary; only on success, so failures change nothing |
| `complete(user, now)` (SD-S1b) | `Delivery.complete` | OC-04 status `COMPLETE`, `completedBy`, `completedAt` |
| `startUnannounced(…)` (SD-S1c) | `Delivery.startUnannounced` | OC-01 unannounced delivery created |
| `addLine(p)` → `<<create>> DeliveryLine(p)` (SD-S1c) | `Delivery.addLine`, `DeliveryLine` constructor | OC-02 line created and associated |

Each owner adds the same table for their use case before their design is marked Done.
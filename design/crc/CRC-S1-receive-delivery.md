# CRC / responsibility model – S1 Receive delivery

Bring these cards to the CRC workshop (DES-10). Each card lists what the class **knows**, what it **does**, and who it **collaborates** with. The GRASP rationale for each placement is recorded below the cards.

## Cards

### ReceiveDeliveryHandler *(application layer)*

| Knows | Does | Collaborators |
|-------|------|---------------|
| The ports it was given | Receives the four S1 system events and coordinates them; loads and saves aggregates; turns domain results into `Result<T>` DTOs | DeliveryRepository, ProducerRepository, StockLotRepository, AuditContext, Clock, Delivery |

### Delivery *(domain)*

| Knows | Does | Collaborators |
|-------|------|---------------|
| Producer, expected date, received date, `unannounced`, status, who started and completed the receipt, its lines | Starts a receipt; adds a line (unannounced only); routes a line receipt to the right line and completes its trace details with producer and date; completes the receipt and builds the `ReceiptSummary` | DeliveryLine, TraceDetails, ReceiptSummary |

### DeliveryLine *(domain)*

| Knows | Does | Collaborators |
|-------|------|---------------|
| Product, expected, supplied, received and accepted quantities, outcome, reason, recorded by / at | Validates a receipt (permission, quantities); converts supplied to received; sets its outcome; **creates** the StockLot | Product, ReceiptOutcome, Quantity, StockLot |

### ReceiptOutcome *(domain enum)*

| Knows | Does | Collaborators |
|-------|------|---------------|
| `ACCEPTED`, `PARTIALLY_ACCEPTED`, `HELD`, `REJECTED` | Answers `permittedFor(role)` (A-04) and `createsLot()` | Role |

### Product *(domain)*

| Knows | Does | Collaborators |
|-------|------|---------------|
| Name, selling unit, conversion factor per supplied unit (A-02) | Converts a supplied quantity to its selling unit, or reports that no conversion exists | Quantity |

### StockLot *(domain)*

| Knows | Does | Collaborators |
|-------|------|---------------|
| Product, accepted, held and written-off quantities, trace details | Reports `availableQuantity()` = accepted − allocated − written off; never counts held (BR-01, NFR-04) | TraceDetails, Quantity |

### TraceDetails *(value object)*

| Knows | Does | Collaborators |
|-------|------|---------------|
| Producer, delivery date, batch code or `batchMissing`, harvest date, use-by date | Validates itself (use-by not before delivery; batch code xor missing); returns a copy completed with producer and date | — |

### ReceiptSummary *(output DTO)*

| Knows | Does | Collaborators |
|-------|------|---------------|
| Available and held quantity per product, differences from expected, lines not received, lines needing batch follow-up | — (data only) | — |

## GRASP rationale

| Decision | Principle | Why |
|----------|-----------|-----|
| One `ReceiveDeliveryHandler` per use case, not one `HubController` | **Controller** (use-case controller) | Keeps S1 independent of S2–S4 and avoids a God controller. It holds no business rules: every rule lives in a domain class. |
| `DeliveryLine` checks accepted ≤ received and sets the outcome | **Information Expert** | It holds the received and accepted quantities. |
| `DeliveryLine` creates the `StockLot` | **Creator** | It holds the initialising data (accepted and held quantities, product) and the lot is recorded against it (`yields`). |
| `Delivery` completes `TraceDetails` with producer and date | **Information Expert** | The delivery knows its producer and received date; lines do not. |
| `Delivery` builds the `ReceiptSummary` | **Information Expert** | It contains all the lines being summarised. |
| `ReceiptOutcome.permittedFor(role)` holds the rejection rule | **Information Expert / Protected Variations** | The rule is about outcomes. If Q-04 changes who may reject, only this method changes. |
| `Product.toSellingUnit()` does conversion | **Information Expert / Protected Variations** | Conversion factors are product data; if Q-02 brings a richer policy, only `Product` changes. |
| Repositories, `Clock` and `AuditContext` are interfaces | **Pure Fabrication / Indirection** | Domain classes stay free of storage and time; tests use in-memory fakes and a fixed clock. |
| Handler talks only to `Delivery`, which talks to its lines | **Low Coupling** (Delivery as aggregate root) | The handler never reaches into a line directly, so line rules cannot be bypassed. |

Full decision records with candidates and rejected alternatives: DR-005 (Controller), DR-006 (Creator).
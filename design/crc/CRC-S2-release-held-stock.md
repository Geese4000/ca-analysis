# CRC S2 Release held stock

Cards for the classes that realise OC-05 `recordQualityCheck` and the `listHeldLots` query.

## Cards

### ReleaseHeldStockHandler

| Knows | Does | Collaborators |
|-------|------|---------------|
| The ports it was given | Receives `listHeldLots` and `recordQualityCheck`; gets the user, role and time; loads and saves the stock lot; turns the domain result into `Result<T>` | StockLotRepository, AuditContext, Clock, StockLot |

### StockLot

| Knows | Does | Collaborators |
|-------|------|---------------|
| Product, accepted, held and written-off quantities, trace details, its quality checks | Records a quality check: checks the role is permitted and the quantities fit what is held, **creates** the `QualityCheck`, moves released quantity from held to accepted and rejected quantity from held to written off; reports `availableQuantity()` (never counts held) | QualityCheck, Role, Quantity |

### QualityCheck

| Knows | Does | Collaborators |
|-------|------|---------------|
| Released and rejected quantities, reason, checked by, checked at | Validates itself: quantities not negative, not both zero, reason given when anything is rejected | Quantity |

### Role

| Knows | Does | Collaborators |
|-------|------|---------------|
| The three roles | Answers `mayRelease()` (STAFF, MANAGER) and `mayReject()` (MANAGER only) | — |

### StockLotRepository

| Knows | Does | Collaborators |
|-------|------|---------------|
| — | Finds a lot by id; finds lots with held quantity; saves a lot with its checks | StockLot |

### HeldLotView, QualityCheckResult

| Knows | Does | Collaborators |
|-------|------|---------------|
| `HeldLotView`: lot id, product, producer, batch, held quantity, hold reason. `QualityCheckResult`: available, held and written-off quantity after the check |(data only) | — |

## GRASP reasoning

| Decision | Principle | Why | Rejected alternative |
|----------|-----------|-----|----------------------|
| One `ReleaseHeldStockHandler` for UC-03 | **Controller**  | Keeps S2 independent of other slices; holds no business rules | One `HubController` for all slices: grows into a God class |
| `StockLot` moves quantities between held, accepted and written off | **Information Expert** | It holds all three quantities and must protect NFR-04 | Handler sets quantities through setters: the rule could be bypassed |
| `StockLot` creates the `QualityCheck` | **Creator** | The lot records its checks and holds the data to validate them (held quantity) | Handler creates it: needs the lot's internals |
| Permission rule in `Role.mayRelease()` / `mayReject()` | **Protected Variations** | A-04 and RC-06 are assumptions (Q-04, Q-07); if the hub's answer differs, only `Role` changes | `if` statements in the handler: rules spread across controllers |
| `QualityCheck` is saved with its `StockLot` | **Low Coupling**  | No extra repository; a check never exists without its lot | Separate `QualityCheckRepository`: more ports, two saves that could disagree |
| Repository, `Clock` and `AuditContext` are interfaces | **Pure Fabrication / Indirection** | Domain stays free of storage, time and login; tests use fakes | Domain calls a database and system clock directly: untestable |
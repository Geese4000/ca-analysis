# DR-007 – Responsibilities for releasing held stock (UC-03)

| Field | Content |
|-------|---------|
| Date | 2026-11-26 |
| Status | Philip |
| Owner | Danil Kramnov |
| Related | DES-23, OC-05, CRC-S2, SD-S2, RC-04, RC-06, A-04, NFR-04 |

## Context

OC-05 `recordQualityCheck` must check the actor's role, move quantity from held to accepted or written off, record a quality check, and never let more than the held quantity move (NFR-04). Which classes should do this?

## Options

| | A. Handler does it | B. StockLot does it |
|---|---|---|
| How | Handler checks the role with `if` statements, sets the lot's quantities through setters, creates the `QualityCheck` | `StockLot.recordCheck` moves its own quantities and creates the `QualityCheck`; `Role` answers `mayRelease()` / `mayReject()` |
| NFR-04 | Can be bypassed by any code that calls the setters | Enforced inside the only class that changes the quantities |
| Change to Q-04 / Q-07 | Edit every handler that checks roles | Edit `Role` only |

## Decision

**Option B.**

## Rationale

- **Information Expert:** `StockLot` owns the held, accepted and written-off quantities.
- **Creator:** the lot records its quality checks and holds the data to validate them.
- **Protected Variations:** A-04 and RC-06 are assumptions; `Role` isolates them.
- **Controller:** `ReleaseHeldStockHandler` holds no rules.

## Rejected alternative

**A:** the handler would grow with every new rule into a controller, and quantities could change without the NFR-04 check.

## Consequences

- `StockLot` gains `recordCheck`, `heldView`, `heldQuantity`, `writtenOffQuantity` (`design/DCD-fragment-S2.puml`).
- `Role` gains `mayRelease()` and `mayReject()`.
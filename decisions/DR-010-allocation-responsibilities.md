# DR-010 – Who allocates stock to an order line

| Field | Content |
|-------|---------|
| Date | 2026-11-25 |
| Status | Proposed |
| Owner | Oleksandr Motoryhin (Alex) |
| Reviewer | Daniel Kramnov |
| Related | UC-05, OC-06, SSD-S3, CRC-S3, GH-18 to GH-22, FR-09, BR-01, BR-03, NFR-04 |

## Context

OC-06 requires that, for each lot used, an `Allocation` is created and linked to the order line and the lot, the lot's allocated quantity grows, and no lot ever gives more than it has available (NFR-04). Lots are taken earliest use-by first, and one line may draw from several lots (GH-19). Someone must work out how much each lot gives and create the allocations, and the "never more than available" rule must sit where it cannot be bypassed.

## Candidates

| Candidate | For | Against |
|-----------|-----|---------|
| `AllocateStockHandler` loops over the lots and creates allocations | Already receives the event and loads the lots | Would compute outstanding and shortfall itself and change lots directly: business rules in the controller, and a second caller could skip them (a God controller as S2–S4 grow) |
| `StockLot` creates the allocation | Holds the available quantity | Does not know the requested or outstanding quantity; the lot would depend on orders, so S1 and S2 would carry an S3 dependency |
| **`OrderLine` creates the allocation; `StockLot` guards its own availability** | The line holds the requested quantity and its allocations, so it knows what is outstanding; the domain model records allocations against the line (*is fulfilled by*). The lot alone can say how much it can give | One more call per lot (`lot.allocate`) |

## Decision

`OrderLine.allocateFrom(lots, user, now)` sorts the lots with `StockLot.expiresBefore`, asks each lot for `availableQuantity()`, calls `lot.allocate(quantity)` for the smaller of outstanding and available, and creates one `Allocation` per lot used. `StockLot.allocate` refuses any quantity above its available quantity. The handler only checks the role, loads the order and lots, and saves them on success.

## Principle

Creator (the line records its allocations and has the initialising data), supported by Information Expert (outstanding quantity on the line, availability on the lot).

## Rejected alternatives

- **Handler creates the allocations:** rules would live in the controller and could be bypassed; the handler would grow with every allocation rule.
- **Repository returns lots already in use-by order** (`findAvailable` sorted by storage): it would put a hub rule into storage, and changing it would mean changing every repository implementation. Ordering stays in `StockLot.expiresBefore`.

## Consequences

- SD-S3 shows `<<create>> Allocation` from `OrderLine`, not from the handler.
- `StockLot` gains `allocate(quantity)` and `expiresBefore(other)`; `Role` gains `isAtLeast(role)`. Both are shared classes, so the integrated design class diagram (DES-27) shows these as S3 additions.
- The handler saves the order (with its new allocations) and every lot it changed, only after the line returns success.
- If the hub later chooses a different lot order, only `StockLot.expiresBefore` changes.
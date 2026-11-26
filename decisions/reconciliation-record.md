# Reconciliation record – CA1 baseline to CA2 design

| Field | Content |
|-------|---------|
| Date | 2026-11-24 |
| Owner | Daniel Kramnov |
| Reviewers | All members |
| Baseline | CA1 Scenario 19 analysis (`report/`, `diagrams/`), tag `ca1-baseline` |
| Related | DES-04, DES-05, SPK-01, SPK-02 |

Additions to the RC of the CA1:

| ID | CA1 said | CA2 change | Why | Affects | Status |
|----|----------|-----------|-----|---------|--------|
| RC-01 | `StockLot` has accepted and written-off quantities; only accepted goods yield a lot | `StockLot` also has `heldQuantity`; every line yields a lot unless rejected | A held remainder had nowhere to live; one lot keeps one producer and batch (SPK-01) | Domain model, S1, S2 | Accepted |
| RC-02 | Shortage priority by order date (A-05) | Priority sits behind an `AllocationPolicy` so rules can change | Priority rules are informal and unconfirmed (Q-05) | S3, S4 | Open – SPK-02 (Zak) |
| RC-03 | A volunteer refers bad goods to the manager, who rejects them later in UC-03 (UC-02 6c) | The manager may also reject during receipt (UC-02 6d) | Avoids holding goods only to reject them later; still manager-only (A-04) | UC-02, S1 | Accepted |
| RC-04 | `QualityCheck` belongs to a `DeliveryLine` and has `passed : Boolean` | `QualityCheck` belongs to a `StockLot` and records released and rejected quantities | Held goods live on the lot (RC-01); a check can release part and reject part | Domain model, UC-03, S2 | Accepted |
| RC-05 | A returned item may have the decision `ReturnToStock` | `ReturnToStock` is refused for perishable products; `Product` gains `perishable` | CA1 conflicts with A-08: returned perishables never re-enter stock | Domain model, UC-08, S2 | Accepted |
| RC-06 | UC-03 actor: hub staff member; who may release was not stated | Staff member or manager may release; only the manager may reject (A-04); volunteers may not release | CA1 rationale: a volunteer records arrival, a staff member completes the check | UC-03, S2 | Accepted |
| RC-07 | Abandoning a receipt saves recorded lines as held | Recorded lines keep their outcomes; the receipt stays open | Avoids hiding goods already accepted (Philip, UC-02 9a) | UC-02, S1 | Accepted |
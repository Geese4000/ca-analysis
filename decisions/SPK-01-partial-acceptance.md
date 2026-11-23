# SPK-01 – Partial acceptance in one StockLot (RC-01)

| Field | Content |
|-------|---------|
| Date | 2026-11-23 |
| Status | Accepted |
| Owner | Daniel Kramnov |
| Reviewer | Philip Dawson-Gariepy |
| Related | RC-01, BR-01, BR-03, NFR-04, FR-02, FR-06, UC-02, UC-03 |

## Question

When a delivery line is partly accepted, can the accepted part and the held remainder live in one `StockLot` with separate quantities, or do they need separate objects?

## Evidence

- **CA1 domain model:** `StockLot` has accepted and written-off quantities only, and only accepted goods yield a lot. A held remainder had nowhere to live. This gap is RC-01.
- **UC-02 extensions 6a and 6b:** partly accepted and held lines must be recorded; UC-03 later releases or rejects the held goods.
- **S1 design (OC-03):** already creates one lot per received line, with accepted and held quantities.

## Options

| | A. One StockLot with state quantities | B. Separate object for held goods |
|---|---|---|
| How | `accepted`, `held`, `writtenOff` on one lot | Held goods in a second object; release creates or merges a lot |
| BR-01 (held not available) | `availableQuantity()` never counts `held` | Enforced by keeping objects apart |
| BR-03 (traceability) | One lot keeps one producer and batch | Trace details copied to two objects |
| UC-03 release | Move quantity from held to accepted on the same lot | Create or merge objects |
| Risk | One class must guard the rule (NFR-04) | More classes; traceability easier to lose |

## Result

**Option A.** One `StockLot` per received line, holding accepted, held and written-off quantities.

## Consequences

- Domain model (RC-01, DES-05): `StockLot` gains `heldQuantity`. A delivery line yields a lot unless it is rejected.
- S2 (UC-03) changes quantities on an existing lot: released goods move from held to accepted; rejected goods move from held to written off. Exact operations are defined in the S2 contracts.
- `StockLot` must keep the invariant that held quantity is never available (BR-01, NFR-04). Unit tests check this.
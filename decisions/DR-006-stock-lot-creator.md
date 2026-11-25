# DR-006 – Creator of StockLot during receipt

| Field | Content |
|-------|---------|
| Date | 2026-11-25 |
| Status | Proposed |
| Owner | Philip Dawson-Gariepy |
| Reviewer | Zakary Snyder |
| Related | UC-02, OC-03, SPK-01, CRC-S1, SD-S1a |

## Context

OC-03 requires a `StockLot` to be created for every received line that is not rejected, holding the accepted and held quantities and the trace details. Someone must create it, and the rule "rejected lines yield no lot" must sit with whoever creates it.

## Candidates

| Candidate | For | Against |
|-----------|-----|---------|
| `ReceiveDeliveryHandler` | Already coordinates the event | Would need the line's received and accepted quantities, so it would read line internals and decide the outcome rule itself |
| `Delivery` | Aggregate root; already routes the receipt to the line | Does not hold the quantities; would have to ask the line for them |
| **`DeliveryLine`** | Holds received and accepted quantities, the outcome and the product: all the initialising data. The domain model records the lot against the line (`yields`) | — |

## Decision

`DeliveryLine.recordReceipt(...)` creates the `StockLot` unless the outcome is *Rejected*, and returns it to `Delivery` and then to the handler, which only saves it.

## Principle

Creator (B has the initialising data for A; B records A), supported by Information Expert.

## Rejected alternative

Handler creates the lot: it would have to repeat the accepted-versus-held calculation and the "no lot when rejected" rule outside the domain, so the rule could be bypassed by a second caller.

## Consequences

- SD-S1a shows the `<<create>>` message from `DeliveryLine`, not from the handler.
- `DeliveryLine` depends on `StockLot`'s constructor; the DCD shows `DeliveryLine "1" --> "0..1" StockLot : yields`.
- UC-03 (S2) does not create lots; it changes quantities on an existing one (SPK-01).
# DR-005 – Controller for the receive-delivery system events

| Field | Content |
|-------|---------|
| Date | 2026-11-25 |
| Status | Proposed |
| Owner | Philip Dawson-Gariepy |
| Reviewer | Zakary Snyder |
| Related | UC-02, SSD-S1, OC-01 to OC-04, CRC-S1 |

## Context

SSD-S1 has four system events (startReceipt, addLine, recordLineReceipt, completeReceipt). Something must receive them, load the delivery, and save results, without holding business rules.

## Candidates

| Candidate | For | Against |
|-----------|-----|---------|
| `HubController` (one facade for all use cases) | One entry point | Grows with every slice; low cohesion; S1–S4 all edit one class |
| `Delivery` (domain object receives the events) | Fewer classes | A domain entity would depend on repositories, clock and audit; not a receiver of external events |
| **`ReceiveDeliveryHandler` (use-case controller)** | Cohesive; one per use case; S1 changes stay in S1 | One extra class per use case |

## Decision

`ReceiveDeliveryHandler` receives all four S1 system events. It coordinates only: rules live in `Delivery`, `DeliveryLine`, `ReceiptOutcome` and `Product`.

## Principle

Controller (use-case controller), High Cohesion, Low Coupling.

## Rejected alternative

`HubController`: it would become a God controller once S2–S4 add their events, and every slice owner would change the same class.

## Consequences

- S2–S4 each get their own handler (e.g. `ReleaseHeldStockHandler`); the DCD shows four controllers, not one.
- The handler must never set a line's outcome directly; SD-S1a shows it delegating through `Delivery.recordLine`.
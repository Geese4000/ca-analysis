# 3. Prioritised Implementation Catalogue

The catalogue orders the use cases we will build in CA3 by business value, risk and dependency. Value comes from the three questions in the problem statement: what is available, who gets it, and where it came from.

| Priority | Use case | Business value | Risk / learning | Depends on (contract only) | Slice |
|----------|----------|----------------|-----------------|----------------------------|-------|
| 1 | UC-02 Receive delivery + UC-11 Record traceability details | Separates received from available, the root cause of reallocation (E-02, E-04) | Representing partial acceptance (RC-01, SPK-01) | `DeliveryRepository`, `StockLotRepository`, `Clock`, `AuditContext` | S1 |
| 2 | UC-05 Allocate stock + UC-04 order lines + UC-09 trace | Keeps the producer and batch link after stock is split (E-07) | Over-allocation (NFR-04) | `StockQueryPort`, `AllocationRepository` | S3 |
| 3 | UC-06 Handle shortfall | Customers only get substitutes they accept and hear about shortfalls early (E-05, E-06) | Priority rules unresolved (Q-05, SPK-02) | `AllocationPolicy`, `NotificationPort` | S4 |
| 4 | UC-03 Release held stock + UC-08 returns | Held goods reach customers only after checking (BR-01, BR-04) | Rejection authority (A-04) | `StockLotRepository`, `AuditContext` | S2 |
| — | UC-07 Pack order, UC-10 View hub summary, UC-01 Record expected delivery | Medium / low | Reopen rules open (Q-11) | — | Not in CA3; UC-01 covered by fixtures |

**Why this order.** S1 comes first because every other slice consumes the stock lots it creates. But no slice waits for S1: S2, S3 and S4 start from seeded lots in their own fixtures. Allocation precedes shortfall handling because a shortfall is defined by an allocation that falls short. Quality release is ranked last of the four, not because it matters less, but because its rules are the most settled (BR-01, A-08), so it carries the least design risk.

**Comparability.** Each slice receives one or more system events, enforces at least two business rules, changes persistent state and returns an observable result with controlled failures. S1 has five controlled failures and nine Gherkin scenarios; the slice approval session checks the other three reach a similar level, so each member has a comparable amount of domain logic. *(Update with the real counts for S2–S4.)*
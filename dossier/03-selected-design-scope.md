# 3. Selected CA2 Design Scope

We selected four use cases to design in detail, one owned by each member, because together they cover the Product Goal end to end: goods arrive and are checked (UC-02), held goods are released or written off (UC-03), checked goods are allocated to customers with traceability (UC-05), and shortfalls follow customers' preferences (UC-06). Each has a main flow, refusals, a state change and rules that branch the outcome, so each gives a full chain from backlog item to design class model.

| Use case | Owner | User value (backlog) | Requirements / rules | Depends on | Why selected |
|----------|-------|----------------------|----------------------|------------|--------------|
| UC-02 Receive delivery (+ UC-11 Record traceability details) | Philip | US-01 Record what actually arrived; US-02 Keep unchecked goods out of stock | FR-02 to FR-06 · BR-01, BR-03 · A-02, A-03, A-04 · NFR-04, NFR-05 | — (creates the stock lots the others use) | Root cause of the hub's problem: received is not available (E-02, E-04). Four outcomes, permission rule, unit conversion and traceability give rich behaviour and state change. |
| UC-03 Release held stock | Danil | US-02 Keep unchecked goods out of stock | FR-06 · BR-01, BR-03 · A-04, A-08 · NFR-04, NFR-05 | Stock lots with held quantity (UC-02) | Completes the held → available / written-off lifecycle on `StockLot` (SPK-01); two separate permission rules (RC-06, A-04). |
| UC-05 Allocate stock to orders (+ UC-09 Trace item) | Alex | US-05 Trace an item to its source | FR-07, FR-09, FR-12 · BR-01, BR-03 · NFR-04 | Available stock lots (UC-02, UC-03) | Keeps the producer and batch link when stock is split across customers (E-07); must never over-allocate (NFR-04). |
| UC-06 Handle shortfall | Zak | US-03 Respect substitution preferences; US-04 Warn hospitality customers early | FR-08, FR-10 · BR-05 · A-05 | Allocations that fall short (UC-05) | Customers only receive substitutes they accept (E-05, E-06); priority rule is an open design question (RC-02, SPK-02). |

**Not selected.** UC-01 Record expected delivery is simple data entry with little behaviour. UC-07 Pack order depends on unresolved reopen rules (Q-11). UC-08 Returns overlaps UC-03's write-off behaviour; its perishable rule is recorded in RC-05 but not designed in detail. UC-10 View hub summary only reads data and has no state change.

**Dependencies are on design contracts, not on order of work.** Each use case's design assumes the shared types in the interface catalogue (Section 7), so all four were designed in parallel and reconciled at review.

> *To confirm with the lecturer: section 7 of the brief says "one to three" use cases, but the rubric says "3–5 substantial use cases". We chose four, one per member, which meets the rubric.*
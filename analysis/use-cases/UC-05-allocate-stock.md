# UC-05 Allocate stock to orders (fully dressed, CA2)

| Field | Content |
|-------|---------|
| **ID / slice** | UC-05 · S3 Allocate stock |
| **User stories** | US-05 Trace an item to its source (`requirements/backlog.md`) |
| **Scope** | Kerry Local Food Hub Stock and Order System |
| **Level** | User goal |
| **Primary actor** | Hub staff member (also hub manager by generalisation) |
| **Stakeholders and interests** | Customers: receive only checked goods, in the quantity ordered where stock allows (E-04). Traceability coordinator: every allocated quantity stays linked to its producer and batch (E-07). Hub manager: stock is never promised twice (E-02). Packing volunteer: knows exactly which lot to pack from (UC-07). |
| **Trigger** | Orders for a delivery day need stock assigned before packing. |
| **Preconditions** | The actor is identified and has a role (NFR-05). The order exists with at least one order line (FR-07, UC-04). Stock lots exist from UC-02 and UC-03. |
| **Success guarantee** | Each allocated quantity is recorded as an allocation linked to exactly one order line and one stock lot, keeping that lot's producer and batch (BR-03, AC-05.1). No lot has more allocated than accepted, and held or written-off goods are never allocated (BR-01, NFR-04). Every allocation records who made it and when (NFR-05). |
| **Minimal guarantee** | Nothing is allocated unless the whole request for that line is valid. A refused request changes no lot and no order line. |
| **Requirements / rules** | FR-07, FR-09, FR-12 · BR-01, BR-03 · NFR-04, NFR-05 · A-05 (via UC-06) |
| **Gherkin** | GH-18 to GH-22 (`features/allocate_stock.feature`) |

## Main success scenario

1. The staff member selects an open order.
2. The system shows the order's lines, each with the requested quantity and the product's available quantity.
3. The staff member asks the system to allocate one order line.
4. The system takes the product's stock lots that have available quantity, earliest use-by date first, and draws from them until the requested quantity is reached. One line may draw from several lots.
5. The system records one allocation per lot used, with the quantity, the lot, who and when, and reduces each lot's available quantity by that amount.
6. The system shows the line as fully allocated, with each lot's producer, batch and quantity.
7. Steps 3–6 repeat for each line of the order.

## Extensions

- **1a. The actor is a volunteer:** the system refuses (`NOT_PERMITTED`). Nothing changes.
- **1b. The order does not exist:** the system refuses (`NOT_FOUND`).
- **3a. The line is already fully allocated:** the system refuses (`INVALID_STATE`). Nothing changes.
- **4a. Available quantity is less than requested, including none at all:** the system allocates everything that is available, records the remaining shortfall on the line, and UC-06 Handle shortfall runs («extend»). Nothing more than the available quantity is allocated (NFR-04).
- **4b. Some of the product is still held:** held quantity is never counted or allocated (BR-01). If accepted stock is not enough, continue as 4a.
- **4c. A lot has no use-by date:** it is used after lots that have one, oldest delivery first.

## Special requirements

- NFR-04: after every allocation, each lot's allocated quantity is not more than its accepted quantity.
- NFR-05: 100% of allocations record who made them and when.

## Open issues

- **Lot order (step 4).** Earliest use-by first is our design choice, so perishable goods leave first. It is not a confirmed hub rule and is recorded in the S3 GRASP decision (DES-24).
- **Which order gets scarce stock first** (A-05, Q-05) is not decided here. UC-05 allocates the order the staff member chose; priority between orders belongs to UC-06 and `AllocationPolicy` (RC-02, SPK-02).
- **Order status.** Moving an order to *Allocated* is left out: it matters only to UC-07 Pack order, which is not designed in CA2.

## Acceptance criteria → Gherkin

| Criterion | Covered by |
|-----------|------------|
| AC-05.1 Every allocation is linked to exactly one stock lot | GH-18, GH-19 |
| AC-05.2 A trace lists each producer and batch contributing to the order line, with quantities | GH-05 (UC-09) |
| NFR-04 / BR-01 Never allocate more than available; held stock is never allocated | GH-20, GH-21 |
| Only staff may allocate (extension 1a) | GH-22 |
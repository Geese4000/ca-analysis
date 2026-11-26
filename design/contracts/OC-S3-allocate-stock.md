# Operation contracts – S3 Allocate stock

One contract per state-changing system event in `design/ssd/SSD-S3-allocate-stock.puml`. `viewOrderForAllocation` and `traceOrderLine` only read data, so they have no contract.

Every operation returns `Result<T>`; a failure changes nothing. Error codes and roles follow `design/interface-catalogue.md` §3 and §4. The actor's identity and role come from `AuditContext`; the time comes from `Clock`. Neither is passed as a parameter.

---

## OC-06 allocateOrderLine

| Field | Content |
|-------|---------|
| **Operation** | `allocateOrderLine(orderLineId: OrderLineId): Result<LineAllocationResult>` |
| **Cross-references** | UC-05 steps 3–6, extensions 1a, 3a, 4a–4c · GH-18 to GH-22 · US-05 (AC-05.1) · FR-09, FR-12 · BR-01, BR-03 · NFR-04, NFR-05 |
| **Preconditions** | The actor is identified and has a role (NFR-05). Stock lots were created by UC-02 and changed only by UC-02, UC-03 and earlier allocations. |
| **Postconditions** | Let `ol` be the order line and `outstanding` = `ol.requestedQuantity` − the quantity already allocated to `ol`. The stock lots of `ol.product` with `availableQuantity() > 0` were taken in order: earliest use-by date first, lots without a use-by date after them, oldest delivery date first. **For each lot `lot` taken while `outstanding` > 0:** an `Allocation` instance `a` was created; `a.quantity` = the smaller of `outstanding` and `lot.availableQuantity()`; `a` was associated with `ol` (is fulfilled by) and with `lot` (draws from); `a.allocatedBy` was associated with the current user and `a.allocatedAt` = `Clock.now()`; `lot.allocatedQuantity` was increased by `a.quantity`; `outstanding` was reduced by `a.quantity`. The shortfall of `ol` (derived) now equals the remaining `outstanding`. No lot's `heldQuantity`, `writtenOffQuantity` or `trace` changed. |
| **Returns** | For each allocation created: lot, producer, batch (or *batch missing*) and quantity; the total allocated to the line; the shortfall. |
| **Controlled failures** | `NOT_FOUND` – order line does not exist · `NOT_PERMITTED` – the current role is `VOLUNTEER` · `INVALID_STATE` – the line is already fully allocated (`outstanding` = 0 before the call) |
| **Invariant checked** | NFR-04: for every lot, `allocatedQuantity` ≤ `acceptedQuantity`, so `availableQuantity()` is never negative. Held and written-off quantities are never allocated (BR-01). The quantities allocated to `ol` never add up to more than `ol.requestedQuantity`. |

**Notes**

- A shortfall is a success, not a failure (UC-05 4a). Applying the customer's preferences, substitutes and order priority is UC-06 (S4); OC-06 does not do it.
- A line with a shortfall can be allocated again later, for example after a quality release (UC-03). Only the outstanding quantity is allocated.
- If no lot has available quantity, no `Allocation` is created and the whole requested quantity is the shortfall. The result is still a success.

---

## Notes for other slices and the contract owner

- **S4 (Zak)** starts from the shortfall OC-06 leaves on the order line. OC-07 onwards are free for S4.
- **Integration contract (DES-26):** OC-06 uses `StockLotRepository.findAvailable` and `OrderRepository` as proposed in §6, and `allocatedQuantity` on `StockLot` from §5.3. `LineAllocationResult`, `OrderAllocationView` and `TraceView` are S3 views and stay in the `allocation` package.
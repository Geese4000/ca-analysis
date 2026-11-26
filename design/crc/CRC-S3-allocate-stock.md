# CRC / responsibility model – S3 Allocate stock

Cards for UC-05 Allocate stock (OC-06) and UC-09 Trace item. Each card lists what the class **knows**, what it **does**, and who it **collaborates** with. The GRASP rationale is below the cards; the main decision with its rejected alternatives is DR-010.

Inputs: OC-06, SSD-S3, UC-05, UC-09, domain model (Order, OrderLine, Allocation, StockLot), `design/interface-catalogue.md` §4–§6.

## Cards

### AllocateStockHandler *(application layer, `allocation`)*

| Knows | Does | Collaborators |
|-------|------|---------------|
| The ports it was given | Receives `viewOrderForAllocation` and `allocateOrderLine`; checks the role through `Role`; loads the order and the product's available lots; saves the order and the lots it changed; returns `Result<T>` | AuditContext, Clock, OrderRepository, StockLotRepository, Role, Order |

### TraceItemHandler *(application layer, `allocation`)*

| Knows | Does | Collaborators |
|-------|------|---------------|
| The ports it was given | Receives `traceOrderLine`; checks the role through `Role`; loads the order and returns its `TraceView` | AuditContext, OrderRepository, Role, Order |

### Order *(domain, aggregate root)*

| Knows | Does | Collaborators |
|-------|------|---------------|
| Id, customer, required date, its lines | Finds a line by id or product; routes an allocation request to the right line | OrderLine |

### OrderLine *(domain)*

| Knows | Does | Collaborators |
|-------|------|---------------|
| Product, requested quantity, customer preferences (S4), its allocations | Works out the outstanding quantity and the shortfall; refuses when nothing is outstanding (`INVALID_STATE`); takes lots earliest use-by first; **creates** one `Allocation` per lot used; lists its allocations for a trace | StockLot, Allocation, Quantity |

### Allocation *(domain)*

| Knows | Does | Collaborators |
|-------|------|---------------|
| Quantity, the stock lot it draws from, allocated by / at | Gives its trace entry: the lot's trace details with the allocated quantity | StockLot, TraceDetails |

### StockLot *(shared domain – S3 adds two operations)*

| Knows | Does | Collaborators |
|-------|------|---------------|
| Product, accepted, held, written-off and allocated quantities, trace details | `availableQuantity()`; **`allocate(quantity)`** increases the allocated quantity and refuses more than is available (NFR-04); **`expiresBefore(other)`** compares use-by dates, then delivery dates | TraceDetails, Quantity |

### Role *(shared enum – S3 adds one operation)*

| Knows | Does | Collaborators |
|-------|------|---------------|
| `VOLUNTEER`, `STAFF`, `MANAGER` and their order | **`isAtLeast(role)`**: true when this role includes the given one (catalogue §4 generalisation) | — |

### LineAllocationResult, OrderAllocationView, TraceView *(output DTOs)*

| Knows | Does | Collaborators |
|-------|------|---------------|
| What SSD-S3 returns: lots used, quantities, shortfall; lines with requested and available; trace entries | — (data only) | — |

## Role-play notes

- **GH-19 (split across lots):** handler loads the order and the two egg lots → `Order` passes the request to the line → the line asks each lot `expiresBefore` and takes B-0412 first → `lot.allocate(30)`, creates an `Allocation` of 30 → outstanding 6 → `lot.allocate(6)` on B-0415, creates an `Allocation` of 6 → shortfall 0 → handler saves the order and both lots.
- **GH-20, 5 kg requested, 4 available:** the line allocates 4, outstanding stays 1 → result is a success with shortfall 1; UC-06 continues.
- **GH-22 (volunteer):** `Role.isAtLeast(STAFF)` is false → handler returns `NOT_PERMITTED` before loading anything.
- **Fully allocated line:** the line sees outstanding 0 and returns `INVALID_STATE`; nothing is created or saved.

## GRASP rationale

| Decision | Principle | Why |
|----------|-----------|-----|
| One `AllocateStockHandler` for UC-05 and one `TraceItemHandler` for UC-09 | **Controller** (use-case controller, DR-005 pattern) | Each use case has its own entry point; neither handler holds a business rule. |
| `OrderLine` works out outstanding and shortfall | **Information Expert** | It holds the requested quantity and its allocations. |
| `OrderLine` creates `Allocation` | **Creator** | It records its allocations (domain model *is fulfilled by*) and holds the initialising data: outstanding quantity, user and time. See DR-010. |
| `StockLot.allocate(quantity)` guards availability | **Information Expert**, NFR-04 | Only the lot holds accepted and allocated quantities, so only the lot can refuse to go negative. |
| `StockLot.expiresBefore(other)` decides lot order | **Information Expert / Protected Variations** | Dates are in the lot's trace details. If the hub chooses another order, only this method changes. |
| `Role.isAtLeast(role)` holds the "staff or above" rule | **Information Expert / Protected Variations** | The generalisation belongs to the roles; it answers the single role-permission point raised in the design evaluation. |
| `Order` routes to the line; the handler never reaches a line directly | **Low Coupling** (Order as aggregate root) | Line rules cannot be bypassed, as `Delivery` does in S1. |
| `Allocation` gives its own trace entry | **Information Expert** | It knows its lot and quantity, so UC-09 needs no extra traceability object (BR-03). |
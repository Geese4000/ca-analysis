# 8. Design Evaluation

**Cohesion.** Each use case has its own controller (`ReceiveDeliveryHandler`, `ReleaseHeldStockHandler`, `AllocateStockHandler`, plus `TraceItemHandler` for UC-09) rather than one hub facade (DR-005). Controllers only coordinate; rules sit with the objects that hold the data: `DeliveryLine` checks accepted against received, `StockLot` guards held versus available and records quality checks (DR-007), and `OrderLine` allocates from lots (DR-010). The cost is repetition: every controller reads the user, role and time before delegating.

**Coupling.** Controllers depend on repository interfaces, never on storage, and slices depend only on `shared`, never on each other (package view). The strongest coupling is around `StockLot`: all three use cases change it, so a change to its quantities affects every slice. We accepted this because one lot per received line keeps one producer and batch (SPK-01); splitting it would have spread traceability across objects.

**Object validity.** Objects are created valid or not at all: `Delivery.startUnannounced` sets the unannounced invariants, `StockLot` is constructed with its quantities, and every operation returns `Result<T>`, so a refusal changes nothing (interface catalogue §2). No class exposes a public status or quantity setter.

**Main risk found in evaluation.** The manager-only rejection rule (A-04) is phrased twice: `ReceiptOutcome.permittedFor(role)` at receipt and `Role.mayReject()` in the quality check. Both rely on `Role`, but if Q-04 changes who may reject, both must change. The first refactoring we would make is for `permittedFor` to delegate to `Role.mayReject()`.

**Assumptions.** A-02 fixed unit conversion per product; A-04 only the manager rejects; RC-05 perishables never return to stock; A-05 shortage priority by order date.

**Rejected alternatives.** A single `HubController` (DR-005); a separate held-goods object (SPK-01 option B); the controller creating stock lots (DR-006); plus the alternatives in DR-007 and DR-010.

**Limitations.** UC-06 Handle shortfall was descoped (DR-011), so shortage priority and customer substitution preferences are not designed; S3 reports the shortfall quantity so UC-06 can be added without changing it. The design does not cover concurrent recording of the same line, a database design, or UC-01, UC-07, UC-08 and UC-10. A partial release leaves one lot with mixed history, kept only in its quality-check records.
# 10. Traceability Matrix

Each row follows one chain from problem evidence to the requirement, its behaviour and the domain concepts that hold its data. Every Must requirement appears at least once.

| Evidence | Stakeholder / goal | Requirement | Priority | Rule | Use case | Gherkin / story | Domain concepts |
|----------|--------------------|-------------|----------|------|----------|-----------------|-----------------|
| E-02, E-03 | SH-01 Hub manager: know what is expected | FR-01 | Must | — | UC-01 | US-06 | Producer, Delivery, DeliveryLine |
| E-02 | SH-01: expected vs accepted are different | FR-02 | Must | — | UC-02 | GH-01, US-01 | DeliveryLine |
| Receipt section | SH-03 Volunteer: record outcome per line | FR-03 | Must | BR-01 | UC-02 | GH-01, US-01 | DeliveryLine, ReceiptOutcome |
| E-08 | SH-02 Staff: comparable quantities | FR-04 | Should | — | UC-02 | — | DeliveryLine (`suppliedUnit`), Product (`sellingUnit`) |
| E-07 | SH-04 Traceability coordinator: batch known | FR-05 | Must | BR-03 | UC-11 | GH-05, US-05 | StockLot |
| E-04 | SH-03 Volunteer: received ≠ available | FR-06 | Must | BR-01 | UC-02, UC-03 | GH-02, US-02 | DeliveryLine, QualityCheck, StockLot |
| Orders section | SH-02 Staff: capture orders | FR-07 | Must | — | UC-04 | GH-03, GH-04 | Customer, Order, OrderLine |
| E-05, E-06 | SH-06/07 Customers: get acceptable goods | FR-08 | Must | BR-05 | UC-04, UC-06 | GH-03, GH-04, US-03 | OrderLine, Product (permits as substitute) |
| E-07 | SH-04: link survives allocation | FR-09 | Must | BR-03 | UC-05, UC-07 | GH-03, GH-05, US-05 | Allocation, StockLot, OrderLine |
| E-06, E-11 | SH-07 Hospitality: early notice | FR-10 | Should | — | UC-06 | GH-03, US-04 | OrderLine (`/shortfall`) |
| Collection section | SH-02 Staff: resolve handover problems | FR-11 | Should | BR-04 | UC-08 | — | HandoverIssue, StockDecision |
| E-07 | SH-04: trace an item | FR-12 | Must | BR-03 | UC-09 | GH-05, US-05 | Allocation, StockLot, Producer |
| Manager needs | SH-01: see the hub at a glance | FR-13 | Should | — | UC-10 | US-06 | Delivery, StockLot, OrderLine |
| Visibility statement | SH-03 Volunteer; SH-01 Manager | NFR-01 | Must | BR-02 | UC-02, UC-07 | — | HubWorker (`role`) |
| E-04 | SH-03; SH-06/07 | NFR-04 | Must | BR-01 | UC-03, UC-05 | GH-02 | StockLot (`/availableQuantity`) |
| E-07 | SH-04; SH-10 Regulator | NFR-05 | Must | BR-03 | UC-02, UC-03, UC-05 | — | HubWorker, QualityCheck, Allocation |

**Reading the matrix.** The strongest chain runs from the traceability coordinator's quote (E-07) through BR-03 to FR-05, FR-09 and FR-12, then to GH-05 and the Allocation and StockLot classes. That chain is why Allocation is a class in the domain model: without it, the requirement could not be satisfied. The weakest links are the Should requirements FR-04 and FR-11, which have no Gherkin scenario yet; both depend on open questions (Q-02, Q-07), so writing scenarios now would mean inventing policy. They would be the first scenarios to add once those questions are answered.

**Coverage check:** all 9 Must functional requirements and 3 Must non-functional requirements trace to evidence, a use case and at least one domain concept; 8 of the 9 Must FRs also appear in at least one Gherkin scenario (FR-01 is verified by test). No Must requirement is isolated.

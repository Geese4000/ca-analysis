# 7. Use-Case Model

## 7.1 Use-case diagram

![Use-case model](..\diagrams\use-case-model.png)

Source: `diagrams\use-case-model.puml`. The system boundary is **Kerry Local Food Hub Stock and Order System**. Payment, routing and certification sit outside the boundary (Section 2.3).

## 7.2 Use-case catalogue

| ID | Use case | Primary actor | Goal | Requirements |
|----|----------|---------------|------|--------------|
| UC-01 | Record expected delivery | Hub staff member | Note what a producer expects to deliver and when | FR-01 |
| UC-02 | Receive delivery | Hub volunteer | Record what arrived and the outcome for each line | FR-02, FR-03, FR-04, FR-06 |
| UC-03 | Release held stock | Hub staff member | Make checked goods available, or reject them | FR-06 |
| UC-04 | Record customer order | Hub staff member | Capture order lines and substitution preferences | FR-07, FR-08 |
| UC-05 | Allocate stock to orders | Hub staff member | Assign available stock lots to order lines | FR-09 |
| UC-06 | Handle shortfall | Hub staff member | Apply customer preferences when stock is short | FR-08, FR-10 |
| UC-07 | Pack order | Hub volunteer | Assemble and label an order from its allocations | FR-09 |
| UC-08 | Record handover | Hub staff member | Record collection, exceptions and returns | FR-11 |
| UC-09 | Trace item | Traceability coordinator | Find the producer and batch of an allocated item | FR-12 |
| UC-10 | View hub summary | Hub manager | Review deliveries, stock, shortfalls and producer contributions | FR-13 |
| UC-11 | Record traceability details | Hub volunteer | Capture producer, batch and dates at receipt | FR-05 |

**Relationships**

- UC-02 Receive delivery **«include»** UC-11 Record traceability details: every receipt records traceability (BR-03).
- UC-06 Handle shortfall **«extend»** UC-05 Allocate stock to orders: it runs only when available stock is less than the quantity ordered.
- Actor generalisation: Hub manager → Hub staff member → Hub volunteer (Section 4.2).

**Model rationale.** Each use case is one actor goal from the actor-goal table, named as a verb and an object; there are no "manage" use cases that hide several goals. Receive delivery is split from Release held stock because they happen at different times and often by different people: a volunteer records arrival, while a staff member later completes the check. «include» is used once, because recording traceability is a mandatory part of every receipt. «extend» is used once, because shortfall handling only happens when supply is short. Reopening a packed order is treated as an alternative flow of UC-07 rather than a separate use case, since who may reopen orders is still unknown (Q-11).

## 7.3 Detailed use case: UC-02 Receive delivery

UC-02 was chosen for detailed description because it contains the scenario's richest variation (accept, partially accept, hold and reject outcomes) and is where availability and traceability begin.

| Field | Content |
|-------|---------|
| **Primary actor** | Hub volunteer |
| **Stakeholders and interests** | Hub manager: accurate accepted quantities (E-02). Producer: fair record of what was delivered (E-03). Traceability coordinator: batch recorded (E-07). Customers: only checked goods are allocated (E-04). |
| **Trigger** | A producer's delivery arrives at the hub. |
| **Preconditions** | The volunteer is identified in the system. The producer exists in the system. |
| **Success guarantee (postconditions)** | Each delivery line has a received quantity, an outcome and traceability details. Accepted quantities are available stock; held quantities are not available (BR-01). Who recorded the receipt and when is stored (NFR-05). |

**Main success scenario**

1. The volunteer identifies the producer and selects the matching expected delivery.
2. The system lists the expected delivery lines with products and expected quantities.
3. For each line, the volunteer records the received quantity and supplied unit.
4. The system shows the received quantity in the product's selling unit (FR-04).
5. The volunteer records the traceability details (include UC-11).
6. The volunteer records the outcome as accepted.
7. The system records the accepted quantity as available stock in a new stock lot.
8. Steps 3–7 repeat for each line.
9. The volunteer confirms the delivery is complete; the system records the receipt with user and time.

**Alternative flows**

- **1a. No expected delivery exists** (unannounced delivery): the volunteer creates the delivery lines during receipt; the system marks the delivery as unannounced.
- **3a. Received quantity differs from expected:** the system records both quantities and highlights the difference for the manager summary (FR-13).
- **6a. Only part of the line is acceptable:** the volunteer records "partially accepted" and the accepted quantity; only that quantity becomes available. The remainder is recorded as held or rejected.
- **6b. Quality check cannot be completed now:** the volunteer records "held" with a reason; the quantity is stored but not available until UC-03 releases it (BR-01).

**Exceptions**

- **5a. Batch information missing:** the volunteer records that batch is missing (A-03); receipt continues and the line is marked for follow-up.
- **6c. Goods appear unacceptable:** under A-04 a volunteer cannot reject goods; the volunteer records "held" and the line is referred to the hub manager, who may record "rejected" via UC-03.
- **Any step. The volunteer abandons receipt:** lines already recorded are saved as held so that no unchecked stock becomes available.

**Open issues:** Q-02 (unit conversion), Q-03 (mandatory traceability fields), Q-04 (rejection authority).

# 8. Behavioural Examples (Gherkin)

The five scenarios were chosen to exercise the rules with the strongest evidence rather than the easiest flows. GH-01 and GH-02 test the difference between received, accepted and available stock, which is the core of the problem statement. GH-03 is a boundary case: the order is short by exactly 1 kg and the customer accepts a reduced quantity, so the outcome depends on a recorded preference. GH-04 is a failure case showing that an unpermitted substitute is refused and stock is left untouched. GH-05 shows traceability surviving a split across two batches. All steps use domain language and concrete values; none mention screens, buttons or storage. GH-03 depends on assumption A-05, which is stated in the feature file.

Feature files are in `features/`. Each scenario is tagged with its requirement, rule and use case.

| ID | Scenario | Kind | File | Links |
|----|----------|------|------|-------|
| GH-01 | Partially accept a delivery line | Success / alternative | `receive_delivery.feature` | FR-02, FR-03, UC-02 |
| GH-02 | Held stock is not available for allocation | Rule / boundary | `receive_delivery.feature` | FR-06, BR-01, UC-02, UC-03 |
| GH-03 | Shortfall of a line where reduced quantity is accepted | Boundary / alternative | `allocate_stock.feature` | FR-08, FR-10, UC-06 |
| GH-04 | Refuse a substitute the customer has not permitted | Failure / rule | `allocate_stock.feature` | FR-08, BR-05, UC-06 |
| GH-05 | Trace an allocated item to producer and batch | Success | `trace_item.feature` | FR-05, FR-09, FR-12, BR-03, UC-09 |

# 5. Requirements Catalogue

Requirements were derived by following each quantity through the hub, from expected to received, held or accepted, allocated and handed over, and asking what the system must record at each step to answer the three questions in the problem statement: what is available, who gets it, and where it came from. Each requirement states one capability, cites its evidence and avoids design detail such as screens or storage.

The Must set is deliberately limited to what closes those three questions. Unit conversion (FR-04) is important but rated Should because the conversion policy is unconfirmed (Q-02); specifying it as Must would commit the hub to a rule nobody has agreed. Reporting (FR-13) depends entirely on data captured by the Must requirements, so it can follow in a later release without losing information.

Priorities use MoSCoW. **Must** = without it the core problem (unreliable availability, unfair allocation, lost traceability) is not solved. **Should** = important but the hub could operate for a first release without it. **Could** = useful if time allows. Verification refers to Gherkin scenarios (GH-xx), inspection (INS) or test (TST).

## 5.1 Functional requirements

| ID | Requirement | Source | Priority | Rationale for priority | Verification |
|----|-------------|--------|----------|------------------------|--------------|
| FR-01 | The system shall record each expected delivery line with producer, product, expected quantity and expected date. | E-03; manager reporting needs | Must | Expected vs accepted comparison is the starting point of the problem (E-02) | TST |
| FR-02 | The system shall record the received quantity of each delivery line separately from its expected quantity. | E-02 | Must | Core cause of reallocation errors | GH-01 |
| FR-03 | The system shall record one receipt outcome per delivery line (accepted, partially accepted, held or rejected) together with the accepted quantity. | Receipt section | Must | Outcomes differ within one delivery | GH-01, GH-02 |
| FR-04 | The system shall record the supplied unit and quantity of a delivery line alongside its quantity in the product's selling unit. | E-08; A-02 | Should | Needed for accurate availability, but conversion rules are unconfirmed (Q-02) | TST |
| FR-05 | The system shall record the producer, batch code and, where supplied, harvest or use-by date for each received delivery line, and shall record when batch information is missing. | E-07; A-03 | Must | Traceability starts at receipt | GH-05 |
| FR-06 | The system shall exclude held and uninspected quantities from available stock until a quality check releases them. | E-04; BR-01 | Must | "Received does not mean available" is the central rule | GH-02 |
| FR-07 | The system shall record a customer order as one or more order lines, each with a product and requested quantity. | Orders section | Must | Allocation needs order lines | TST |
| FR-08 | The system shall record, for each order line, whether the customer accepts a reduced quantity, removal of the item, and which substitute products are permitted. | E-05; E-06; A-06 | Must | Prevents unwanted substitutes; preferences are currently lost | GH-03, GH-04 |
| FR-09 | The system shall allocate a quantity from a specific stock lot to a specific order line. | E-07; allocation section | Must | Allocation is the link that makes traceability possible | GH-03, GH-05 |
| FR-10 | The system shall identify order lines that cannot be fully allocated and flag customers who must be contacted before delivery. | E-06 | Should | High value to hospitality customers; can initially be handled by phone | GH-03 |
| FR-11 | The system shall record handover exceptions (missing, damaged, incorrectly allocated) and the stock decision for any returned goods. | Collection section; BR-04 | Should | Problems at handover are frequent but secondary to availability | TST |
| FR-12 | The system shall identify the producer and batch of any allocated quantity on an order. | E-07 | Must | Directly requested by the traceability coordinator | GH-05 |
| FR-13 | The system shall provide the hub manager with a summary of expected vs accepted quantities per producer, held stock, available stock, shortfalls, substitutions and prepared orders. | Manager information needs | Should | Replaces manual reporting; depends on the data captured by Must items | INS |

**Won't have (this release):** payment and invoicing, route optimisation, food-safety certification, storage capacity planning, producer and customer self-service (A-01, A-10).

## 5.2 Non-functional requirements

| ID | Category | Requirement | Source | Priority | Verification |
|----|----------|-------------|--------|----------|--------------|
| NFR-01 | Security / access control | A user in the volunteer role shall be able to view 0 price, payment or commercial-term fields. | Scenario (visibility); BR-02 | Must | TST: log in as volunteer and inspect every screen and report for commercial fields |
| NFR-02 | Usability | A volunteer who has had a 15-minute briefing shall be able to record the receipt and outcome of one delivery line in under 60 seconds. | Volunteers under time pressure; A-11 | Should | TST: timed task with 3 volunteers |
| NFR-03 | Performance | The available quantity of a product shall be displayed within 2 seconds for 95% of requests with up to 500 active products. | Rapid reallocation (E-01); A-11 | Should | TST: load test |
| NFR-04 | Data integrity | The available quantity of a stock lot shall never exceed its accepted quantity minus allocated and written-off quantities. | E-04; BR-01 | Must | TST: automated check after every allocation and release |
| NFR-05 | Auditability | 100% of receipt outcomes, quality releases and allocations shall record who made them and when. | E-07; regulator concern | Must | INS: sample 20 records |

All thresholds are working targets (A-11) pending Q-13.

# 6. Business Rules and Constraints

A business rule here is a policy the hub follows regardless of any system. Only statements supported by the scenario or a stakeholder quote are listed as rules. BR-05 is marked *Derived* because the customer quote supports the principle that not every substitute is acceptable, but the approval process behind it is still open.

## 6.1 Business rules

| ID | Rule | Evidence | Confidence | Enforced by |
|----|------|----------|------------|-------------|
| BR-01 | Goods that are held or awaiting quality checking are not available for allocation. | E-04 | Stated | FR-06, NFR-04 |
| BR-02 | Volunteers may not see commercial terms. | Scenario: volunteers "without seeing all commercial terms" | Stated | NFR-01 |
| BR-03 | Every allocated quantity must remain linked to the producer and batch it came from. | E-07 | Stated | FR-09, FR-12 |
| BR-04 | Returned perishable goods do not automatically return to available stock; a decision must be recorded. | Collection section | Stated | FR-11 |
| BR-05 | A substitute product may only be supplied if the customer has permitted it or approved it. | E-05 | Derived from stakeholder statement; approval process unconfirmed (Q-06) | FR-08 |

**Not rules yet:** shortage priority (Q-05, A-05), authority to downgrade or reject (Q-04, A-04), mandatory traceability fields (Q-03, A-03) and approval of reduced quantities (Q-06, A-06) remain assumptions until stakeholders confirm them.

## 6.2 Constraints

- CON-01: Receipt and packing are performed mostly by volunteers with limited training time.
- CON-02: Perishable goods must be handled within short time windows.
- CON-03: Producer records are inconsistent, particularly for small occasional suppliers.
- CON-04: Payment, route optimisation and certification are excluded by the hub.
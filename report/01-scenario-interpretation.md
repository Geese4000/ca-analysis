# 1. Scenario Interpretation

## 1.1 Organisation and current process

Kerry Local Food Hub collects vegetables, fruit, eggs, preserves and other products from small producers and prepares mixed orders for households, cafés, accommodation providers and community programmes. Producers notify the hub of expected deliveries; staff and volunteers check goods on arrival, store them, allocate stock to customer orders, pack and label orders, and hand them over to customers or drivers.

All of this is currently coordinated through spreadsheets, messages and paper checklists (E-01). Decisions about shortages, substitutions and priorities are made informally, case by case (E-08, E-09).

## 1.2 Problem statement

The hub cannot reliably tell how much of each product it actually has available to sell. A quantity moves through several states (expected, received, held, accepted, allocated), but these states are not recorded separately, so staff treat goods as available before checks are complete and must reallocate at short notice when deliveries differ from what was expected (E-02, E-03, E-04). Because customer substitution preferences and shortage priorities are not recorded, allocation decisions are inconsistent, and the link between an allocated item and its producer and batch is lost once stock is split across orders (E-05, E-09, E-07). The consequences are orders reopened after packing, problems discovered only at handover, avoidable waste of perishables, customers receiving substitutes they did not want, and weak traceability (E-10).

## 1.3 Desired outcomes

- Staff know, at any point, how much of each product is expected, received, held, accepted and available.
- Shortages are handled consistently, using recorded customer preferences and agreed priorities.
- Customers who accept reduced quantities are told before delivery, not at handover.
- Any allocated item can be traced back to its producer and batch.
- The hub manager can see deliveries, held stock, shortages, substitutions and producer contributions without compiling them by hand.
- Volunteers can do receipt and packing work without seeing commercial terms.

## 1.4 Evidence and uncertainty

| ID | Evidence | Source | Type |
|----|----------|--------|------|
| E-01 | Deliveries, stock, orders and collections are managed through spreadsheets, messages and paper checklists | Scenario: Organisation and current service | Stated |
| E-02 | "Expected quantity and accepted quantity are often different." | Hub manager | Stated |
| E-03 | "The crop may be ready, but the exact quantity is not known until harvest." | Producer | Stated |
| E-04 | "Received does not mean available if quality checking is incomplete." | Packing volunteer | Stated |
| E-05 | "I will accept some substitutions, but not every alternative." | Customer | Stated |
| E-06 | "A smaller quantity may be useful if I know before delivery." | Hospitality customer | Stated |
| E-07 | "We need to know which producer and batch supplied an item after it has been allocated." | Traceability coordinator | Stated |
| E-08 | Products are supplied individually, by weight, box or case; staff convert units manually | Scenario: Producers, products and expected deliveries | Stated |
| E-09 | Shortage priority between customer groups is informal; preferences are not always recorded | Scenario: Orders and allocation | Stated |
| E-10 | Late deliveries can force orders to be reopened after packing; problems are found at handover | Scenario: Orders and allocation; Collection | Stated |

# 2. Purpose, Scope and Boundary

## 2.1 Purpose

To give the hub a single, reliable record of products as they move from expected delivery to customer handover, so that staff can allocate available stock fairly, keep customers informed of shortfalls, and trace every allocated item to its produce and batch.

## 2.2 In scope

- Recording expected deliveries from producers
- Recording receipt and quality decisions (accept, partially accept, hold, reject) per delivery line
- Tracking stock state: recieved, held, accepted, available, allocated
- Recording customer orders and their substitution and reduced-quantity preferences
- Allocating available stock to order lines, including during shortages
- Flagging customers who need to be told about a shortfall before delivery
- Packing, labelling and reopening orders
- Recording handover exceptions (missing, damaged, wrong items) and returns
- Recording traceability details at receipt and keeping them linked through allocation
- Manager reporting on deliveries, held stock, shortages, substitutions, prepared orders and producer contributions
- Restricting what volunters can see

## 2.3 Out of scope

- Detailed payment and invoicing (stated in scenario); only the *fact* that a price adjustment was agreed is recorded (A-07)
- Route optimisation for deliveries (stated in scenario); only the handover to a driver is recorded
- Food-safety certification systems (stated in scenario)
- Storage space and capacity planning
- Producer and customer self-service portals (A-01, A-06)

## 2.4 Dependencies and constraints

- **Dependency:** producers notify the hub of expected deliveries before arrival.
- **Dependency:** physical quality checks are done by staff; the system records the outcome but does not perform the check.
- **Constraint:** receipt and packing are largely done by volunteers, who may have limited training and time.
- **Constraint:** volunteers must not see commercial terms.
- **Constraint:** perishable goods have short shelf lives, so decisions on held and returned goods are time-sensitive.
- **Constraint:** small occasional producers supply inconsistent records.

# 3. Uncertainty Register

## 3.1 Assumptions

| ID | Assumption | Stands in for | Rationale |
|----|-----------|---------------|-----------|
| A-01 | Staff record expected deliveries from producer messages; producers do not use the system directly | Q-01 | Scenario says producers "notify" the hub; simplest reversible option |
| A-02 | Each product has one selling unit; staff record the supplied unit and quantity at receipt alongside the converted selling quantity | Q-02 | Keeps the original record while giving one comparable figure for availability |
| A-03 | Producer and delivery date are mandatory at receipt; batch and use-by are recorded when supplied | Q-03 | Small producers' records are inconsistent (scenario), so stricter rules would block receipt |
| A-04 | Any receiving staff member, including volunteers, may accept or hold goods; only the hub manager may downgrade or reject | Q-04 | Rejection affects producers and pricing, so it is treated as a manager decision |
| A-05 | During a shortage, stock is allocated by order date until priority rules are agreed | Q-05 | Neutral, transparent and easy to replace |
| A-06 | Customers state allowed substitutions and reduced quantities when ordering; staff record them; anything else requires contacting the customer | Q-06 | Matches the customer quote: some substitutions, not all |
| A-07 | An agreed price adjustment is recorded as a note on the delivery line, with no amount | Q-08 | Keeps payment out of scope while preserving the decision |
| A-08 | Held goods become available only after a completed quality check; returned perishables never re-enter stock | Q-07 | Supported by the volunteer quote; cautious for food |
| A-09 | Volunteers see product, quantity, order reference and customer name, but no prices or commercial terms | Q-09 | Volunteers need customer names to label and hand over orders |
| A-10 | Customers do not use the system; staff record orders and preferences received by message, phone or in person | Q-12 | Scenario describes no customer self-service; keeps scope realistic |
| A-11 | Thresholds in the non-functional requirements (steps, seconds, product count) are working targets, not agreed figures | Q-13 | Lets NFRs be measurable before the hub confirms its expectations |

## 3.2 Clarification questions

| ID | Question | Ask | Why it matters | Blocks |
|----|----------|-----|----------------|--------|
| Q-01 | Do producers enter expected deliveries themselves, or do staff record them? | Hub manager, Producer | Decides whether Producer is an actor or an offstage stakeholder | Actor-goal table, UC-01 |
| Q-02 | How should products supplied by box or case be converted to selling units, and is the conversion fixed per product? | Hub manager | Availability figures are meaningless if units are inconsistent | FR-04, Product `sellingUnit` |
| Q-03 | Which traceability details are mandatory at receipt, and what happens if a small producer cannot supply them? | Traceability coordinator | Determines whether incomplete deliveries are held or accepted | FR-05, A-03 |
| Q-04 | Who may accept, downgrade or reject delivered goods, and must the producer be told? | Hub manager | Defines the receiving actor and a permission rule | UC-02, UC-03 |
| Q-05 | When stock is short, how should hospitality customers, pre-paid boxes and community programmes be prioritised, and who decides? | Hub manager | Allocation cannot be specified fairly without it | FR-09, FR-10, A-05 |
| Q-06 | How do customers record acceptable substitutions and reduced quantities, and must each substitution be approved? | Customer, Hub manager | Prevents unwanted substitutes at handover | FR-08, BR-05, GH-04 |
| Q-07 | When may held or returned goods return to available stock, and who decides? | Hub manager | Directly affects the availability figure | FR-06, FR-11, BR-04 |
| Q-08 | Should agreed price adjustments be recorded, and with what detail, given payment is out of scope? | Hub manager | Sets the scope boundary for commercial data | Scope, A-07 |
| Q-09 | Which producer, customer and commercial details may volunteers see? | Hub manager | Defines the access-control NFR and rule | NFR-01, BR-02, A-09 |
| Q-10 | What does "producer contributions" mean in the manager's reports: quantity supplied, accepted or sold? | Hub manager | Changes what must be recorded per producer | FR-13 |
| Q-11 | Who decides to reopen a packed order when a late delivery arrives, and must the customer be told? | Hub manager | Defines an alternative flow and possible rule | UC-07 Pack order |
| Q-12 | Do customers place orders and state preferences directly, or through staff? | Hub manager, Customer | Decides whether Customer is an actor | Actor-goal table, UC-04 |
| Q-13 | How quickly must volunteers be able to record a receipt, and how many products does the hub handle at peak? | Hub manager, Packing volunteer | Sets realistic NFR thresholds | NFR-02, NFR-03 |

## 3.3 Risks

| ID | Risk | Impact | Mitigation |
|----|------|--------|------------|
| R-01 | Priority rules (Q-05) stay unresolved | Allocation requirements may need rework | Keep allocation logic behind A-05 and flag dependent requirements |
| R-02 | Volunteers skip recording steps under time pressure | Availability and traceability data become unreliable | Usability NFR limiting steps per task |
| R-03 | Small producers cannot supply batch information | Traceability gaps for some items | A-03 allows receipt without batch, recorded as missing |
| R-04 | Unit conversion rules differ between products | Incorrect availability figures | Q-02 raised early; record supplied and converted quantities (A-02) |

# 4. Stakeholders and Actors

The hub sits between two groups it does not control: producers, whose quantities are uncertain until harvest (E-03), and customers, whose expectations differ by type (Orders section). The people who actually record information are inside the hub: the manager, staff and volunteers. The traceability coordinator is a direct stakeholder with a narrow but strict need: to answer "where did this come from?" after stock has been split (E-07). Influence is highest for the hub manager, who sets priorities and owns the open policy questions, so most clarification questions (Section 3.2) are addressed to them. Volunteers have less formal influence but carry out the most frequent tasks, which is why usability (NFR-02) and visibility limits (NFR-01) matter.

## 4.1 Stakeholder catalogue

Type: **Direct** = uses the system or is affected by it day to day; **Indirect** = affected by its outcomes; **External** = outside the hub organisation.

| ID | Stakeholder | Type | Goals | Concerns | Influence | Role | Evidence |
|----|-------------|------|-------|----------|-----------|------|----------|
| SH-01 | Hub manager | Direct | Know what is expected, received, held and available; run allocation fairly; report on producers and shortages | Reallocation at short notice; informal priorities; manual reporting | High | Primary actor | E-02; Collection and reporting section |
| SH-02 | Hub staff member | Direct | Record deliveries and orders accurately; allocate stock; resolve shortages and handover problems | Unclear availability; unrecorded preferences | Medium | Primary actor | Receipt; Orders and allocation sections |
| SH-03 | Hub volunteer (receipt and packing) | Direct | Record receipt quickly; pack the right goods for each order | Treating unchecked goods as available; time pressure | Medium | Primary actor | E-04; volunteers process receipt and packing |
| SH-04 | Traceability coordinator | Direct | Find the producer and batch behind any allocated item | Batch link lost after allocation; inconsistent producer records | Medium | Primary actor | E-07 |
| SH-05 | Producer | External | Have produce accepted and paid for fairly; know outcomes of deliveries | Quantities uncertain until harvest; rejections and downgrades | Medium | Offstage stakeholder (A-01) | E-03 |
| SH-06 | Household customer (incl. pre-paid boxes) | External | Receive the ordered box, or acceptable substitutes | Unwanted substitutes; missing items | Low | Offstage stakeholder (A-10) | E-05 |
| SH-07 | Hospitality customer (cafés, accommodation) | External | Receive reliable quantities, or early notice of shortfalls | Late discovery of shortages | Medium | Offstage stakeholder (A-10) | E-06 |
| SH-08 | Community programme | External | Receive allocated produce for their participants | Being deprioritised under informal rules | Low | Offstage stakeholder | Orders and allocation section |
| SH-09 | Driver | Direct | Collect the correct, complete orders | Discovering problems at handover | Low | Offstage stakeholder | Collection section |
| SH-10 | Food-safety regulator | Indirect | Hub can show where food came from | Gaps in traceability records | Medium | Offstage stakeholder | Implied by E-07; certification itself is out of scope |

## 4.2 Actor rationale

- **Actors are the people who record or query information in the system.** The hub manager, hub staff members, hub volunteers and the traceability coordinator all do this.
- **Generalisation:** a hub staff member can do everything a volunteer can, and a hub manager can do everything a staff member can. This keeps the use-case diagram readable and reflects the volunteer visibility limit (BR-02).
- **Producers and customers are offstage stakeholders** under A-01 and A-10, because staff record their deliveries and orders. If Q-01 or Q-12 is answered differently, they become primary actors.
- **The driver is offstage.** Staff record the handover; the driver does not interact with the system.
- **Offstage concerns still drive requirements:** customer concerns drive FR-08 and FR-10; producer concerns drive FR-01 and FR-13; the regulator's concern supports FR-12 and NFR-05.

## 4.3 Actor-goal table

| Actor | Type | Goal | Use case | Requirements |
|-------|------|------|----------|--------------|
| Hub staff member | Primary | Record what a producer expects to deliver | UC-01 Record expected delivery | FR-01 |
| Hub volunteer | Primary | Record a delivery and its quality outcome | UC-02 Receive delivery | FR-02, FR-03, FR-04, FR-06 |
| Hub volunteer | Primary | Record the producer and batch of received goods | UC-11 Record traceability details | FR-05 |
| Hub staff member | Primary | Release held goods once checked | UC-03 Release held stock | FR-06 |
| Hub staff member | Primary | Record a customer order and its preferences | UC-04 Record customer order | FR-07, FR-08 |
| Hub staff member | Primary | Allocate available stock to orders | UC-05 Allocate stock to orders | FR-09 |
| Hub staff member | Primary | Resolve a shortfall using customer preferences | UC-06 Handle shortfall | FR-08, FR-10 |
| Hub volunteer | Primary | Pack and label an order | UC-07 Pack order | FR-09 |
| Hub staff member | Primary | Record handover problems and returns | UC-08 Record handover | FR-11 |
| Traceability coordinator | Primary | Find the producer and batch of an allocated item | UC-09 Trace item | FR-12 |
| Hub manager | Primary | Review deliveries, stock, shortages and producer contributions | UC-10 View hub summary | FR-13 |

# UC-03 Release held stock

| Field | Content |
|-------|---------|
| **ID / slice** | UC-03 · S2 Stock decisions |
| **Scope** | Kerry Local Food Hub Stock and Order System |
| **Level** | User goal |
| **Primary actor** | Hub staff member |
| **Stakeholders and interests** | Hub manager: held goods are checked quickly and losses recorded (E-02). Customers: only checked goods reach them (E-04). Traceability coordinator: released goods keep their producer and batch (E-07). |
| **Trigger** | Held goods are ready to be checked. |
| **Preconditions** | The actor is identified and has a role (NFR-05). A stock lot with held quantity exists (created in UC-02). |
| **Success guarantee** | Released quantity moves from held to accepted and becomes available; rejected quantity moves from held to written off. A quality check records quantities, reason, who and when (NFR-05). Held quantity is never available (BR-01). |
| **Minimal guarantee** | Nothing changes unless the whole check is valid. |
| **Requirements** | FR-06 · BR-01, BR-03 · A-04, A-08 · NFR-04, NFR-05 · RC-01, RC-04, RC-06 |
| **Gherkin** | GH-13 to GH-17 (`features/release_held_stock.feature`) |

## Main success scenario

1. The staff member asks for stock lots with held goods.
2. The system lists each lot with product, producer, batch, held quantity and hold reason.
3. The staff member selects a lot and checks the goods.
4. The staff member records the quantity to release.
5. The system moves that quantity from held to accepted, records the quality check with user and time, and shows the lot's new available and held quantities.

## Extensions

- **1a. The actor is a volunteer (RC-06):** the system refuses (`NOT_PERMITTED`). Nothing changes.
- **4a. Only part is fit to sell:** the staff member releases part; the rest stays held for a later check. Continue at 5.
- **4b. The hub manager rejects some or all goods:** the manager records the rejected quantity and a reason. The system moves it from held to written off. Continue at 5.
- **4c. A staff member who is not the manager tries to reject (A-04):** the system refuses (`NOT_PERMITTED`). Nothing changes.
- **4d. Released plus rejected is more than held, or both are zero:** the system refuses (`INVALID_QUANTITY`). Nothing changes.
- **4e. Rejected quantity given with no reason:** the system refuses (`INVALID_QUANTITY`). Nothing changes.
- **3a. The lot has no held quantity:** the system refuses (`INVALID_STATE`).

## Open issues

- Q-07: who decides when held goods return to stock is still an assumption (A-08, RC-06).
# Integration contract – interface catalogue

| Field | Content |
|-------|---------|
| Owner | Oleksandr Motoryhin (Alex) |
| Reviewers | All members (Danil first) |
| Backlog item | DES-26 (replaces ENB-02 after the brief update) |
| Related | OC-S1, UC-11, UC-03, SSD-S2, SPK-01, A-04, RC-03, RC-06, NFR-04, NFR-05 |

Every selected use case (UC-02, UC-03, UC-05, UC-06) designs against this file. It fixes the shared vocabulary so the four sequence diagrams and the integrated design class diagram use the same result type, error codes, roles, types and ports. A change here is made by pull request and reviewed by all members, because it affects every slice.

## 1. How to use this file

- Operation contracts list their controlled failures using only the codes in §3.
- Sequence diagrams show a refusal as `Failure(CODE)` and a success as `Success(value)` or the returned type.
- A new code, role or shared type is added here first, then used in a slice. A slice does not invent its own.

## 2. Result convention

Every system operation and every domain operation that can be refused returns `Result<T>`.

| Variant | Meaning |
|---------|---------|
| `Success(value: T)` | The operation was carried out; `value` is what the caller asked for. `Result<Void>` is used when there is nothing to return. |
| `Failure(code: ErrorCode, detail: String)` | An expected business refusal. `code` is one of §3; `detail` is a short human-readable reason for the actor. |

Rules:

1. **A failure changes nothing.** No object is created, changed or saved, so no partially valid object exists (OC "controlled failures"; UC minimal guarantees).
2. **The rule is checked by the object that owns the data**, which returns the failure up the chain. The handler only passes it on to the actor (DR-005, DR-006).
3. **The handler saves only on success.** Repository `save` calls appear after the last check in every sequence diagram.
4. **`Result` is for expected business refusals only.** Technical faults (storage unavailable, lost connection) are outside the CA2 design and are not error codes.

## 3. Error codes

The full set used in CA2. Codes are upper case and describe what is wrong, not where it happened.

| Code | Meaning | Typical causes | Raised in |
|------|---------|----------------|-----------|
| `NOT_FOUND` | A referenced object does not exist. | Unknown producer, delivery, line, product or stock lot. | S1 OC-01 to OC-04 · S2 `recordQualityCheck` |
| `NOT_PERMITTED` | The current role may not do this (§4). | Non-manager records *Rejected* at receipt (A-04); volunteer releases held stock or non-manager rejects it (RC-06, A-04). | S1 OC-03 · S2 UC-03 1a, 4c |
| `INVALID_QUANTITY` | A quantity, or the reason that must go with it, is not acceptable. | Quantity ≤ 0; accepted > received; released + rejected > held; no unit conversion; *Held* or *Rejected* with no reason. | S1 OC-03 · S2 UC-03 4d, 4e |
| `INVALID_STATE` | The object's current state does not allow the operation. | Receipt not started or already complete; line already recorded; lot has no held quantity. | S1 OC-01 to OC-04 · S2 UC-03 3a |
| `INVALID_TRACE` | Traceability details contradict each other. | Use-by date before delivery date; batch code given while `batchMissing` is true. | S1 OC-03 · UC-11 3a |

**Decisions recorded here**

- The four codes S1 and S2 already use (`NOT_FOUND`, `NOT_PERMITTED`, `INVALID_QUANTITY`, `INVALID_STATE`) are confirmed unchanged.
- `INVALID_TRACE`, proposed by S1, is **accepted** as a shared code. Folding it into `INVALID_QUANTITY` would hide the reason from the volunteer, and traceability is a Must rule in its own right (BR-03, FR-05).
- A missing reason for *Held*, *Rejected* or a quality-check rejection stays under `INVALID_QUANTITY`, as both S1 and S2 already use it. We did not add a separate code for one field.

## 4. Roles and permissions

`Role` is an enum with three values. The current role comes from `AuditContext.currentRole()`, never from an operation parameter (OC-S1). Roles follow the actor generalisation in CA1 (report §4.2): each role can do everything the role above it in the table can.

| Role | CA1 actor | Can do in addition |
|------|-----------|--------------------|
| `VOLUNTEER` | Hub volunteer | Record a delivery receipt as *Accepted*, *Partially accepted* or *Held* (UC-02) |
| `STAFF` | Hub staff member | Release held stock (UC-03, RC-06) |
| `MANAGER` | Hub manager | Reject goods at receipt (UC-02 6d, RC-03) and write off held stock (UC-03 4b) (A-04) |

Permission checks live with the object that owns the rule, for example `ReceiptOutcome.permittedFor(role)` in S1, so a change to Q-04 or Q-07 changes one place per rule.
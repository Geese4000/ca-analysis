# CA1 Candidate Product Backlog (User Stories)

## US-01 Record what actually arrived

- **Story:** As a hub volunteer, I want to record the received and accepted quantity for each delivery line, so that the hub knows how much can really be sold.
- **Business value:** Removes the main cause of reallocation errors (E-02).
- **Stakeholders:** SH-01 Hub manager, SH-03 Hub volunteer
- **Links:** FR-02, FR-03, BR-01, UC-02
- **Priority:** Must
- **Acceptance criteria:**
  - AC-01.1 Expected, received and accepted quantities are stored separately.
  - AC-01.2 Only the accepted quantity becomes available.
  - AC-01.3 A partially accepted line records the remainder as held or rejected.
- **Gherkin:** GH-01
- **Questions / assumptions:** Q-02, A-02

## US-02 Keep unchecked goods out of stock

- **Story:** As a packing volunteer, I want held goods to be excluded from available stock, so that I never pack goods that have not passed checking.
- **Business value:** Prevents unchecked produce reaching customers (E-04).
- **Stakeholders:** SH-03 Hub volunteer, SH-06/07 Customers
- **Links:** FR-06, BR-01, NFR-04, UC-02, UC-03
- **Priority:** Must
- **Acceptance criteria:**
  - AC-02.1 A held line adds 0 to available stock.
  - AC-02.2 Held quantity becomes available only after a recorded quality release.
- **Gherkin:** GH-02
- **Questions / assumptions:** Q-07, A-08

## US-03 Respect substitution preferences

- **Story:** As a customer, I want my acceptable substitutes and reduced-quantity preference to be recorded, so that I am not sent alternatives I would refuse.
- **Business value:** Fewer rejected items and complaints at handover (E-05).
- **Stakeholders:** SH-06 Household customer, SH-02 Hub staff member
- **Links:** FR-08, BR-05, UC-04, UC-06
- **Priority:** Must
- **Acceptance criteria:**
  - AC-03.1 Each order line can list zero or more permitted substitutes.
  - AC-03.2 A substitute that is not permitted cannot be allocated.
- **Gherkin:** GH-04
- **Questions / assumptions:** Q-06, A-06

## US-04 Warn hospitality customers early

- **Story:** As a hospitality customer, I want to be told about a reduced quantity before delivery, so that I can plan my menu.
- **Business value:** Keeps regular hospitality customers (E-06).
- **Stakeholders:** SH-07 Hospitality customer, SH-02 Hub staff member
- **Links:** FR-10, UC-06
- **Priority:** Should
- **Acceptance criteria:**
  - AC-04.1 Any order line allocated below its requested quantity shows the shortfall.
  - AC-04.2 The customer is flagged for contact before the delivery date.
- **Gherkin:** GH-03
- **Questions / assumptions:** Q-05, A-05

## US-05 Trace an item to its source

- **Story:** As the traceability coordinator, I want to see the producer and batch of any allocated item, so that I can respond to a quality or safety query.
- **Business value:** Restores traceability lost when stock is split (E-07).
- **Stakeholders:** SH-04 Traceability coordinator, SH-10 Regulator
- **Links:** FR-05, FR-09, FR-12, BR-03, NFR-05, UC-09
- **Priority:** Must
- **Acceptance criteria:**
  - AC-05.1 Every allocation is linked to exactly one stock lot.
  - AC-05.2 A trace lists each producer and batch contributing to the order line, with quantities.
- **Gherkin:** GH-05
- **Questions / assumptions:** Q-03, A-03

## US-06 See the hub at a glance

- **Story:** As the hub manager, I want a summary of expected vs accepted deliveries, held stock and shortfalls, so that I can act before orders are packed.
- **Business value:** Replaces manual reporting from spreadsheets (E-01).
- **Stakeholders:** SH-01 Hub manager
- **Links:** FR-13, UC-10
- **Priority:** Should
- **Acceptance criteria:**
  - AC-06.1 The summary shows expected vs accepted quantity per producer.
  - AC-06.2 The summary shows held stock, available stock, shortfalls and substitutions.
- **Gherkin:** none (verified by inspection)
- **Questions / assumptions:** Q-10

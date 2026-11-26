# DR-011 – Selected design scope reduced to three use cases

| Field | Content |
|-------|---------|
| Date | 2026-11-26 |
| Status | Accepted |
| Owner | Philip Dawson-Gariepy |
| Decided by | Philip Dawson-Gariepy, Danil Kramnov, Oleksandr Motoryhin |
| Related | DR-003, dossier section 3, RC-02, SPK-02, US-03, US-04 |

## Context

UC-06 Handle shortfall and the integrated design class diagram were assigned to Zakary Snyder (DR-003). By 26 Nov no work for either had been contributed, and the submission is close. The remaining members decided not to take on UC-06 in addition to their own use cases.

## Options

| Option | For | Against |
|--------|-----|---------|
| Keep four use cases; others design UC-06 | Covers the whole Product Goal | Unbalanced workload; rushed fourth chain likely inconsistent |
| **Design three use cases (UC-02, UC-03, UC-05)** | Brief section 7 allows one to three; rubric asks for 3–5; three complete, reviewed chains | Shortfall preferences (US-03, US-04) not designed |

## Decision

The selected design scope is UC-02, UC-03 and UC-05 (with UC-11 and UC-09). UC-06 is not designed. The integrated design class diagram moves to Philip Dawson-Gariepy.

## Consequences

- RC-02 and SPK-02 (shortage priority behind `AllocationPolicy`) stay open and are recorded as a design limitation. S3 already returns the shortfall quantity, so UC-06 can be added later without changing S3's contract.
- Dossier section 3, the traceability matrix, the interface catalogue and the package view are updated in the same change.
- Review ring is now three members (DR-003).
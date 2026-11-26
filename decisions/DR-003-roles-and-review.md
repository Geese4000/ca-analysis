# DR-003 – Roles and review ring

| Field | Content |
|-------|---------|
| Date | 2026-11-12 |
| Status | Accepted |
| Owner | Daniel Kramnov |
| Related | DES-02, Trello card "Who does what" |

## Roles

| Member | Slice | Use cases | Shared artefact |
|--------|-------|-----------|-----------------|
| Philip Dawson-Gariepy | S1 Receive delivery | UC-02, UC-11 | Technology record; board and backlog; dossier editor |
| Daniel Kramnov | S2 Stock decisions | UC-03, UC-08 returns | Reconciliation record; revised domain model |
| Oleksandr Motoryhin | S3 Allocate stock | UC-04, UC-05, UC-09 | Architecture and integration contract |
| Zakary Snyder | S4 Handle shortfall | UC-06 | Design class diagram |

## Review ring

| Author | Reviewed by |
|--------|-------------|
| Philip | Zak |
| Daniel | Philip |
| Alex | Daniel |
| Zak | Alex |

Shared artefacts get extra reviewers: the domain model and integration contract are reviewed by everyone; the design class diagram by Daniel and Alex.

## Rationale

Each member designs one slice end to end, so the work is comparable and each person can explain a full chain at the walkthrough. A review ring means every piece of work is checked by someone who did not write it.


## Change 2026-11-26 (DR-011)

UC-06 descoped. Integrated design class diagram reassigned from Zakary Snyder to Philip Dawson-Gariepy. Review ring for three members: Philip is reviewed by Alex; Danil by Philip; Alex by Danil. The integrated DCD is reviewed by Danil and Alex.
# CA2 – Collaborative Object-Oriented Design

**Module:** Object-Oriented Analysis and Design · **Group:** MTUCA2Group
**Members:** Philip Dawson-Gariepy, Danil Kramnov, Oleksandr Motoryhin, Zakary Snyder
**Scenario:** CA1-19-LPCH Kerry Local Food Hub ([DR-001](decisions/DR-001-scenario-selection.md))

## Product Goal

Give Kerry Local Food Hub staff and volunteers one reliable record of what has arrived, what is held and what is available, so that customers receive only checked goods, shortfalls follow customers' stated preferences, and every allocated item can be traced to its producer and batch. ([DR-002](decisions/DR-002-product-goal-and-dod.md))

## Selected design scope

UC-02 Receive delivery · UC-03 Release held stock · UC-05 Allocate stock · UC-06 Handle shortfall. See [dossier section 3](dossier/03-selected-design-scope.md) and the [CA2 traceability matrix](analysis/traceability-ca2.md).

## How we work

- **Backlog and board:** Trello (link: https://trello.com/invite/b/6ae8aa97f29ecaceb4239398/ATTI48b297c7096ae6107cb683c67108554f14AE61A7/ca2oopaad). Each card links to the pull request and files it produced.
- **Changes:** one branch per backlog item; merged to `main` only through a pull request approved by the reviewer named on the card.
- **Definition of Done:** [DR-002](decisions/DR-002-product-goal-and-dod.md).
- **Baselines:** tag `ca1-baseline` = CA1 analysis before reconciliation; tag `ca2-submission` = the submitted design.

## Contents

| Path | What it holds |
|------|---------------|
| `analysis/use-cases/` | Fully dressed use cases for the selected scope |
| `analysis/traceability-ca2.md` | CA2 traceability matrix and consistency evidence |
| `features/` | Gherkin scenarios (GH-xx) |
| `design/ssd/` | System sequence diagrams |
| `design/contracts/` | Operation contracts (OC-xx) |
| `design/crc/` | CRC cards |
| `design/sequence/` | Object-interaction sequence diagrams |
| `design/` | Design class diagram(s) |
| `decisions/` | Decision records (DR-xxx), spikes (SPK-xx), reconciliation record, AI use logs |
| `dossier/` | Sections of the group design dossier |
| `requirements/backlog.md` | User stories and acceptance criteria |
| `report/`, `diagrams/` | CA1 baseline analysis and domain model (revised only through the reconciliation record) |

## Identifier scheme

CA1: E evidence · A assumption · Q question · R risk · SH stakeholder · FR/NFR requirement · BR business rule · CON constraint · UC use case · GH Gherkin scenario · US user story.
CA2: DR decision record · SPK spike · RC reconciliation item · DES design task · DEF defect · OC operation contract · SSD / SD sequence diagrams · DCD design class diagram · S1–S4 use-case owner label.
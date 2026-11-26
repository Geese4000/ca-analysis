# DR-009 – Significant AI-supported design changes

| Field | Content |
|-------|---------|
| Date | 2026-11-26 |
| Status | Accepted |
| Owner | Philip Dawson-Gariepy |
| Reviewer | Oleksandr Motoryhin |
| Related | [Group AI declaration](ai-declaration-group.md), [ai-use-log.md](ai-use-log.md), [ai-use-log-kramnov.md](ai-use-log-kramnov.md) |

## Context

The brief requires a decision record for each significant AI-supported design change the group accepted, with evidence that people evaluated it. This record lists those changes, how each was checked, and suggestions that were changed or rejected.

## Accepted AI-supported changes

| Change | Where | How people evaluated it | Result |
|--------|-------|-------------------------|--------|
| One `StockLot` per received line with accepted, held and written-off quantities | OC-03, SD-S1a | Danil evaluated it independently against a separate held-goods object in SPK-01 before it was accepted | Accepted (SPK-01 option A) |
| One controller per use case instead of a hub facade | DR-005 | Philip compared three candidates; confirmed when S2 and S3 each designed their own controller | Accepted |
| `DeliveryLine` as creator of `StockLot` | DR-006 | Philip checked it against OC-03's postconditions and the domain model's `yields` association | Accepted |
| Session 14 alignment of S1: actor lifelines, `deliveryLineId` naming, SD-S1c, domain-model attribute names | PR #3, #4 | Checked against Session 14's design-ready audit; a later check found DEF-01 (multiplicity, out-of-date PNG), fixed in a follow-up change | Accepted with correction |
| Integrated design class diagram merged from the S1, S2 and S3 fragments | DCD-integrated, PR #12 | Merge exposed DEF-02 (two different available-quantity formulas); the group kept the interface catalogue's formula; a consistency check confirmed every sequence-diagram message maps to an operation | Accepted with correction |

## Changed or rejected AI suggestions

| Suggestion | What we did instead | Why |
|------------|---------------------|-----|
| Technology profile Java 21 + Maven 3.9 (DR-004) | Changed to Java 25 + Maven 3.10, then superseded | Newer LTS preferred by Philip; CA3 later removed by the updated brief |
| Keep four use cases by having others design UC-06 | Reduced scope to three use cases (DR-011) | Group decision not to move an absent member's work onto others |
| *(Danil: add any suggestion you changed or rejected)* | | |
| *(Alex: add any suggestion you changed or rejected)* | | |

## Consequences

Each listed change is traceable to a pull request. Any later change to these artefacts follows the normal review process (DR-002 Definition of Done).
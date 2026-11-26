# DR-001 – Scenario selection

| Field | Content |
|-------|---------|
| Date | 2026-11-12 |
| Status | Accepted|
| Owner | Daniel Kramnov |
| Decided by | Philip Dawson-Gariepy, Daniel Kramnov, Oleksandr Motoryhin, Zakary Snyder |
| Related | DES-01, DES-02|

## Context

Each member presented their CA1 scenario. The group compared all four against the four criteria in the CA2 brief and chose one to design together.

## Suitability matrix

H = high, M = medium, L = low.

| Criterion | 07 Community Energy Advice (Zak) | 19 Local Food Hub (Philip) | 27 Outdoor Equipment (Daniel) | 32 Property Maintenance (Alex) |
|---|---|---|---|---|
| **Manageable scope** | H – queries, appointments, advice, referrals | H – clear flow: receive, check, allocate, hand over | M – kits, components, eligibility, three levels of restriction | L – trials, duplicates, contractors, parts and access |
| **Behavioural richness** | M – mostly recording advice and follow-ups | H – accept, hold, release, reject, allocate, substitute | H – reserve, issue, extend, return, restrict | H – status terms have no agreed meaning |
| **OO design potential** | M – few calculations or state rules | H – StockLot quantities, outcomes, allocation rules | H – kit/component and model/item hierarchy classes | M – many records, unclear lifecycle |
| **Use-case and interaction design** | M – advice is hard to make concrete | H – each step has clear inputs, outputs and fails | M – key rules still open (eligibility, restrictions) | M – flows depend on unresolved access and status |
| **CA1 baseline completeness** | – | Most complete: fully dressed UC-02, Gherkin, domain model | Complete, but more open questions (Q01–Q07) | – |

## Decision

**Scenario 19, Kerry Local Food Hub.**

## Reasoning

- Its core problem, "received does not mean available", gives clear state changes (accepted, held, released, written off) with testable rules (BR-01, NFR-04).
- It splits easily into four slices of similar size, one per member: receive, release and returns, allocate, shortfall.

## Rejected alternatives

- **27 Outdoor Equipment:** eligibility and restriction rules were still unconfirmed, so too much of the design will be based on assumptions.
- **32 Property Maintenance:** scope too large for the short-term group project; status meanings are undefined.
- **07 Community Energy Advice:** manageable, but too little state change.

## Lecturer approval

Accepted by Lecturer upon team common agreement.

## Consequences

The CA1 Scenario 19 material is the baseline; changes are recorded as RC-xx in the reconciliation record (DES-04).
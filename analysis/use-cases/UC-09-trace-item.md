# UC-09 Trace item (fully dressed, CA2)

| Field | Content |
|-------|---------|
| **ID / slice** | UC-09 · S3 Allocate stock |
| **User stories** | US-05 Trace an item to its source (`requirements/backlog.md`) |
| **Scope** | Kerry Local Food Hub Stock and Order System |
| **Level** | User goal |
| **Primary actor** | Traceability coordinator (works with the `STAFF` role, see `design/interface-catalogue.md` §4) |
| **Stakeholders and interests** | Traceability coordinator: answer a quality or safety query quickly (E-07). Regulator: any allocated item can be traced to producer and batch (BR-03). Producer: only their own batch is named in a query. |
| **Trigger** | A quality or safety query arrives about an item on an order. |
| **Preconditions** | The actor is identified and has a role (NFR-05). The order exists. |
| **Success guarantee** | The actor sees, for the order line, every lot it was allocated from: producer, batch (or *batch missing*), harvest and use-by dates, delivery date and quantity. Nothing changes. |
| **Minimal guarantee** | Nothing changes. |
| **Requirements / rules** | FR-05, FR-09, FR-12 · BR-03 · A-03 |
| **Gherkin** | GH-05 (`features/trace_item.feature`) |

## Main success scenario

1. The coordinator identifies the order and the product in question.
2. The system shows each allocation on that order line: producer, batch, harvest and use-by dates, delivery date and allocated quantity.

## Extensions

- **1a. The actor is a volunteer:** the system refuses (`NOT_PERMITTED`).
- **1b. The order, or a line for that product on it, does not exist:** the system refuses (`NOT_FOUND`).
- **2a. Nothing has been allocated to the line yet:** the system shows an empty trace. This is not a failure.
- **2b. A lot was received without batch information (A-03):** the system shows *batch missing* for that lot, so the coordinator can follow up with the producer.

## Notes

UC-09 only reads data, so it has no operation contract. It works because UC-05 records one allocation per lot and every lot keeps its `TraceDetails` (BR-03).
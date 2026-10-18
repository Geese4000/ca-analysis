# 11. Reflection

## 11.1 Important decisions

**Separating StockLot from DeliveryLine.** The simpler option was to treat a delivery line as the stock itself, with a status field to say whether it was available. I rejected that because of the packing volunteer's point that "received does not mean available" (E-04). A delivery line records what happened at receipt. A stock lot is only what can be allocated. Because a line produces a stock lot only when goods are accepted (0..1), held goods can't be allocated by mistake, and BR-01 is built into the model instead of relying on a status flag being set correctly. I would keep this decision.

**Making Allocation a class.** A plain association between OrderLine and StockLot would have been simpler. But the traceability coordinator needs to know which producer and batch supplied an item *after* stock has been split (E-07), and one order line can draw from more than one lot. GH-05 shows this, with 36 eggs coming from two batches. An allocation needs its own quantity and time, so it has to be a class. This is the strongest chain in my traceability matrix, from E-07 through BR-03 to FR-12.

**Leaving shortage priority as an assumption.** I could have written a priority rule, such as hospitality customers first, and turned it into a business rule. The scenario says priority rules are informal, though (E-09), and tells us to identify uncertainty "rather than inventing a confirmed policy". So I recorded it as A-05 (allocate by order date) and Q-05 instead, which keeps the allocation requirements no more certain than the evidence.

## 11.2 Revisions

My first draft of the scenario interpretation (commit on 12 Oct) was a bullet list of separate problems: quantity differences, units, preferences, priority and traceability. When I rewrote it on 16 Oct, I saw that most of these come from one cause: a quantity moves through several states that are never recorded separately. I rewrote the problem statement around that cause and linked each claim to an evidence ID (E-01 to E-10). I also replaced the single dossier file and the Word document with separate section files so each part could be reviewed on its own.

## 11.3 Limitations and unresolved questions

Q-05 (shortage priority) limits the analysis most. FR-09, FR-10, GH-03 and risk R-01 all depend on A-05, so it is the first thing I would ask the hub manager. Next is Q-02 (unit conversion), because the availability figures are only as reliable as the conversion between supplied and selling units. FR-04 stays a Should until that is answered. Q-10 means FR-13's "producer contributions" is still undefined.

# 12. AI Declaration

| Tool | Purpose | Assessment areas affected |
|------|---------|---------------------------|
| Claude (Anthropic), via claude.ai | Explaining the brief and scenario; templates and worked examples from a different (library) domain | Sections 1–10 |
| Claude (Anthropic) | Tooling help: how to preview Markdown files and how to work with Gherkin feature files in VS Code | None directly (working environment only) |

**Representative interactions:** Asking for the scenario's core problem and key distinctions; asking for formats and worked examples from a different domain; asking how to view Markdown and use Gherkin in VS Code.

**Checks performed:** Checked each requirement against the scenario text and quotes; checked that no assumption is presented as a business rule; checked multiplicities against the scenario; rendered both diagrams from PlantUML; checked IDs are consistent across sections; reviewed the drafted reflection against my own reasoning and edited it.

**Accepted, modified or rejected:** Accepted the general structure and section order from the brief guidance. Modified the library-domain examples, because none of their content applied to the food hub; all requirements, rules, concepts and scenarios were written for Scenario 19.

The full interaction log is in `decisions/ai-use-log.md`.

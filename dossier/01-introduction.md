# 1. Introduction and Product Goal

Kerry Local Food Hub collects produce from local producers and allocates it to household, hospitality and community customers. Its core problem is that goods received are not the same as goods available: some fail checking, some are held, and allocations are made from stock that may not exist. CA2 designs the part of a system that fixes this.

**Product Goal:** give Kerry Local Food Hub staff and volunteers one reliable record of what has arrived, what is held and what is available, so that customers receive only checked goods, shortfalls follow customers' stated preferences, and every allocated item can be traced to its producer and batch (DR-002).

We designed three use cases in detail: UC-02 Receive delivery, UC-03 Release held stock and UC-05 Allocate stock (Section 3). Each follows one chain: backlog item → use case and Gherkin → system sequence diagram → operation contract → CRC and GRASP → sequence diagram → integrated design class diagram. The repository is the authoritative record; this dossier explains the decisions.
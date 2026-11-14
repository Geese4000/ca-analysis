# S1 subsections for dossier sections 4 and 8

Paste each under its section heading in the assembled dossier.

---

## 4.1 S1 Receive delivery – SSD and operation contracts

The SSD (Figure SSD-S1) shows the volunteer and the system as a black box exchanging four system events: `startReceipt`, `addLine` (unannounced deliveries only), `recordLineReceipt` and `completeReceipt`. `recordLineReceipt` carries the richest behaviour, so its contract (OC-03) has five controlled failures. The most important is `NOT_PERMITTED` when a volunteer records *Rejected*, which enforces A-04. Its postconditions create a stock lot whose held quantity is never available, which enforces BR-01 at the moment goods enter the system. Abandoning a receipt is deliberately not a system event: recorded lines keep their outcomes (RC-07).

---

## 8.1 S1 Receive delivery – slice specification (summary)

S1 receives a delivery line, converts the supplied unit to the selling unit, records the outcome and creates a traceable stock lot. `ReceiveDeliveryHandler` coordinates; `DeliveryLine` validates and creates the lot; `ReceiptOutcome` owns the rejection rule. S1 depends on no other slice. It runs against in-memory repositories, a fixed clock and fixed users (Aoife, volunteer; Niamh, manager), with its own fixtures. It is demonstrated by `mvn test -Dcucumber.filter.tags="@S1"`, which runs GH-01, GH-02 and GH-06 to GH-12. Full specification: Appendix, `slices/S1-receive-delivery.md`.
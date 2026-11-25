# S1 subsection for dossier section 4

Paste each under its section heading in the assembled dossier.

---

## 4.1 S1 Receive delivery – SSD and operation contracts

The SSD (Figure SSD-S1) shows the volunteer and the system as a black box exchanging four system events: `startReceipt`, `addLine` (unannounced deliveries only), `recordLineReceipt` and `completeReceipt`. `recordLineReceipt` carries the richest behaviour, so its contract (OC-03) has five controlled failures. The most important is `NOT_PERMITTED` when a volunteer records *Rejected*, which enforces A-04. Its postconditions create a stock lot whose held quantity is never available, which enforces BR-01 at the moment goods enter the system. Abandoning a receipt is deliberately not a system event: recorded lines keep their outcomes (RC-07).
# Links: UC-09 Trace item, UC-11 Record traceability details
Feature: Trace an allocated item
  The traceability coordinator can find which producer and batch supplied
  an item after stock has been split across orders.

  Rule: Every allocated quantity stays linked to its producer and batch (BR-03)

    @GH-05 @FR-05 @FR-09 @FR-12 @BR-03 @UC-09
    Scenario: Trace eggs on an order back to two batches
      Given batch "B-0412" of 60 "Free-range eggs" was accepted from producer "Lispole Hens"
      And batch "B-0415" of 30 "Free-range eggs" was accepted from producer "Dingle Farm Eggs"
      And order "ORD-1093" has 36 "Free-range eggs" allocated as 30 from batch "B-0412" and 6 from batch "B-0415"
      When the traceability coordinator traces the "Free-range eggs" on order "ORD-1093"
      Then the result shows 30 eggs from producer "Lispole Hens", batch "B-0412"
      And the result shows 6 eggs from producer "Dingle Farm Eggs", batch "B-0415"

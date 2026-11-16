# Links: UC-02 Receive delivery, UC-11 Record traceability details, UC-03 Release held stock
# Slice: S1 Receive delivery
# Assumes SPK-01 outcome: one stock lot per received line, with separate held and accepted quantities.
Feature: Receive delivery
  Hub volunteers record what each producer delivers so that only checked,
  accepted goods become available for customer orders, and every lot can be
  traced back to its producer and batch.

  Background:
    Given producer "Ballyheigue Greens" is expected to deliver 20 kg of "Rooster potatoes" today
    And "Rooster potatoes" has 0 kg available
    And volunteer "Aoife" is recording the receipt at 09:30

  Rule: Only the accepted quantity of a delivery line becomes available (BR-01)

    @GH-06 @FR-02 @FR-03 @FR-05 @NFR-05 @UC-02 @S1
    Scenario: Accept a full delivery line
      When Aoife records 20 kg received with batch "BG-1411"
      And Aoife accepts the line
      Then a stock lot for "Rooster potatoes" exists with 20 kg available and batch "BG-1411"
      And the lot is linked to producer "Ballyheigue Greens"
      And the line outcome is recorded by "Aoife" at 09:30

    @GH-01 @FR-02 @FR-03 @UC-02 @S1
    Scenario: Partially accept a delivery line
      When Aoife records 18 kg received with batch "BG-1411"
      And Aoife partially accepts the line with 15 kg accepted
      Then the delivery line shows 20 kg expected, 18 kg received and 15 kg accepted
      And "Rooster potatoes" has 15 kg available
      And 3 kg of "Rooster potatoes" is held awaiting a quality check

    @GH-02 @FR-06 @BR-01 @UC-02 @UC-03 @S1
    Scenario: Held stock is not available for allocation
      When Aoife records 18 kg received with batch "BG-1411"
      And Aoife holds the line because quality checking is incomplete
      Then "Rooster potatoes" still has 0 kg available
      And 18 kg of "Rooster potatoes" is held awaiting a quality check

  Rule: Only the hub manager may reject goods (A-04)

    @GH-07 @A-04 @UC-02 @S1
    Scenario: A volunteer cannot reject a delivery line
      When Aoife records 18 kg received with batch "BG-1411"
      And Aoife tries to reject the line because the potatoes are soft
      Then the receipt is refused because the actor is not permitted
      And the line has no outcome
      And "Rooster potatoes" still has 0 kg available

    @GH-08 @A-04 @FR-03 @UC-02 @S1
    Scenario: The hub manager rejects a delivery line
      Given hub manager "Niamh" is recording the receipt
      When Niamh records 18 kg received with batch "BG-1411"
      And Niamh rejects the line because the potatoes are soft
      Then the line outcome is "Rejected" with reason "potatoes are soft"
      And no stock lot exists for the line
      And "Rooster potatoes" still has 0 kg available

  Rule: The accepted quantity can never exceed the received quantity (NFR-04)

    @GH-09 @NFR-04 @UC-02 @S1
    Scenario Outline: Boundary of accepted quantity
      When Aoife records 18 kg received with batch "BG-1411"
      And Aoife partially accepts the line with <accepted> kg accepted
      Then the result is "<result>"
      And "Rooster potatoes" has <available> kg available

      Examples:
        | accepted | result           | available |
        | 18       | accepted         | 18        |
        | 18.5     | INVALID_QUANTITY | 0         |
        | 0        | INVALID_QUANTITY | 0         |

  Rule: Receipt is never blocked by missing producer records (A-03, BR-03)

    @GH-10 @FR-05 @A-03 @UC-11 @S1
    Scenario: Batch information is missing
      When Aoife records 20 kg received with the batch marked as missing
      And Aoife accepts the line
      Then a stock lot for "Rooster potatoes" exists with 20 kg available
      And the lot is linked to producer "Ballyheigue Greens" with batch missing
      And the receipt summary lists the line for batch follow-up

    @GH-11 @FR-01 @UC-02 @S1
    Scenario: Receive an unannounced delivery
      Given producer "Lispole Hens" has no expected delivery today
      When Aoife starts an unannounced receipt for "Lispole Hens"
      And Aoife adds a line for "Free-range eggs"
      And Aoife records 60 each received with batch "LH-22" and accepts the line
      Then the delivery is marked as unannounced
      And "Free-range eggs" has 60 each available

  Rule: Supplied units are converted to the selling unit (FR-04, A-02)

    @GH-12 @FR-04 @A-02 @UC-02 @S1
    Scenario: Convert boxes to the selling unit
      Given "Free-range eggs" are sold each and one box holds 12
      And producer "Lispole Hens" is expected to deliver 5 boxes of "Free-range eggs" today
      When Aoife records 5 box received with batch "LH-23" and accepts the line
      Then the line shows 5 box supplied and 60 each received
      And "Free-range eggs" has 60 each available
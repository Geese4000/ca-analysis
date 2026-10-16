# Links: UC-02 Receive delivery, UC-03 Release held stock
Feature: Receive delivery
  Hub volunteers record what each producer delivers so that only checked,
  accepted goods become available for customer orders.

  Background:
    Given producer "Ballyheigue Greens" is expected to deliver 20 kg of "Rooster potatoes" today

  Rule: Only the accepted quantity of a delivery line becomes available (BR-01)

    @GH-01 @FR-02 @FR-03 @UC-02
    Scenario: Partially accept a delivery line
      Given "Rooster potatoes" has 0 kg available
      When the volunteer records 18 kg received from "Ballyheigue Greens"
      And the volunteer partially accepts the line with 15 kg accepted
      Then the delivery line shows 20 kg expected, 18 kg received and 15 kg accepted
      And "Rooster potatoes" has 15 kg available

    @GH-02 @FR-06 @BR-01 @UC-02 @UC-03
    Scenario: Held stock is not available for allocation
      Given the volunteer has recorded 18 kg of "Rooster potatoes" received from "Ballyheigue Greens"
      And "Rooster potatoes" has 0 kg available
      When the volunteer holds the line because quality checking is incomplete
      Then "Rooster potatoes" still has 0 kg available
      And 18 kg of "Rooster potatoes" is shown as held awaiting a quality check

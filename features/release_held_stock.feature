# Links: UC-03 Release held stock
# Slice: S2 Stock decisions
# Builds on SPK-01: one stock lot with accepted and held quantities.
# Test users: Aoife (VOLUNTEER) and Niamh (MANAGER) Joe (STAFF).
Feature: Release held stock
  Staff check held goods so that only checked goods become available,
  and goods that fail the check are written off.

  Background:
    Given a stock lot of "Potatoes" from "Kerry Chips" with batch "B-228"
    And the lot has 13 kg accepted and 37 kg held
    And the quality check is recorded at 16:20

  Rule: Released goods become available; held goods never are (BR-01)

    @GH-13 @FR-06 @BR-01 @NFR-05 @UC-03 @S2
    Scenario: Staff member releases all held goods
      Given staff member "Joe" is checking the lot
      When Joe releases 37 kg
      Then the lot has 50 kg available and 0 kg held
      And the check is recorded by "Joe" at 16:20
      And the lot still shows batch "B-228"

    @GH-14 @FR-06 @A-04 @UC-03 @S2
    Scenario: Hub manager releases part and rejects the rest
      Given hub manager "Niamh" is checking the lot
      When Niamh releases 7 kg and rejects 30 kg because "potatoes are soft"
      Then the lot has 20 kg available, 0 kg held and 30 kg written off

  Rule: Only staff may release, and only the manager may reject (A-04, RC-06)

    @GH-15 @RC-06 @UC-03 @S2
    Scenario: A volunteer cannot release held goods
      Given volunteer "Aoife" is checking the lot
      When Aoife tries to release 37 kg
      Then the check is refused because the actor is not permitted
      And the lot still has 13 kg available and 37 kg held

    @GH-16 @A-04 @UC-03 @S2
    Scenario: A staff member cannot reject held goods
      Given staff member "Joe" is checking the lot
      When Joe tries to reject 1 kg because "potatoes are soft"
      Then the check is refused because the actor is not permitted
      And the lot still has 37 kg held

  Rule: A check can never move more than is held (NFR-04)

    @GH-17 @NFR-04 @UC-03 @S2
    Scenario Outline: Boundary of released quantity
      Given staff member "Joe" is checking the lot
      When Joe releases <released> kg
      Then the result is "<result>"
      And the lot has <available> kg available

      Examples:
        | released | result           | available |
        | 37       | accepted         | 50        |
        | 37.5     | INVALID_QUANTITY | 13        |
        | 0        | INVALID_QUANTITY | 13        |
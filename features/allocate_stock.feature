# Links: UC-05 Allocate stock to orders, UC-06 Handle shortfall
# Assumes A-05: during a shortage, orders are allocated in order-date order.
Feature: Allocate stock to orders
  Hub staff allocate available stock to order lines and respect each
  customer's recorded preferences when there is not enough.

  Rule: A shortfall is resolved only within the customer's recorded preferences (BR-05)

    @GH-03 @FR-08 @FR-10 @UC-06
    Scenario: Short by 1 kg where the customer accepts a reduced quantity
      Given "Strawberries" has 4 kg available
      And "Café Lir" has ordered 5 kg of "Strawberries" for Friday
      And "Café Lir" accepts a reduced quantity for "Strawberries"
      When the staff member allocates "Strawberries" to the order
      Then 4 kg of "Strawberries" is allocated to the "Café Lir" order
      And the order line shows a shortfall of 1 kg
      And "Café Lir" is flagged to be told before delivery

    @GH-04 @FR-08 @BR-05 @UC-06
    Scenario: Refuse a substitute the customer has not permitted
      Given "Cherry tomatoes" has 0 kg available
      And "Plum tomatoes" has 3 kg available
      And household customer "Niamh Doyle" has ordered 1 kg of "Cherry tomatoes"
      And "Niamh Doyle" permits only "Vine tomatoes" as a substitute for "Cherry tomatoes"
      When the staff member tries to substitute "Plum tomatoes" on that order line
      Then the substitution is refused
      And the staff member is told the customer has not permitted "Plum tomatoes"
      And "Plum tomatoes" still has 3 kg available


# --- S3 Allocate stock (UC-05): GH-18 to GH-22 ---
# Test users: Joe (STAFF) and Aoife (VOLUNTEER). Lots are used earliest use-by first (UC-05 step 4).

Rule: Every allocated quantity comes from one stock lot and keeps its batch (FR-09, BR-03)

  @GH-18 @FR-09 @BR-03 @NFR-05 @UC-05 @S3
  Scenario: Allocate an order line from one stock lot
    Given a stock lot of "Strawberries" from "Kerry Berries" with batch "B-301" has 10 kg available
    And "Café Lir" has ordered 4 kg of "Strawberries"
    And staff member "Joe" is allocating at 09:15
    When Joe allocates the "Strawberries" line
    Then 4 kg is allocated to the line from batch "B-301"
    And the lot has 6 kg available
    And the allocation is recorded by "Joe" at 09:15

  @GH-19 @FR-09 @FR-12 @BR-03 @UC-05 @S3
  Scenario: A line is split across lots, earliest use-by first
    Given a stock lot of "Free-range eggs" from "Lispole Hens" with batch "B-0412" has 30 available, use-by 2 December
    And a stock lot of "Free-range eggs" from "Dingle Farm Eggs" with batch "B-0415" has 30 available, use-by 5 December
    And order "ORD-1093" has a line for 36 "Free-range eggs"
    And staff member "Joe" is allocating
    When Joe allocates the "Free-range eggs" line
    Then 30 is allocated from batch "B-0412" and 6 from batch "B-0415"
    And batch "B-0412" has 0 available and batch "B-0415" has 24 available

Rule: Allocation never takes more than is available, and held stock is never available (NFR-04, BR-01)

  @GH-20 @NFR-04 @FR-09 @UC-05 @S3
  Scenario Outline: Boundary of allocated quantity
    Given a stock lot of "Strawberries" has 4 kg available
    And an order line requests <requested> kg of "Strawberries"
    And staff member "Joe" is allocating
    When Joe allocates the line
    Then <allocated> kg is allocated
    And the line shows a shortfall of <shortfall> kg
    And the lot has <left> kg available

    Examples:
      | requested | allocated | shortfall | left |
      | 3         | 3         | 0         | 1    |
      | 4         | 4         | 0         | 0    |
      | 5         | 4         | 1         | 0    |

  @GH-21 @BR-01 @NFR-04 @FR-06 @UC-05 @S3
  Scenario: Held stock is not allocated
    Given a stock lot of "Potatoes" with batch "B-228" has 13 kg accepted and 37 kg held
    And an order line requests 20 kg of "Potatoes"
    And staff member "Joe" is allocating
    When Joe allocates the line
    Then 13 kg is allocated from batch "B-228"
    And the line shows a shortfall of 7 kg
    And the lot still has 37 kg held

Rule: Only staff may allocate stock (UC-05 1a)

  @GH-22 @NFR-05 @UC-05 @S3
  Scenario: A volunteer cannot allocate stock
    Given a stock lot of "Strawberries" has 10 kg available
    And an order line requests 4 kg of "Strawberries"
    And volunteer "Aoife" is allocating
    When Aoife tries to allocate the line
    Then the allocation is refused because the actor is not permitted
    And the lot still has 10 kg available

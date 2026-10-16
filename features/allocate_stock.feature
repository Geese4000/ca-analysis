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

# DES-14 Toolchain proof (DR-004)
Feature: Toolchain check
  Every member proves the agreed profile builds and runs both unit and BDD tests.

  Scenario: The agreed profile runs on a member's machine
    Given a member has cloned the group repository
    When the member runs the test command
    Then the build uses Java 25 or later
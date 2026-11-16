# 9. Technology Decision

We chose Java 25 LTS with Maven 3.10, JUnit Jupiter 5.11.4 and Cucumber-JVM 7.20.1 (DR-004). Java's interfaces and records map directly onto our ports and value objects, so the design class diagram becomes code with little interpretation. Maven pins every version in one file, and each slice tags its Gherkin scenarios (`@S1`–`@S4`) so it can be run alone with `mvn test -Dcucumber.filter.tags="@S1"`. This supports the brief's rule that every slice is independently testable.

C# was equally suitable and was the main alternative; Python was rejected because the compiler would not check our port contracts. *(Confirm before submitting:)* Every member ran the toolchain proof (`ca3-toolchain-check`, `mvn test`) before submission; results are in the DR-004 proof table.
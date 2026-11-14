# DR-004 – Technology profile for CA3

| Field | Content |
|-------|---------|
| Date | 2026-11-15 (for agreement at contract sign-off) |
| Status | Proposed |
| Proposed by | Philip Dawson-Gariepy |
| Decided by | *(names present at sign-off)* |
| Related | DES-07, DES-14, integration contract §6 |

## Context

CA3 slices must build and test the same way on all four machines, with exact versions and commands (CA2 brief §5). The brief allows a Java, C# or Python profile. The design so far uses interfaces for every cross-slice port, value objects and a `Result<T>` type, so the language needs good interface support, a mature unit framework and a Gherkin runner.

## Options considered

| | Java | C# | Python |
|---|------|----|--------|
| Runtime | JDK 25 LTS | .NET 8 LTS | Python 3.12 |
| Build / dependency tool | Maven 3.9 | dotnet CLI / NuGet | pip + venv |
| Unit framework | JUnit 5 | xUnit | pytest |
| BDD tool | Cucumber-JVM 7 | Reqnroll | behave |
| Fit with our design | Interfaces, records for value objects, sealed types for `Result` | Same strengths; records and interfaces | Interfaces only by convention (ABC / Protocol); weaker compile-time checking of contracts |
| Group experience | *(fill in at sign-off)* | | |

## Decision (proposed)

| Item | Value |
|------|-------|
| Language and version | Java 25 (LTS) |
| JDK | Eclipse Temurin 25 (any 25.0.x) |
| IDE | IntelliJ IDEA Community 2025.x, or VS Code with "Extension Pack for Java" |
| Build / dependency tool | Apache Maven 3.9.x |
| Unit test framework | JUnit Jupiter 5.11.4 (via `junit-bom`) |
| BDD tool | Cucumber-JVM 7.20.1 with `cucumber-junit-platform-engine` and `junit-platform-suite` |
| Compiler / test plugins | maven-compiler-plugin 3.13.0 (`release 25`), maven-surefire-plugin 3.5.2 |
| Build command | `mvn compile` |
| Test command (unit + BDD) | `mvn test` |
| Run one slice's scenarios | `mvn test -Dcucumber.filter.tags="@S1"` (S2, S3, S4 likewise) |
| Package layout | `ie.mtu.kerryhub.shared`, `.receiving` (S1), `.stockdecisions` (S2), `.allocation` (S3), `.shortfall` (S4), `.fakes` |

## Rationale

- Java's interfaces and records map directly to our ports and value objects, so the design class diagram translates to code with little interpretation.
- Every slice can tag its scenarios (`@S1`–`@S4`) and run them alone, which supports the brief's rule that each slice is independently testable.
- Maven pins every version in one `pom.xml`, so "works on my machine" problems show up at DES-14 rather than in CA3.
- C# would be equally suitable; switch if most of the group is more fluent in it. Python is the weakest fit because port contracts are not checked by the compiler.

## Consequences

- Every member installs Temurin 25 and Maven 3.10 before Wednesday 18 and runs the proof below.
- Gherkin files move to `src/test/resources/features/` in CA3 and keep their GH and slice tags.
- If the group chooses C# or Python instead, the proof project is replaced and this record is updated with the same table filled in.

## Proof the profile works

Each member runs, from `ca3-toolchain-check/`:

```
mvn -v
mvn test
```

Pass = `BUILD SUCCESS` with `Tests run: 2, Failures: 0, Errors: 0` (one JUnit test, one Cucumber scenario).

| Member | OS | `mvn -v` Java / Maven | `mvn test` result | Date | Evidence (PR / screenshot) |
|--------|----|-----------------------|-------------------|------|----------------------------|
| Philip | Windows 11 | Java 25.0.5 / Maven 3.10.0 | BUILD SUCCESS, 2 tests, 0 failures | 2026-11-14 | *(PR link)* |
| Member B | | | | | |
| Member C | | | | | |
| Member D | | | | | |
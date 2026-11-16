# CA3 toolchain check (DES-14)

Proves the DR-004 profile works on your machine. From this folder:

```
mvn -v          # must show Maven 3.10.x and Java 25
mvn test        # must end with BUILD SUCCESS and "Tests run: 2, Failures: 0"
```

The two tests are one JUnit test and one Cucumber scenario. Record your result in the proof table in `decisions/DR-004-technology-profile.md`.
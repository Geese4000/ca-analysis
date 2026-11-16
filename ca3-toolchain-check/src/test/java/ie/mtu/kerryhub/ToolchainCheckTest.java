package ie.mtu.kerryhub;

import static org.junit.jupiter.api.Assertions.assertTrue;
import org.junit.jupiter.api.Test;

class ToolchainCheckTest {

    // Fails on a machine running an older JDK, which is exactly what DES-14 should catch
    @Test
    void buildRunsOnJava25OrLater() {
        assertTrue(ToolchainCheck.meetsGroupProfile(),
                "Expected Java 25+, found " + ToolchainCheck.javaMajorVersion());
    }
}

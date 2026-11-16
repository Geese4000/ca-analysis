package ie.mtu.kerryhub;

/**
 * Smallest possible production class, used only to prove the DR-004 toolchain
 * compiles and tests on every member's machine. Delete once real slices exist.
 */
public final class ToolchainCheck {

    private ToolchainCheck() {
    }

    // Reads the major version of the JVM running the build, e.g. "25.0.1" -> 25
    public static int javaMajorVersion() {
        return Runtime.version().feature();
    }

    public static boolean meetsGroupProfile() {
        return javaMajorVersion() >= 25;
    }
}
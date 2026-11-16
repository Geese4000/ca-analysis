package ie.mtu.kerryhub.steps;

import static org.junit.jupiter.api.Assertions.assertTrue;

import ie.mtu.kerryhub.ToolchainCheck;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

public class ToolchainSteps {

    private int majorVersion;

    @Given("a member has cloned the group repository")
    public void aMemberHasClonedTheGroupRepository() {
        // Nothing to set up: reaching this step means Maven resolved and compiled the project
    }

    @When("the member runs the test command")
    public void theMemberRunsTheTestCommand() {
        majorVersion = ToolchainCheck.javaMajorVersion();
    }

    @Then("the build uses Java {int} or later")
    public void theBuildUsesJavaOrLater(int minimum) {
        assertTrue(majorVersion >= minimum, "Found Java " + majorVersion);
    }
}

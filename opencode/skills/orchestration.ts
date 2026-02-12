import { Plugin } from "@opencode-ai/plugin";

export default (async ({ client, project, directory }) => {
  return {
    "command.execute.before": async (input, output) => {
      const { command, arguments: args } = input;

      // /analyze - Just code reading
      if (command === "analyze") {
        output.parts = [
          {
            type: "text",
            text: "# Code Analysis\n\n",
          },
          {
            type: "agent",
            agent: "code-reader",
            prompt: `Analyze codebase for: ${args}\n\nProvide file references only, no code examples.`,
          },
        ];
      }

      // /develop - Just development (assumes files are known)
      if (command === "develop") {
        output.parts = [
          {
            type: "text",
            text: "# Development Task\n\n",
          },
          {
            type: "agent",
            agent: "coder",
            prompt: `Implement the following changes: ${args}\n\nReport back with brief summary of modifications.`,
          },
        ];
      }

      // /review - Just review (assumes changes are made)
      if (command === "review") {
        output.parts = [
          {
            type: "text",
            text: "# Code Review\n\n",
          },
          {
            type: "agent",
            agent: "reviewer",
            prompt: `Review recent changes related to: ${args}\n\nProvide brief feedback following the format: ✓ Approved or ✗ Issues found with specific fixes.`,
          },
        ];
      }

      // /orchestrate - Full manager-driven workflow
      if (command === "orchestrate") {
        output.parts = [
          {
            type: "text",
            text: "# Manager Orchestration\n\n",
          },
          {
            type: "agent",
            agent: "manager",
            prompt: `User Request: ${args}\n\nCoordinate the workflow using available agents (code-reader, coder, reviewer, tester). Follow the complete workflow: code-reader → coder → reviewer → tester. Report final status.`,
          },
        ];
      }

      // /test - Just run tests
      if (command === "test") {
        output.parts = [
          {
            type: "text",
            text: "# Running Tests\n\n",
          },
          {
            type: "agent",
            agent: "tester",
            prompt: `Run tests for: ${args}\n\nProvide concise feedback: ✓ pass or ✗ fail with file:line of failures.`,
          },
        ];
      }
    },
  };
}) satisfies Plugin;

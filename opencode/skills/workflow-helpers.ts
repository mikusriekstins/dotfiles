import { Plugin } from "@opencode-ai/plugin";

/**
 * Helper utilities for agent orchestration
 * Provides status tracking and workflow optimization
 */

export default (async ({ client }) => {
  return {
    "command.execute.before": async (input, output) => {
      const { command, arguments: args } = input;

      // /workflow-status - Show current workflow state
      if (command === "workflow-status") {
        output.parts = [
          {
            type: "text",
            text: `# Workflow Status

**Available Agents:**
- 🎯 Manager (coordinator)
- 🔍 Code Reader (navigator)
- 💻 Coder (developer)
- ✅ Reviewer (validator)
- 🧪 Tester (test runner)

**Standard Workflow:**
code-reader → coder → reviewer → tester → report
  ↑                                  |
  └──────────(if fails)──────────────┘

**Available Commands:**
- \`/orchestrate <task>\` - Full workflow (all agents)
- \`/analyze <query>\` - Code analysis only
- \`/develop <task>\` - Development only
- \`/review <context>\` - Review only
- \`/test <context>\` - Run tests only
- \`/quick <task>\` - Fast path (reader + coder)
- \`/plan <task>\` - Planning only

**Token Optimization:**
- Agents use minimal responses
- File references instead of code
- Test output summarized by Tester
- Context split across specialists
`,
          },
        ];
      }

      // /quick - Fastest path for simple tasks
      if (command === "quick") {
        output.parts = [
          {
            type: "text",
            text: "# Quick Task (Code Reader + Coder)\n\n",
          },
          {
            type: "agent",
            agent: "code-reader",
            prompt: `Quick analysis for: ${args}\nMax 3 files.`,
          },
        ];
      }

      // /plan - Planning phase (manager only)
      if (command === "plan") {
        output.parts = [
          {
            type: "text",
            text: "# Task Planning\n\n",
          },
          {
            type: "agent",
            agent: "manager",
            prompt: `Create implementation plan for: ${args}\n\nBreak into subtasks. No code, just file:line references and steps.`,
          },
        ];
      }
    },
  };
}) satisfies Plugin;

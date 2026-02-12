# Multi-Agent Orchestration System

## Overview
This setup uses specialized agents to distribute work, save tokens, and increase success rates by splitting responsibilities.

## Agents

### 1. Manager (Primary)
- **Role**: Task coordinator and workflow manager
- **Model**: qwen3-coder-next @ temp 0.3
- **Permissions**: Read only
- **Usage**: Orchestrates other agents, reports status
- **Communication**: Brief and precise, references files as `file:line`

### 2. Code Reader
- **Role**: Codebase navigator and file finder
- **Model**: qwen3-coder-next @ temp 0.1
- **Permissions**: Read + Bash
- **Usage**: Finds relevant files/lines for tasks
- **Output Format**:
  ```
  src/file.ts:45 - description
  lib/other.ts:12 - description
  ```
- **Rules**: No code examples, max 5 files per response

### 3. Coder (Developer)
- **Role**: Implementation specialist
- **Model**: qwen3-coder-next @ temp 1.0
- **Permissions**: Read, Write, Edit, Bash
- **Usage**: Implements changes with strict quality standards
- **Output Format**: "Modified X, added Y, removed Z"
- **Rules**: No comments unless critical, small incremental edits

### 4. Reviewer
- **Role**: Quality validator
- **Model**: qwen3-coder-next @ temp 0.1
- **Permissions**: Read + Bash
- **Usage**: Reviews diffs, finds critical issues
- **Output Format**:
  ```
  ✓ Approved
  OR
  ✗ Issues found:
  file:line - issue
  Fix: solution
  ```
- **Rules**: Max 3 issues per review, skip trivial details

## Workflow Commands

### /orchestrate <task>
Full manager-driven workflow. Manager coordinates all agents.
```bash
/orchestrate add user authentication
```

### /analyze <query>
Quick code analysis using code-reader only.
```bash
/analyze authentication flow
```

### /develop <task>
Direct development task (assumes files are known).
```bash
/develop add login validation to auth.ts
```

### /review <context>
Review recent changes.
```bash
/review authentication implementation
```

### /implement <task>
Full workflow: code-reader → coder → reviewer → report.
```bash
/implement add password reset feature
```

## Standard Workflow

1. **Discovery** (Code Reader)
   - User provides task
   - Code Reader finds relevant files
   - Returns: `file:line` references

2. **Implementation** (Coder)
   - Receives file references
   - Makes small, incremental changes
   - Returns: Brief change summary

3. **Validation** (Reviewer)
   - Reviews diff
   - Checks: security, performance, types, style
   - Returns: ✓ or ✗ with fixes

4. **Reporting** (Manager)
   - Aggregates results
   - Reports completion or requests clarification

## Token Optimization

- All agents use concise communication
- No code examples in responses (just references)
- Manager delegates instead of duplicating work
- Context split across specialized agents
- Max response lengths enforced

## Configuration Files

- `agents/manager.md` - Manager definition
- `agents/code-reader.md` - Code reader definition
- `agents/coder.md` - Developer definition
- `agents/reviewer.md` - Reviewer definition
- `skills/orchestration.ts` - Workflow commands
- `opencode.json` - Main config

## Customization

### Adjust agent temperature:
Edit frontmatter in `agents/*.md`:
```yaml
temperature: 0.1  # Lower = more focused
```

### Adjust permissions:
Modify `tools:` section in agent frontmatter:
```yaml
tools:
  write: true/false
  edit: true/false
  read: true/false
  bash: true/false
```

### Add new workflows:
Edit `skills/orchestration.ts` and add new command handlers.

## Example Usage

**Scenario**: Add a new API endpoint

```bash
# Option 1: Full orchestration
/orchestrate add POST /api/users endpoint with validation

# Option 2: Step-by-step
/analyze API endpoint structure
/develop add POST /api/users to routes.ts:45
/review API endpoint implementation
```

## Iteration Tips

1. **Start small**: Test with simple tasks first
2. **Monitor token usage**: Check which agents use most tokens
3. **Refine prompts**: Update agent instructions based on results
4. **Adjust temperatures**: Fine-tune for quality vs creativity
5. **Add workflows**: Create new commands in orchestration.ts

## Troubleshooting

**Agents not found:**
```bash
opencode agent list  # Verify agents are registered
```

**Plugin not loading:**
- Check `opencode.json` plugins array
- Verify `skills/orchestration.ts` exists
- Check console for errors

**Agents too verbose:**
- Lower temperature in agent config
- Update agent instructions to emphasize brevity
- Add explicit response format examples

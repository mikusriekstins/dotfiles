# Agent Orchestration - Quick Reference

## 🎯 Commands

| Command | Agent(s) | Use Case | Output |
|---------|----------|----------|--------|
| `/orchestrate <task>` | Manager → All | Full workflow coordination | Status report |
| `/implement <task>` | Reader → Coder → Reviewer | Structured implementation | Change summary + review |
| `/analyze <query>` | Code Reader | Find relevant files | file:line refs |
| `/develop <task>` | Coder | Direct implementation | Brief change summary |
| `/review <context>` | Reviewer | Validate changes | ✓/✗ + issues |
| `/quick <task>` | Reader + Coder | Fast simple tasks | Combined output |
| `/plan <task>` | Manager | Task breakdown | Subtask plan |
| `/workflow-status` | None | Show system status | Agent list + help |

## 🤖 Agent Capabilities

```
Manager (coordinator)
├─ Read only
├─ No Bash
├─ Temp: 0.3
└─ Orchestrates workflow

Code Reader (navigator)
├─ Read + Bash
├─ Temp: 0.1 (focused)
└─ Output: file:line refs

Coder (developer)
├─ Read + Write + Edit + Bash
├─ Temp: 1.0 (creative)
└─ Output: "Modified X, added Y"

Reviewer (validator)
├─ Read + Bash
├─ Temp: 0.1 (strict)
└─ Output: ✓ or ✗ + fixes
```

## 📊 Workflow Patterns

### Pattern 1: Full Implementation
```
User → /implement <task>
├─ Code Reader finds files
├─ Coder implements changes
├─ Reviewer validates
└─ Manager reports result
```

### Pattern 2: Quick Fix
```
User → /quick <task>
├─ Code Reader finds file
└─ Coder makes change
```

### Pattern 3: Planning First
```
User → /plan <task>
├─ Manager creates plan
User approves
└─ /implement <task>
```

### Pattern 4: Manual Steps
```
User → /analyze <query>
Check results
User → /develop <specific task>
User → /review
```

## 💡 Best Practices

**DO:**
- Use `/orchestrate` for complex multi-step tasks
- Use `/quick` for single-file simple changes
- Use `/plan` when unsure about approach
- Let agents handle their specialties

**DON'T:**
- Mix agent responsibilities manually
- Ask for code examples (use file:line refs)
- Repeat what agents already did
- Skip review step for critical changes

## 🔧 Token Optimization

**Agents communicate in:**
- Manager: 3-sentence max status reports
- Code Reader: file:line + 1-line description (max 5 files)
- Coder: "Modified file:line - what changed"
- Reviewer: ✓ or ✗ + max 3 issues

**To save tokens:**
1. Use specific commands (not `/orchestrate` for everything)
2. Provide clear task descriptions
3. Trust agent outputs (don't verify manually)
4. Use `/quick` for trivial tasks

## 🚀 Examples

**Add feature:**
```
/implement add user logout functionality
```

**Fix bug:**
```
/quick fix typo in auth validation message
```

**Refactor code:**
```
/plan refactor authentication module
/implement [approved plan]
```

**Understand code:**
```
/analyze how user session management works
```

**Quality check:**
```
/review recent authentication changes
```

## 🎛️ Customization

**Adjust agent verbosity:**
```bash
# Edit agents/*.md
# Change temperature (0.1 = focused, 1.0 = creative)
# Update instructions to emphasize brevity
```

**Add new workflow:**
```typescript
// Edit skills/orchestration.ts
if (command === "my-workflow") {
  output.parts = [
    { type: "agent", agent: "...", prompt: "..." }
  ];
}
```

**Change agent capabilities:**
```yaml
# In agents/*.md frontmatter
tools:
  write: true   # Allow file writing
  edit: true    # Allow file editing
  read: true    # Allow file reading
  bash: true    # Allow shell commands
```

## 📈 Iteration Strategy

1. **Week 1**: Use `/orchestrate` for everything, observe patterns
2. **Week 2**: Switch to specific commands based on task type
3. **Week 3**: Adjust agent temperatures and prompts
4. **Week 4**: Create custom workflows for common tasks
5. **Ongoing**: Monitor token usage, refine agent instructions

## 🐛 Debugging

**Agents not responding:**
```bash
opencode agent list  # Check if agents registered
```

**Wrong agent used:**
```
# Check command in skills/orchestration.ts
# Verify agent name matches agents/*.md filename
```

**Too verbose:**
```
# Lower temperature in agent config
# Add explicit word/sentence limits to agent prompt
# Use more specific commands instead of /orchestrate
```

**Missing context:**
```
# Use /orchestrate instead of individual commands
# Manager will coordinate context sharing
```

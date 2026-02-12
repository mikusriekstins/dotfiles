# Token Optimization & Performance Guide

## Token Budget Strategy

### Current Setup
- **Target**: Keep under 65k context per session
- **Method**: Split work across 4 specialized agents
- **Benefit**: 4x effective context (4 agents × ~15k each)

### Token Usage by Agent

| Agent | Avg Input | Avg Output | Total/Task |
|-------|-----------|------------|------------|
| Code Reader | 500-1k | 200-500 | ~1.5k |
| Coder | 1k-3k | 500-1k | ~4k |
| Reviewer | 1k-2k | 200-400 | ~2k |
| Manager | 800-1.5k | 300-600 | ~2k |

**Total per full workflow**: ~9.5k tokens vs ~20k+ with single agent

## Communication Protocol

### Manager Output Format
```
Status: [Complete|Blocked|In Progress]
Changes: file:line
Issues: [None|List]
Next: [Done|Action needed]
```

### Code Reader Output Format
```
file1.ts:45 - auth handler
file2.ts:12 - validation
file3.ts:89 - types
```
**Rules**: No code, no explanations, max 5 files

### Coder Output Format
```
Modified: auth.ts:45 - added validation
Added: types.ts:30 - User interface
```
**Rules**: One line per change, no code blocks

### Reviewer Output Format
```
✓ Approved
```
OR
```
✗ Issues:
auth.ts:50 - missing null check
Fix: add if (!user) return
```
**Rules**: Max 3 issues, brief fixes only

## Prompt Optimization

### ✅ Good Prompts
```
/implement add logout button to nav component
/analyze authentication flow
/develop add validation to login form
```

**Why**: Specific, actionable, single responsibility

### ❌ Bad Prompts
```
/orchestrate make the app better
/analyze the entire codebase and find all issues
/develop add features we discussed
```

**Why**: Vague, too broad, requires clarification

## Agent Selection Matrix

| Task Type | Command | Agent(s) | Token Cost |
|-----------|---------|----------|------------|
| Find files | `/analyze` | Reader | Low (~1k) |
| Simple edit | `/quick` | Reader+Coder | Medium (~3k) |
| Feature add | `/implement` | Reader+Coder+Reviewer | High (~8k) |
| Complex feature | `/orchestrate` | Manager+All | Very High (~10k) |
| Code review | `/review` | Reviewer | Low (~2k) |
| Task planning | `/plan` | Manager | Low (~1.5k) |

## Performance Tuning

### 1. Temperature Settings

```yaml
# For deterministic tasks (finding bugs, reviewing)
temperature: 0.1

# For balanced tasks (managing, coordinating)
temperature: 0.3

# For creative tasks (implementing features)
temperature: 1.0
```

**Current setup**:
- Code Reader: 0.1 (precise)
- Manager: 0.3 (balanced)
- Reviewer: 0.1 (strict)
- Coder: 1.0 (creative)

### 2. Model Selection

```yaml
# Fast for simple tasks
model: llama.cpp/qwen/qwen3-coder-next

# For complex reasoning (future)
# model: llama.cpp/qwen/qwen3-coder-70b
```

### 3. Tool Restrictions

**Minimize tool access**:
- Manager: Read only (no bash, write, edit)
- Code Reader: Read + Bash (no write)
- Reviewer: Read + Bash (no write)
- Coder: Full access (all tools)

**Why**: Prevents agents from doing work outside their role

## Context Management

### 1. Agent Isolation
Each agent has its own context:
```
Manager: 0-15k tokens
├─ Code Reader: 0-10k
├─ Coder: 0-20k (largest)
└─ Reviewer: 0-8k
```

**Total available**: ~53k tokens vs 65k limit for single agent

### 2. Session Strategy

**Short tasks** (<10 changes):
- Use `/quick` or `/implement`
- Complete in single session

**Medium tasks** (10-50 changes):
- Use `/orchestrate`
- Manager coordinates multiple rounds

**Large tasks** (50+ changes):
- Use `/plan` first
- Break into multiple `/implement` sessions
- Review after each batch

### 3. Memory Offloading

When context gets full:
1. Manager summarizes completed work
2. Start fresh session for next subtask
3. Reference previous session summary

## Monitoring & Metrics

### Check Token Usage
```bash
opencode stats  # View token statistics
```

### Indicators of Inefficiency

**High token usage**:
- Agents repeating information
- Code examples in responses
- Vague task descriptions
- Using `/orchestrate` for simple tasks

**Low success rate**:
- Tasks too complex for single workflow
- Missing file context
- Insufficient agent capabilities

## Optimization Checklist

### Before Starting
- [ ] Is task clearly defined?
- [ ] Can it use `/quick` or `/analyze` instead of `/orchestrate`?
- [ ] Are there existing files to reference?

### During Execution
- [ ] Are agents staying within their roles?
- [ ] Is output concise (file:line format)?
- [ ] Are there unnecessary tool calls?

### After Completion
- [ ] Review token usage with `opencode stats`
- [ ] Note any verbose agent responses
- [ ] Identify opportunities to use simpler commands

## Advanced Optimizations

### 1. Custom Agent Variants

Create specialized versions for specific projects:

```bash
# Create laser-focused agents
cp agents/code-reader.md agents/code-reader-auth.md
```

Edit to add domain-specific instructions:
```yaml
---
description: Auth module specialist
# ... restrict to auth-related files only
---

Focus only on: auth/, middleware/auth.ts, types/user.ts
```

### 2. Workflow Presets

Create common workflow shortcuts:

```typescript
// In skills/orchestration.ts
if (command === "add-endpoint") {
  // Preset workflow for API endpoints
  output.parts = [{
    type: "agent",
    agent: "code-reader",
    prompt: `Find API route files and handler pattern for: ${args}`
  }];
}
```

### 3. Context Compression

Update agent prompts to enforce compression:

```markdown
Rules:
- Max 50 words per response
- Use abbreviations: M=Modified, A=Added, R=Removed
- No explanations unless critical
```

### 4. Parallel Execution

For independent tasks, use workflow helpers:

```typescript
if (command === "multi-implement") {
  const tasks = args.split(";");
  output.parts = tasks.map(task => ({
    type: "agent",
    agent: "coder",
    prompt: `Quick implementation: ${task.trim()}`
  }));
}
```

## Troubleshooting Performance

### Agent Taking Too Long

**Cause**: Complex task, too many files
**Fix**:
```
/plan <task>  # Break down first
# Then implement piece by piece
```

### Running Out of Context

**Cause**: Too many round trips in single session
**Fix**:
```bash
# Start fresh session
opencode  # New session
/implement next-subtask
```

### Repetitive Responses

**Cause**: Agent not understanding constraints
**Fix**: Update agent prompt to emphasize brevity

```yaml
# In agents/coder.md
Keep response under 3 sentences
Format: M=file:line, A=file:line
```

## Benchmarks

### Target Performance

| Metric | Target | Current |
|--------|--------|---------|
| Tokens/task | <10k | TBD |
| Tasks/session | 5-10 | TBD |
| Response time | <30s | TBD |
| Success rate | >90% | TBD |

### Measurement

Track over time:
```bash
# After each session
opencode stats > stats-$(date +%Y%m%d).txt
```

Compare weekly to identify trends.

## Summary

**Key principles**:
1. Use simplest command that works
2. Keep all responses under 5 lines
3. Reference files, don't show code
4. Split large tasks into batches
5. Monitor token usage regularly

**Expected gains**:
- 50%+ token reduction vs single agent
- 4x effective context capacity
- Faster task completion
- Higher success rate on complex tasks

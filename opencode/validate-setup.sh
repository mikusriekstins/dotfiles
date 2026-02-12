#!/bin/bash

# Validation script for OpenCode multi-agent setup
# Run this to verify all components are correctly configured

echo "🔍 OpenCode Multi-Agent Setup Validation"
echo "=========================================="
echo ""

# Check if opencode is installed
if ! command -v opencode &> /dev/null; then
    echo "❌ opencode not found in PATH"
    exit 1
fi
echo "✅ opencode CLI found"

# Check config directory
if [ ! -d "$(pwd)" ] || [ ! -f "opencode.json" ]; then
    echo "❌ Not in opencode config directory"
    echo "   Run this from: ~/.config/opencode"
    exit 1
fi
echo "✅ In config directory: $(pwd)"

# Validate opencode.json
if [ ! -f "opencode.json" ]; then
    echo "❌ opencode.json not found"
    exit 1
fi
echo "✅ opencode.json exists"

# Check plugins
if ! grep -q '"plugin"' opencode.json; then
    echo "⚠️  No plugins registered in opencode.json"
else
    if grep -q "orchestration.ts" opencode.json; then
        echo "✅ orchestration.ts plugin registered"
    else
        echo "⚠️  orchestration.ts not registered in opencode.json"
    fi

    if grep -q "workflow-helpers.ts" opencode.json; then
        echo "✅ workflow-helpers.ts plugin registered"
    else
        echo "⚠️  workflow-helpers.ts not registered in opencode.json"
    fi
fi

# Check agents directory
if [ ! -d "agents" ]; then
    echo "❌ agents directory not found"
    exit 1
fi
echo "✅ agents directory exists"

# Check required agents
REQUIRED_AGENTS=("manager.md" "code-reader.md" "coder.md" "reviewer.md" "tester.md")
for agent in "${REQUIRED_AGENTS[@]}"; do
    if [ ! -f "agents/$agent" ]; then
        echo "❌ agents/$agent not found"
        exit 1
    fi
    echo "✅ agents/$agent exists"
done

# Check skills directory
if [ ! -d "skills" ]; then
    echo "❌ skills directory not found"
    exit 1
fi
echo "✅ skills directory exists"

# Check skill files
REQUIRED_SKILLS=("orchestration.ts" "workflow-helpers.ts")
for skill in "${REQUIRED_SKILLS[@]}"; do
    if [ ! -f "skills/$skill" ]; then
        echo "❌ skills/$skill not found"
        exit 1
    fi
    echo "✅ skills/$skill exists"
done

# Check documentation
DOCS=("AGENTS_README.md" "WORKFLOW_CHEATSHEET.md" "OPTIMIZATION_GUIDE.md")
for doc in "${DOCS[@]}"; do
    if [ ! -f "$doc" ]; then
        echo "⚠️  $doc not found (optional)"
    else
        echo "✅ $doc exists"
    fi
done

echo ""
echo "=========================================="
echo "Agent Registration Check"
echo "=========================================="

# Check if agents are registered with opencode
echo "Checking agent registration..."
AGENT_LIST=$(opencode agent list 2>&1)

for agent in "manager" "code-reader" "coder" "reviewer" "tester"; do
    if echo "$AGENT_LIST" | grep -q "^$agent ("; then
        echo "✅ $agent agent registered"
    else
        echo "⚠️  $agent agent not found in list (may need opencode restart)"
    fi
done

echo ""
echo "=========================================="
echo "Summary"
echo "=========================================="
echo ""
echo "✨ Setup validation complete!"
echo ""
echo "📚 Next steps:"
echo "   1. Read AGENTS_README.md for overview"
echo "   2. Check WORKFLOW_CHEATSHEET.md for commands"
echo "   3. Review OPTIMIZATION_GUIDE.md for token tips"
echo ""
echo "🚀 Test the setup:"
echo "   opencode"
echo "   > /workflow-status"
echo ""
echo "📖 Available commands:"
echo "   /orchestrate <task>  - Full workflow (manager coordinates all)"
echo "   /analyze <query>     - Find files (code-reader)"
echo "   /develop <task>      - Make changes (coder)"
echo "   /review <context>    - Review code (reviewer)"
echo "   /test <context>      - Run tests (tester)"
echo "   /quick <task>        - Fast path (reader + coder)"
echo "   /plan <task>         - Planning (manager)"
echo ""

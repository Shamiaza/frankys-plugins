---
description: "Continue implementing features from the feature list"
argument-hint: "[--max-iterations N] [--feature <id>]"
---

# /autonomous-coding:continue

[[ Ultrathink ]]

This command runs the **Coding Agent** to continue implementing features from the feature list. It handles regression checks, feature implementation, browser testing, and progress tracking.

## Workflow

[[ Ultrathink ]]

### Step 1: Verify Project State

Check that this is an initialized autonomous-coding project:

```bash
if [ ! -f "feature_list.json" ]; then
    echo "Error: No feature_list.json found."
    echo "This doesn't appear to be an autonomous-coding project."
    echo ""
    echo "To initialize a new project:"
    echo "  /autonomous-coding:init <app-spec-file>"
    exit 1
fi

if [ ! -f "claude-progress.txt" ]; then
    echo "Warning: No claude-progress.txt found. Creating one."
    echo "# Autonomous Coding Progress\n" > claude-progress.txt
fi
```

### Step 2: Show Current Status

Display progress before starting:

```bash
./scripts/check-progress.sh

echo ""
echo "Last session notes:"
tail -30 claude-progress.txt
echo ""
```

### Step 3: Parse Arguments

```bash
MAX_ITERATIONS=""
SPECIFIC_FEATURE=""

# Parse --max-iterations
if echo "$ARGUMENTS" | grep -q "\-\-max-iterations"; then
    MAX_ITERATIONS=$(echo "$ARGUMENTS" | grep -o '\-\-max-iterations [0-9]*' | awk '{print $2}')
fi

# Parse --feature
if echo "$ARGUMENTS" | grep -q "\-\-feature"; then
    SPECIFIC_FEATURE=$(echo "$ARGUMENTS" | grep -o '\-\-feature [^ ]*' | awk '{print $2}')
fi
```

### Step 4: Update Session State

Increment session counter and record start:

```bash
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
SESSION_NUM=$(($(grep -c "### Session" claude-progress.txt 2>/dev/null || echo 0) + 1))

# Update local state
cat > .claude/autonomous-coding.local.md << EOF
# Autonomous Coding State

## Current Session
- session: $SESSION_NUM
- started: $TIMESTAMP
- max_iterations: ${MAX_ITERATIONS:-unlimited}
- specific_feature: ${SPECIFIC_FEATURE:-auto}

## Status
- active: true
EOF
```

### Step 5: Launch Coding Agent

Use the Task tool to launch the Coding Agent:

```
Launch the coding agent with:
- Task: Continue implementing features from feature_list.json
- Context: Read claude-progress.txt for previous session notes
- Max iterations: $MAX_ITERATIONS (if specified)
- Specific feature: $SPECIFIC_FEATURE (if specified)
- Agent: Use agents/coding/AGENT.md instructions
- Browser testing: Use claude --chrome or Chrome DevTools MCP
```

The coding agent will:
1. Orient by reading progress and feature list
2. Run regression checks on passing features
3. Select and implement next feature(s)
4. Verify via browser automation
5. Mark verified features as passing
6. Commit changes to git
7. Update progress notes

### Step 6: Post-Session Summary

After the agent completes:

```bash
echo ""
echo "================================"
echo "  Session Complete"
echo "================================"
./scripts/check-progress.sh

# Check if more work needed
REMAINING=$(jq '[.features[] | select(.passes == false)] | length' feature_list.json 2>/dev/null || echo "?")

if [ "$REMAINING" = "0" ]; then
    echo ""
    echo "All features are passing! Project complete."
else
    echo ""
    echo "Remaining: $REMAINING features"
    echo ""
    echo "To continue: /autonomous-coding:continue"
fi
```

## Example Usage

```bash
# Continue with default behavior
/autonomous-coding:continue

# Limit to 3 features per session
/autonomous-coding:continue --max-iterations 3

# Work on a specific feature
/autonomous-coding:continue --feature F042

# Combine options
/autonomous-coding:continue --max-iterations 5 --feature F042
```

## Browser Testing

The coding agent uses browser automation for verification:

### Preferred: Claude in Chrome
```bash
# Ensure you're running with chrome flag
claude --chrome
```

### Fallback: Chrome DevTools MCP
```bash
# Add if not already configured
claude mcp add chrome-devtools npx chrome-devtools-mcp@latest
```

## Session Behavior

- **Default**: Implement features until context limit approaches
- **With --max-iterations**: Stop after N features
- **With --feature**: Focus on specific feature first
- **On error**: Document issue, attempt recovery, continue if possible
- **On context limit**: Save state, update progress, exit cleanly

## Interruption

If you need to stop mid-session:
1. The agent will save current state
2. Progress file will be updated
3. Git will have latest commits
4. Re-run `/autonomous-coding:continue` to resume

## Notes

- Each session may take 15-60 minutes depending on feature complexity
- The agent prioritizes quality over quantity
- Regression checks prevent breaking existing features
- All work is committed to git for recovery

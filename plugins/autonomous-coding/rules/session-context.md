# Autonomous Coding Session Context

This rule provides context for autonomous coding projects when starting a new Claude Code session.

## Detection

When you start working in a directory, check for autonomous coding projects:

```bash
# Check for feature_list.json
if [ -f "feature_list.json" ]; then
    echo "Autonomous coding project detected"
fi
```

## Auto-Load Behavior

If `feature_list.json` exists in the current directory:

### 1. Read Progress Context

```bash
# Show current progress
./scripts/check-progress.sh 2>/dev/null || {
    PASSING=$(jq '.metadata.passing_features // 0' feature_list.json)
    TOTAL=$(jq '.metadata.total_features // 0' feature_list.json)
    echo "Progress: $PASSING/$TOTAL features"
}
```

### 2. Show Last Session Notes

```bash
# Display last session summary
echo "Last session:"
grep -A 10 "### Session" claude-progress.txt | tail -15
```

### 3. Offer Resume Command

```
📊 Autonomous Coding Project Detected
=====================================

Progress: X/200 features passing (Y%)

Last session: [timestamp from progress]
Status: [notes from last session]

Commands:
  /autonomous-coding:continue    Resume implementation
  /autonomous-coding:status      Show detailed progress
  /autonomous-coding:status -v   Show next features
```

## Key Files Reference

| File | Purpose |
|------|---------|
| `feature_list.json` | Source of truth - 200+ features with pass/fail status |
| `claude-progress.txt` | Human-readable session notes and context |
| `init.sh` | Environment setup script (run once) |
| `app_spec.txt` | Original application specification |
| `.claude/autonomous-coding.local.md` | Local session state |

## Workflow Reminder

When working on an autonomous coding project:

1. **Start**: Read previous progress notes
2. **Verify**: Check that passing features still work
3. **Implement**: Work on next failing feature
4. **Test**: Use browser automation to verify
5. **Mark**: Update feature_list.json only after verification
6. **Commit**: Save progress to git
7. **Document**: Update claude-progress.txt

## Critical Rules

- **NEVER** remove or edit feature descriptions
- **ONLY** change `passes: false` to `passes: true`
- **ALWAYS** verify via browser before marking as passing
- **ALWAYS** commit before session ends
- **ALWAYS** update progress notes

## Browser Testing

Prefer `claude --chrome` for browser automation.
Fallback to Chrome DevTools MCP if not available.

Test steps must:
- Navigate to actual pages
- Perform real user interactions
- Take screenshots as evidence
- Check console for errors

## Session End Checklist

Before ending a session:
- [ ] All implemented features are verified
- [ ] feature_list.json is updated
- [ ] Changes are committed to git
- [ ] claude-progress.txt has session notes
- [ ] Application runs without errors

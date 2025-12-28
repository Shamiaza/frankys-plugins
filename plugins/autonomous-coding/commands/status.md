---
description: "Show current progress of autonomous coding project"
argument-hint: "[--verbose]"
---

# /autonomous-coding:status

Displays progress, recent activity, and next steps for the current autonomous coding project.

## Workflow

### Step 1: Verify Project

```bash
if [ ! -f "feature_list.json" ]; then
    echo "No autonomous-coding project found in current directory."
    echo ""
    echo "To initialize: /autonomous-coding:init <app-spec-file>"
    exit 0
fi
```

### Step 2: Show Progress

Run the progress script:

```bash
./scripts/check-progress.sh
```

### Step 3: Show Recent Activity

```bash
echo ""
echo "Recent Git Activity:"
echo "--------------------"
git log --oneline -10 2>/dev/null || echo "No git history"

echo ""
echo "Last Session Notes:"
echo "-------------------"
tail -40 claude-progress.txt 2>/dev/null || echo "No progress notes"
```

### Step 4: Verbose Mode (if requested)

If `--verbose` is passed:

```bash
if echo "$ARGUMENTS" | grep -q "\-\-verbose"; then
    echo ""
    echo "Feature Breakdown:"
    echo "------------------"

    # Show by category
    echo "By Category:"
    jq -r '.features | group_by(.category) | .[] |
        "  " + .[0].category + ": " +
        ([.[] | select(.passes == true)] | length | tostring) + "/" +
        (length | tostring)' feature_list.json 2>/dev/null

    echo ""
    echo "Next 5 Features to Implement:"
    jq -r '[.features[] | select(.passes == false)] | .[0:5] | .[] |
        "  " + .id + ": " + .description' feature_list.json 2>/dev/null

    echo ""
    echo "Recently Completed:"
    jq -r '[.features[] | select(.passes == true)] | .[-5:] | .[] |
        "  " + .id + ": " + .description' feature_list.json 2>/dev/null
fi
```

### Step 5: Show Next Steps

```bash
PASSING=$(jq '[.features[] | select(.passes == true)] | length' feature_list.json 2>/dev/null || echo 0)
TOTAL=$(jq '.features | length' feature_list.json 2>/dev/null || echo 0)

echo ""
echo "Next Steps:"
echo "-----------"

if [ "$PASSING" = "$TOTAL" ] && [ "$TOTAL" != "0" ]; then
    echo "  All features complete! Project is done."
    echo "  Run the application: ./init.sh"
else
    echo "  Continue coding: /autonomous-coding:continue"
    echo "  View details:    /autonomous-coding:status --verbose"
fi
```

## Example Output

```
================================
  Autonomous Coding Progress
================================

  Passing:   42 / 200 (21.0%)
  Remaining: 158 features

  [#######-----------------------]

  By Category:
    functional: 30/120
    style: 8/30
    accessibility: 2/20
    performance: 2/20
    security: 0/10

================================

Recent Git Activity:
--------------------
a1b2c3d feat(F042): implement user login
d4e5f6g feat(F041): add login form UI
g7h8i9j feat(F040): create auth API endpoint

Last Session Notes:
-------------------
### Session 5: 2024-01-15T14:30:00Z
- Features attempted: F042
- Features passing: F042
- Regressions: None
- Progress: 42/200 (21%)

Notes:
- Login functionality complete
- Ready for profile feature (F043)

Next Steps:
-----------
  Continue coding: /autonomous-coding:continue
  View details:    /autonomous-coding:status --verbose
```

## Notes

- Run from project root directory
- Requires `jq` for detailed breakdowns (graceful fallback without)
- Use `--verbose` for feature-level details

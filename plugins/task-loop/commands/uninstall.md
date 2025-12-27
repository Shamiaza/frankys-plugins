---
description: Remove task-loop hooks and rules from ~/.claude/
---

# Uninstall Task Loop Hooks and Rules

```bash
#!/bin/bash
set -e

SETTINGS_FILE="${HOME}/.claude/settings.json"
RULES_DIR="${HOME}/.claude/rules"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }

if ! command -v jq &> /dev/null; then
    echo "Error: jq is required. Install with: brew install jq"
    exit 1
fi

# Remove hooks
if [ -f "$SETTINGS_FILE" ] && jq -e '.hooks.PostToolUse' "$SETTINGS_FILE" > /dev/null 2>&1; then
    # Remove Read hook
    jq 'del(.hooks.PostToolUse[] | select(.matcher == "Read" and (.hooks[].command | contains("Active task"))))' "$SETTINGS_FILE" > "${SETTINGS_FILE}.tmp"
    mv "${SETTINGS_FILE}.tmp" "$SETTINGS_FILE"
    info "Removed Read hook"

    # Remove Task hook
    jq 'del(.hooks.PostToolUse[] | select(.matcher == "Task" and (.hooks[].command | contains("Update progress"))))' "$SETTINGS_FILE" > "${SETTINGS_FILE}.tmp"
    mv "${SETTINGS_FILE}.tmp" "$SETTINGS_FILE"
    info "Removed Task hook"
else
    warn "No hooks found to remove"
fi

# Remove rule
if [ -f "${RULES_DIR}/task-loop-session-context.md" ]; then
    rm "${RULES_DIR}/task-loop-session-context.md"
    info "Removed rule: task-loop-session-context.md"
fi

echo ""
info "Task-loop uninstallation complete!"
echo "Restart Claude Code for changes to take effect."
```

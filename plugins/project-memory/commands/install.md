---
description: Install project-memory hooks to ~/.claude/settings.json (memory sync reminders)
---

# Install Project Memory Hooks

This will install **non-blocking** hooks that remind you to sync memory after file edits.

## Installation

```bash
#!/bin/bash
set -e

SETTINGS_FILE="${HOME}/.claude/settings.json"
BACKUP_FILE="${HOME}/.claude/settings.json.bak.$(date +%Y%m%d_%H%M%S)"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }

if ! command -v jq &> /dev/null; then
    echo "Error: jq is required. Install with: brew install jq"
    exit 1
fi

if [ -f "$SETTINGS_FILE" ]; then
    cp "$SETTINGS_FILE" "$BACKUP_FILE"
    info "Backed up settings to: $BACKUP_FILE"
fi

HOOK_ENTRY='{
  "matcher": "Edit|Write",
  "hooks": [
    {
      "type": "command",
      "command": "echo '\''\\n💡 Memory tip: If you changed architecture/patterns, consider /project-memory:sync'\''",
      "timeout": 3
    }
  ]
}'

if [ -f "$SETTINGS_FILE" ]; then
    if jq -e '.hooks.PostToolUse' "$SETTINGS_FILE" > /dev/null 2>&1; then
        if jq -e '.hooks.PostToolUse[] | select(.hooks[].command | contains("Memory tip"))' "$SETTINGS_FILE" > /dev/null 2>&1; then
            warn "Project memory hook already installed!"
            exit 0
        fi
        jq --argjson hook "$HOOK_ENTRY" '.hooks.PostToolUse += [$hook]' "$SETTINGS_FILE" > "${SETTINGS_FILE}.tmp"
    else
        jq --argjson hook "$HOOK_ENTRY" '.hooks.PostToolUse = [$hook]' "$SETTINGS_FILE" > "${SETTINGS_FILE}.tmp"
    fi
    mv "${SETTINGS_FILE}.tmp" "$SETTINGS_FILE"
else
    echo '{"hooks":{"PostToolUse":[]}}' | jq --argjson hook "$HOOK_ENTRY" '.hooks.PostToolUse = [$hook]' > "$SETTINGS_FILE"
fi

info "Project memory hooks installed!"
echo "Restart Claude Code for changes to take effect."
echo "To uninstall: /project-memory:uninstall"
```

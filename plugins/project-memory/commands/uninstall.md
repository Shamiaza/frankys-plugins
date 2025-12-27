---
description: Remove project-memory hooks from ~/.claude/settings.json
---

# Uninstall Project Memory Hooks

```bash
#!/bin/bash
set -e

SETTINGS_FILE="${HOME}/.claude/settings.json"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }

if ! command -v jq &> /dev/null; then
    echo "Error: jq is required. Install with: brew install jq"
    exit 1
fi

if [ ! -f "$SETTINGS_FILE" ]; then
    warn "Settings file not found. Nothing to uninstall."
    exit 0
fi

if jq -e '.hooks.PostToolUse' "$SETTINGS_FILE" > /dev/null 2>&1; then
    jq 'del(.hooks.PostToolUse[] | select(.hooks[].command | contains("Memory tip")))' "$SETTINGS_FILE" > "${SETTINGS_FILE}.tmp"
    mv "${SETTINGS_FILE}.tmp" "$SETTINGS_FILE"
    info "Project memory hooks removed!"
else
    warn "No PostToolUse hooks found."
fi

echo "Restart Claude Code for changes to take effect."
```

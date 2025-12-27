---
description: Install orchestrator-mode hooks to ~/.claude/settings.json (blocks direct file edits)
---

# Install Orchestrator Mode Hooks

This will install hooks that **block direct file edits**, enforcing delegation to agents.

## Warning

This is a **blocking hook** - it will prevent Claude from making direct file edits. Only install if you want strict agent delegation.

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
  "matcher": "Edit|Write|MultiEdit|NotebookEdit",
  "hooks": [
    {
      "type": "command",
      "command": "echo '\''🚫 ORCHESTRATOR MODE: Direct file edits are blocked. Use Task tool with an agent instead.'\'' >&2 && exit 1",
      "timeout": 5
    }
  ]
}'

if [ -f "$SETTINGS_FILE" ]; then
    if jq -e '.hooks.PreToolUse' "$SETTINGS_FILE" > /dev/null 2>&1; then
        if jq -e '.hooks.PreToolUse[] | select(.matcher == "Edit|Write|MultiEdit|NotebookEdit")' "$SETTINGS_FILE" > /dev/null 2>&1; then
            warn "Orchestrator mode hook already installed!"
            exit 0
        fi
        jq --argjson hook "$HOOK_ENTRY" '.hooks.PreToolUse += [$hook]' "$SETTINGS_FILE" > "${SETTINGS_FILE}.tmp"
    else
        jq --argjson hook "$HOOK_ENTRY" '.hooks.PreToolUse = [$hook]' "$SETTINGS_FILE" > "${SETTINGS_FILE}.tmp"
    fi
    mv "${SETTINGS_FILE}.tmp" "$SETTINGS_FILE"
else
    echo '{"hooks":{"PreToolUse":[]}}' | jq --argjson hook "$HOOK_ENTRY" '.hooks.PreToolUse = [$hook]' > "$SETTINGS_FILE"
fi

info "Orchestrator mode hooks installed!"
echo "Restart Claude Code for changes to take effect."
echo "To uninstall: /orchestrator-mode:uninstall"
```

---
description: Install task-loop hooks and rules to ~/.claude/ (session context and progress reminders)
---

# Install Task Loop Hooks and Rules

This will install **non-blocking** hooks and rules for session context awareness.

## What Gets Installed

- **Read hook**: Detects active tasks
- **Task hook**: Reminds to update progress
- **Rule**: Auto-load task context on session start

## Installation

```bash
#!/bin/bash
set -e

SETTINGS_FILE="${HOME}/.claude/settings.json"
RULES_DIR="${HOME}/.claude/rules"
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

mkdir -p "$RULES_DIR"

if [ -f "$SETTINGS_FILE" ]; then
    cp "$SETTINGS_FILE" "$BACKUP_FILE"
    info "Backed up settings to: $BACKUP_FILE"
else
    echo '{"hooks":{}}' > "$SETTINGS_FILE"
fi

# Hooks
HOOK_READ='{
  "matcher": "Read",
  "hooks": [
    {
      "type": "command",
      "command": "[ -f .claude/current-task.md ] && head -1 .claude/current-task.md | grep -q '\''task_file'\'' && echo '\''\\n📋 Active task detected. Run: cat .claude/current-task.md'\'' || true",
      "timeout": 3
    }
  ]
}'

HOOK_TASK='{
  "matcher": "Task",
  "hooks": [
    {
      "type": "command",
      "command": "[ -f .claude/current-task.md ] && PROGRESS=$(grep '\''progress_file:'\'' .claude/current-task.md | sed '\''s/.*: \"\\(.*\\)\"/\\1/'\'' | tr -d '\''\"'\'') && echo \"\\n📝 Reminder: Update progress file ($PROGRESS)\" || true",
      "timeout": 3
    }
  ]
}'

# Ensure PostToolUse exists
if ! jq -e '.hooks.PostToolUse' "$SETTINGS_FILE" > /dev/null 2>&1; then
    jq '.hooks.PostToolUse = []' "$SETTINGS_FILE" > "${SETTINGS_FILE}.tmp" && mv "${SETTINGS_FILE}.tmp" "$SETTINGS_FILE"
fi

# Add Read hook
if ! jq -e '.hooks.PostToolUse[] | select(.matcher == "Read" and (.hooks[].command | contains("Active task")))' "$SETTINGS_FILE" > /dev/null 2>&1; then
    jq --argjson hook "$HOOK_READ" '.hooks.PostToolUse += [$hook]' "$SETTINGS_FILE" > "${SETTINGS_FILE}.tmp"
    mv "${SETTINGS_FILE}.tmp" "$SETTINGS_FILE"
    info "Added Read hook"
else
    warn "Read hook already exists"
fi

# Add Task hook
if ! jq -e '.hooks.PostToolUse[] | select(.matcher == "Task" and (.hooks[].command | contains("Update progress")))' "$SETTINGS_FILE" > /dev/null 2>&1; then
    jq --argjson hook "$HOOK_TASK" '.hooks.PostToolUse += [$hook]' "$SETTINGS_FILE" > "${SETTINGS_FILE}.tmp"
    mv "${SETTINGS_FILE}.tmp" "$SETTINGS_FILE"
    info "Added Task hook"
else
    warn "Task hook already exists"
fi

# Install rule
cat > "${RULES_DIR}/task-loop-session-context.md" << 'RULE_EOF'
---
description: "Auto-load current task context on session start"
---

# Session Context: Current Task

When starting a new session in a project with an active task loop:

1. Check if `.claude/current-task.md` exists
2. If it exists, read it to understand the current task context
3. Read the progress file referenced to see current status
4. Offer to resume with `/task-loop:loop` or continue manually
RULE_EOF

info "Installed rule: task-loop-session-context.md"

echo ""
info "Task-loop installation complete!"
echo "Restart Claude Code for changes to take effect."
echo "To uninstall: /task-loop:uninstall"
```

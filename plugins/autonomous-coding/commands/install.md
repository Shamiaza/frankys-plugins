# /autonomous-coding:install

Install hooks and rules for autonomous coding session continuity.

## Arguments

$ARGUMENTS = (none)

## Description

Installs PostToolUse hooks and session context rules to `~/.claude/` that help maintain awareness of active autonomous-coding projects across sessions.

## What Gets Installed

### 1. PostToolUse Hooks

Added to `~/.claude/settings.json`:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Read",
        "hooks": [{
          "type": "command",
          "command": "[ -f feature_list.json ] && echo '\n📊 Autonomous coding project detected. Run: /autonomous-coding:status' || true",
          "timeout": 3
        }]
      }
    ]
  }
}
```

### 2. Session Context Rule

Created at `~/.claude/rules/autonomous-coding-context.md`:

```markdown
# Autonomous Coding Session Context

When starting a session in a project with `feature_list.json`:
1. Read claude-progress.txt for context
2. Show current progress
3. Offer to continue with /autonomous-coding:continue
```

## Workflow

### Step 1: Backup Existing Settings

```bash
SETTINGS_FILE="$HOME/.claude/settings.json"
RULES_DIR="$HOME/.claude/rules"

# Create directories if needed
mkdir -p "$HOME/.claude"
mkdir -p "$RULES_DIR"

# Backup settings if exists
if [ -f "$SETTINGS_FILE" ]; then
    cp "$SETTINGS_FILE" "$SETTINGS_FILE.backup.$(date +%Y%m%d%H%M%S)"
    echo "Backed up existing settings.json"
fi
```

### Step 2: Install Hooks

```bash
# Read existing settings or create new
if [ -f "$SETTINGS_FILE" ]; then
    SETTINGS=$(cat "$SETTINGS_FILE")
else
    SETTINGS='{}'
fi

# Add hooks using jq
echo "$SETTINGS" | jq '
  .hooks.PostToolUse = ((.hooks.PostToolUse // []) + [
    {
      "matcher": "Read",
      "hooks": [{
        "type": "command",
        "command": "[ -f feature_list.json ] && echo \"\\n📊 Autonomous coding project. Progress: $(jq -r \x27\"\\(.metadata.passing_features // 0)/\\(.metadata.total_features // 0)\"\x27 feature_list.json 2>/dev/null || echo \"?\")\" || true",
        "timeout": 3
      }]
    }
  ] | unique_by(.matcher))
' > "$SETTINGS_FILE"

echo "Installed PostToolUse hooks"
```

### Step 3: Install Session Context Rule

```bash
cat > "$RULES_DIR/autonomous-coding-context.md" << 'EOF'
# Autonomous Coding Session Context

When starting a new session, check for autonomous coding projects:

## Detection

Look for `feature_list.json` in the current directory. If found:

1. This is an autonomous coding project
2. Read `claude-progress.txt` for previous session context
3. Run `/autonomous-coding:status` to show progress

## Auto-Resume Prompt

If `feature_list.json` exists and has incomplete features:

```
📊 Autonomous coding project detected
Progress: X/200 features (Y%)

Last session: [date from progress file]
Resume with: /autonomous-coding:continue
```

## Key Files

- `feature_list.json` - Source of truth (200+ features)
- `claude-progress.txt` - Session notes and context
- `init.sh` - Environment setup script
- `.claude/autonomous-coding.local.md` - Local state

## Commands

- `/autonomous-coding:continue` - Resume implementation
- `/autonomous-coding:status` - Show detailed progress
- `/autonomous-coding:status --verbose` - Show next features
EOF

echo "Installed session context rule"
```

### Step 4: Verify Installation

```bash
echo ""
echo "================================"
echo "  Installation Complete"
echo "================================"
echo ""
echo "Installed:"
echo "  ✓ PostToolUse hooks in ~/.claude/settings.json"
echo "  ✓ Session context rule in ~/.claude/rules/"
echo ""
echo "Effects:"
echo "  - Progress shown when reading project files"
echo "  - Session context auto-loads in autonomous projects"
echo ""
echo "To uninstall: /autonomous-coding:uninstall"
```

## Uninstallation

To remove installed hooks and rules:

```bash
# Remove hooks from settings.json
jq 'del(.hooks.PostToolUse[] | select(.matcher == "Read" and (.hooks[0].command | contains("feature_list.json"))))' \
    ~/.claude/settings.json > ~/.claude/settings.json.tmp && \
    mv ~/.claude/settings.json.tmp ~/.claude/settings.json

# Remove rule file
rm -f ~/.claude/rules/autonomous-coding-context.md

echo "Uninstalled autonomous-coding hooks and rules"
```

## Notes

- Hooks are non-blocking (timeout: 3s)
- Safe to install multiple times (deduped)
- Settings backup created before modification
- Works alongside other plugin hooks

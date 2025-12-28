#!/bin/bash
# Setup script for autonomous-coding projects
# Initializes directory structure and state files

set -e

PROJECT_DIR="${1:-.}"
APP_SPEC="${2:-app_spec.txt}"

# Ensure project directory exists
mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR"

# Check if app_spec exists
if [ ! -f "$APP_SPEC" ] && [ ! -f "../$APP_SPEC" ]; then
    echo "Error: App specification file not found: $APP_SPEC"
    echo "Please create an app_spec.txt file with your application requirements."
    exit 1
fi

# Copy app_spec to project if it's in parent directory
if [ ! -f "$APP_SPEC" ] && [ -f "../$APP_SPEC" ]; then
    cp "../$APP_SPEC" "$APP_SPEC"
fi

# Create .claude directory for local state
mkdir -p .claude

# Initialize autonomous-coding state file
cat > .claude/autonomous-coding.local.md << 'EOF'
# Autonomous Coding State

## Status
- initialized: true
- session_count: 0
- last_session: null

## Current Task
- feature_id: null
- status: pending

## Notes
Project initialized. Run `/autonomous-coding:continue` to start coding.
EOF

# Initialize progress file
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
cat > claude-progress.txt << EOF
# Autonomous Coding Progress

## Project: $(basename "$PROJECT_DIR")
## Started: $TIMESTAMP

---

## Session Log

### Session 0: Initialization
- Timestamp: $TIMESTAMP
- Action: Project setup completed
- Status: Ready for feature generation

---

## Next Steps
1. Run initializer agent to generate feature_list.json
2. Begin iterative implementation with coding agent
EOF

# Initialize git if not already a repo
if [ ! -d ".git" ]; then
    git init
    echo "node_modules/" > .gitignore
    echo ".DS_Store" >> .gitignore
    echo "*.log" >> .gitignore
    git add .gitignore
    git commit -m "chore: initialize autonomous-coding project"
fi

echo "Autonomous coding project initialized in: $PROJECT_DIR"
echo ""
echo "Files created:"
echo "  - .claude/autonomous-coding.local.md (state tracking)"
echo "  - claude-progress.txt (session notes)"
echo ""
echo "Next: Run the initializer agent to generate feature_list.json"

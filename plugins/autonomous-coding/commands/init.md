# /autonomous-coding:init

Initialize a new autonomous coding project with 200+ feature tracking.

## Arguments

$ARGUMENTS = `<app-spec-file> [--project-dir <dir>]`

## Description

This command runs the **Initializer Agent** to set up a long-running autonomous coding project. It transforms your application specification into a comprehensive feature list and project scaffold.

## Workflow

[[ Ultrathink ]]

### Step 1: Validate Input

First, validate the app specification file exists:

```bash
APP_SPEC="$ARGUMENTS"
# Extract just the file path if additional args provided
APP_SPEC=$(echo "$APP_SPEC" | awk '{print $1}')

if [ ! -f "$APP_SPEC" ]; then
    echo "Error: App specification file not found: $APP_SPEC"
    echo ""
    echo "Usage: /autonomous-coding:init <app-spec-file>"
    echo ""
    echo "Create an app_spec.txt file with your application requirements."
    echo "See: /autonomous-coding:help for template"
    exit 1
fi
```

### Step 2: Setup Project Directory

Determine and create project directory:

```bash
# Extract project dir from args or use default
PROJECT_DIR=$(echo "$ARGUMENTS" | grep -o '\-\-project-dir [^ ]*' | awk '{print $2}')
if [ -z "$PROJECT_DIR" ]; then
    # Default: use app spec name without extension
    PROJECT_DIR="./$(basename "$APP_SPEC" .txt)-project"
fi

mkdir -p "$PROJECT_DIR"
cp "$APP_SPEC" "$PROJECT_DIR/app_spec.txt"
```

### Step 3: Run Setup Script

Execute the setup script to initialize state files:

```bash
./scripts/setup-project.sh "$PROJECT_DIR" "app_spec.txt"
```

### Step 4: Launch Initializer Agent

Use the Task tool to launch the Initializer Agent with full context:

```
Launch the initializer agent with:
- Task: Read app_spec.txt and generate feature_list.json with 200+ features
- Working directory: $PROJECT_DIR
- Agent: Use agents/initializer/AGENT.md instructions
```

The initializer agent will:
1. Read the app specification thoroughly
2. Detect the tech stack
3. Generate 200+ categorized features
4. Create init.sh for environment setup
5. Scaffold initial project structure
6. Make initial git commit
7. Update claude-progress.txt

### Step 5: Verify Initialization

After the agent completes, verify outputs:

```bash
cd "$PROJECT_DIR"

# Check feature list was created
if [ ! -f "feature_list.json" ]; then
    echo "Warning: feature_list.json was not created"
    echo "The initializer agent may have encountered an issue."
    exit 1
fi

# Show summary
./scripts/check-progress.sh

echo ""
echo "Initialization complete!"
echo ""
echo "Next steps:"
echo "  1. Review feature_list.json"
echo "  2. Run: /autonomous-coding:continue"
```

## Example Usage

```bash
# Basic usage
/autonomous-coding:init app_spec.txt

# With custom project directory
/autonomous-coding:init app_spec.txt --project-dir ./my-app

# From a spec in another directory
/autonomous-coding:init ../specs/todo-app.txt
```

## What Gets Created

```
project-dir/
├── feature_list.json       # 200+ features (source of truth)
├── app_spec.txt           # Copy of specification
├── init.sh                # Environment setup script
├── claude-progress.txt    # Session notes
├── .claude/
│   └── autonomous-coding.local.md
├── .git/                  # Initialized repository
└── [scaffolded structure] # Based on tech stack
```

## Error Handling

- If app-spec file not found: Shows usage instructions
- If feature generation fails: Agent documents issue in progress
- If git init fails: Continues without version control

## Notes

- This is typically run ONCE per project
- The initializer agent may take several minutes to generate 200+ features
- Review the generated features before starting implementation
- Features are ordered by priority (implement in order for best results)

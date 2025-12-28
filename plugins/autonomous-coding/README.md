# Autonomous Coding Plugin

Long-running autonomous coding with two-agent pattern, 200+ feature tracking, and browser testing.

> Adapts [Anthropic's autonomous-coding patterns](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents) for Claude Code CLI.

## Overview

This plugin enables Claude Code to build complete applications autonomously across multiple sessions. It uses:

- **Two-Agent Pattern**: Initializer agent sets up infrastructure, coding agent implements iteratively
- **Feature List**: 200+ test cases as source of truth (JSON)
- **Browser Testing**: Chrome native or DevTools MCP for end-to-end verification
- **Session Continuity**: Hooks and rules for seamless resume between sessions

## Installation

```bash
claude plugins:add github:Shamiaza/claude-plugins
```

## Quick Start

### 1. Create App Specification

Create `app_spec.txt` with your application requirements:

```markdown
# App Specification: My Todo App

## Overview
A simple todo application with user authentication.

## Tech Stack
- Frontend: React + TypeScript
- Backend: NestJS
- Database: PostgreSQL

## Core Features
1. User registration and login
2. Create, read, update, delete todos
3. Mark todos as complete
4. Filter by status

## UI Requirements
- Responsive design
- Dark mode support
```

### 2. Initialize Project

```bash
/autonomous-coding:init app_spec.txt
```

This runs the **Initializer Agent** which:
- Generates `feature_list.json` with 200+ test cases
- Creates `init.sh` for environment setup
- Initializes git repository
- Sets up project scaffolding

### 3. Start Coding

```bash
/autonomous-coding:continue
```

This runs the **Coding Agent** iteratively which:
- Reads progress and selects next feature
- Implements the feature
- Tests via browser automation
- Marks as passing after verification
- Commits and updates progress

### 4. Check Progress

```bash
/autonomous-coding:status
```

Shows current progress, passing/failing features, and recent activity.

## Commands

| Command | Description |
|---------|-------------|
| `/autonomous-coding:init <app-spec>` | Initialize new project with feature list |
| `/autonomous-coding:continue [--max-iterations N]` | Continue coding session |
| `/autonomous-coding:status` | Show current progress |
| `/autonomous-coding:install` | Install hooks for session reminders |

## Files Generated

```
my-project/
├── feature_list.json       # Source of truth (200+ tests)
├── app_spec.txt           # Original specification
├── init.sh                # Environment setup script
├── claude-progress.txt    # Session notes
├── .claude/
│   └── autonomous-coding.local.md  # State tracking
└── [application files]    # Generated code
```

## Feature List Schema

```json
{
  "metadata": {
    "app_name": "My Todo App",
    "created_at": "2024-01-15T10:00:00Z",
    "total_features": 200,
    "passing_features": 0
  },
  "features": [
    {
      "id": "F001",
      "category": "functional",
      "description": "User can register with email and password",
      "steps": [
        "Navigate to /register",
        "Enter valid email",
        "Enter password (min 8 chars)",
        "Click submit button",
        "Verify redirect to dashboard"
      ],
      "passes": false,
      "verified_at": null
    }
  ]
}
```

## Browser Testing

The plugin supports two browser testing options:

### Option 1: Claude in Chrome (Recommended)
```bash
claude --chrome
```
Requires Claude Code 2.0.73+ and Chrome extension 1.0.36+.

### Option 2: Chrome DevTools MCP
```bash
claude mcp add chrome-devtools npx chrome-devtools-mcp@latest
```
More powerful debugging capabilities.

## Critical Rules

1. **Feature list is immutable**: Only `passes` field can change (false → true)
2. **Never remove features**: Features can only be marked as passing
3. **Always verify**: Use browser automation, not curl-only or JS injection
4. **Commit frequently**: Each session ends with git commit
5. **Update progress**: Always write to claude-progress.txt

## Session Continuity

After installing hooks (`/autonomous-coding:install`), Claude Code will:
- Detect active projects on session start
- Show progress summary
- Offer to resume with `/autonomous-coding:continue`

## Language Agnostic

The plugin works with any tech stack:
- Web: React, Vue, Angular, Svelte
- Mobile: Flutter, React Native
- Backend: NestJS, Express, Django, Rails
- Others: Rust, Go, etc.

The initializer agent adapts `init.sh` based on the tech stack in your app_spec.txt.

## References

- [Effective Harnesses for Long-Running Agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents)
- [Autonomous Coding Demo (API version)](https://github.com/anthropics/claude-quickstarts/tree/main/autonomous-coding)
- [Claude in Chrome Beta](https://code.claude.com/docs/en/chrome)
- [Chrome DevTools MCP](https://github.com/ChromeDevTools/chrome-devtools-mcp)

## License

MIT

# Architecture

## Overview

Claude Plugins is a collection of specialized plugins for Claude Code that enhance development workflows across different frameworks and technologies.

## Design Patterns

### Plugin Pattern
Each plugin is self-contained with its own:
- Agents (specialized AI helpers)
- Commands (slash commands for user invocation)
- Hooks (event-driven automation)

### Agent Specialization
Plugins provide specialized agents for specific domains:
- **Framework-specific agents**: React, Flutter, NestJS
- **Cross-cutting agents**: Context management, documentation, memory

## Module Structure

```
plugins/
├── react-dev/           # React development toolkit
├── flutter-dev/         # Flutter development toolkit
├── nestjs-dev/          # NestJS backend toolkit
├── context-management/  # Context and knowledge management
├── orchestrator-mode/   # Orchestration pattern enforcement
├── project-memory/      # Project memory management
└── rule-creator/        # Rule file creation
```

## Data Flow

1. User invokes command or agent
2. Plugin processes request with specialized context
3. Agent performs task using appropriate tools
4. Results returned to user's conversation

## State Management

Plugins are stateless - each invocation is independent. State persistence is handled through:
- CLAUDE.md files for project knowledge
- .claude/memory/ for session logs
- .claude/rules/ for persistent rules

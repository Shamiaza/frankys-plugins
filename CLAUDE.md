# Claude Plugins Repository

A collection of Claude Code plugins for modern web and mobile development.

## Quick Reference

### Available Plugins

| Plugin | Purpose |
|--------|---------|
| react-dev | React development toolkit with TypeScript focus |
| flutter-dev | Flutter development with Clean Architecture |
| nestjs-dev | NestJS backend development |
| context-management | Context and knowledge management |
| orchestrator-mode | Orchestration pattern enforcement (has hooks) |
| project-memory | Project memory structure management (has hooks) |
| rule-creator | Claude rules file creation |
| task-loop | Long-running task execution (has hooks + rules) |

### Key Commands

- `/react-dev:execute-task` - Work on React tasks
- `/flutter-dev:execute-task` - Work on Flutter tasks
- `/nestjs-dev:execute-task` - Work on NestJS tasks
- `/context-management:gather` - Gather context for tasks
- `/project-memory:init` - Initialize memory structure
- `/task-loop:loop` - Run long-running task loop with agent orchestration

### Install Hooks/Rules

Plugins with hooks/rules have install commands to add them to `~/.claude/`:

- `/orchestrator-mode:install` - Install blocking hooks (prevents direct edits)
- `/project-memory:install` - Install memory sync reminders
- `/task-loop:install` - Install task context hooks and rules

## Detailed Documentation

See `.claude/rules/` for detailed documentation:
- `architecture.md` - System architecture and design patterns
- `conventions.md` - Naming conventions and code style
- `dependencies.md` - Plugin requirements and integrations
- `workflows.md` - Development and deployment workflows

## Session Logs

Session notes are stored in `.claude/memory/sessions/`

## Installation

```bash
claude plugins:add github:Shamiaza/claude-plugins
```

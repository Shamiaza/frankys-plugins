# Dependencies

## Core Dependencies

This is a Claude Code plugins repository with no runtime dependencies.

| Component | Purpose | Notes |
|-----------|---------|-------|
| Claude Code | Plugin host | Required for plugin execution |
| Git | Version control | For installation from GitHub |

## Plugin Requirements

Each plugin may have specific context requirements:

### react-dev
- Designed for React/TypeScript projects
- Works best with functional components

### flutter-dev
- Designed for Flutter/Dart projects
- Focus on Clean Architecture patterns

### nestjs-dev
- Designed for NestJS projects
- TypeScript backend focus

### context-management
- Framework-agnostic
- Works with any codebase

### orchestrator-mode
- Framework-agnostic
- Passive hook-based plugin

### project-memory
- Framework-agnostic
- Manages .claude/ memory structure

### rule-creator
- Framework-agnostic
- Creates .claude/rules/ files

## Integration Notes

- Plugins are installed via `claude plugins:add github:Shamiaza/claude-plugins`
- Multiple plugins can be active simultaneously
- Plugins share the Claude Code tool ecosystem

# Orchestrator Mode Plugin

Enforces the orchestrator pattern where the main Claude context delegates file operations to specialized agents instead of editing files directly.

## Why Use This?

When Claude operates as an orchestrator:
- Main context stays focused on high-level coordination
- File edits are delegated to specialized agents (react-senior-dev, nestjs-backend-architect, etc.)
- Context window remains clean and uncluttered
- Better separation of concerns

## How It Works

This plugin hooks into `PreToolUse` events for:
- `Edit` tool
- `Write` tool
- `MultiEdit` tool

When triggered, it displays a reminder to use the Task tool with an agent instead.

## For Agents

If you ARE an agent (spawned via Task tool), you can safely proceed with file edits - the warning is meant for the main orchestrating context only.

## Recommended Agents for File Edits

- `general-purpose` - Default for most file edits
- `react-senior-dev` - React/TypeScript components
- `nestjs-backend-architect` - NestJS backend code
- `flutter-senior-dev` - Flutter/Dart code
- `code-refactor-specialist` - Refactoring tasks

## Example Usage

Instead of editing directly:
```
# Don't do this in main context
Edit tool -> file.ts
```

Delegate to an agent:
```
Task tool:
  subagent_type: "general-purpose"
  description: "Edit config file"
  prompt: "Edit /path/to/file.ts and add X"
```

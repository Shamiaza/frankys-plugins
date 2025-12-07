# Orchestrator Mode Plugin

**Blocks** direct file edits in the main Claude context, enforcing the orchestrator pattern where all file operations are delegated to specialized agents.

## Why Use This?

When Claude operates as an orchestrator:
- Main context stays focused on high-level coordination
- File edits are delegated to specialized agents (react-senior-dev, nestjs-backend-architect, etc.)
- Context window remains clean and uncluttered
- Better separation of concerns

## How It Works

This plugin hooks into `PreToolUse` events and **blocks** these tools:
- `Edit` - blocked with exit code 1
- `Write` - blocked with exit code 1
- `MultiEdit` - blocked with exit code 1
- `NotebookEdit` - blocked with exit code 1

When triggered, the operation is stopped and you'll see:
```
🚫 ORCHESTRATOR MODE: Direct edits are blocked. Use Task tool with an agent instead.
```

## Important: Agents Are Not Blocked

Agents spawned via the Task tool run in their own subprocess context and are **not affected** by this hook. They can edit files normally.

## Recommended Agents for File Edits

- `general-purpose` - Default for most file edits
- `react-senior-dev` - React/TypeScript components
- `nestjs-backend-architect` - NestJS backend code
- `flutter-senior-dev` - Flutter/Dart code
- `code-refactor-specialist` - Refactoring tasks

## Example Usage

Instead of editing directly (blocked):
```
Edit tool -> file.ts  ❌ BLOCKED
```

Delegate to an agent (works):
```
Task tool:
  subagent_type: "general-purpose"
  description: "Edit config file"
  prompt: "Edit /path/to/file.ts and add X"  ✅ WORKS
```

## Disabling Temporarily

If you need to disable this plugin temporarily:
```bash
claude plugins:disable orchestrator-mode
```

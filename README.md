# Claude Plugins by Shamiaza

A collection of Claude Code plugins for modern web and mobile development.

## Available Plugins

### react-dev
React development toolkit with specialized agents for:
- Component development with TypeScript and functional patterns
- Documentation generation
- Architectural decisions and code review

**Agents**: react-senior-dev, react-docs-writer, react-architect
**Commands**: /react-dev:execute-task, /react-dev:complete-workflow, /react-dev:generate-docs

### flutter-dev
Flutter development toolkit with Clean Architecture focus:
- Multi-tenant application development
- State management with Bloc/Provider/Riverpod
- Clean Architecture patterns (Domain, Data, Presentation)

**Agents**: flutter-senior-dev
**Commands**: /flutter-dev:execute-task, /flutter-dev:complete-workflow

### nestjs-dev
NestJS backend development toolkit:
- REST API development with proper DTOs and validation
- Clean architecture and SOLID principles
- Enterprise-grade patterns

**Agents**: nestjs-backend-architect
**Commands**: /nestjs-dev:execute-task, /nestjs-dev:complete-workflow

## Installation

```bash
claude plugins:add github:Shamiaza/claude-plugins
```

## Usage

After installation, you can use the agents via the Task tool or the slash commands directly:

```
/react-dev:execute-task path/to/task.md
/flutter-dev:complete-workflow path/to/task.md
/nestjs-dev:execute-task path/to/task.md
```

## License

MIT

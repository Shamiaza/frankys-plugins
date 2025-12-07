---
description: Work on a task in a NestJS project with the backend architect agent
---
ultrathink

## NestJS Task Execution

Execute a NestJS development task using the specialized backend architect agent.

### Input
Task file path: $ARGUMENTS

### Instructions

1. **Read the task file** at the provided path
2. **Gather context** about relevant files:
   - Related modules, services, controllers
   - Existing DTOs and validation patterns
   - Configuration patterns used in the project
3. **Spawn nestjs-backend-architect agent** with:
   - The complete task requirements
   - Context about existing project patterns
   - Instructions to implement following NestJS best practices:
     - Clean architecture with proper layer separation
     - DTOs with class-validator decorators
     - Thin controllers delegating to services
     - Dependency injection using abstractions
     - Proper error handling with exception filters
4. **After implementation**, run:
   - `yarn build` to verify TypeScript compiles
   - `yarn test` to verify tests pass
5. **Report completion** with summary of:
   - Files created/modified
   - Key architectural decisions made
   - Any pending items or considerations

### When to Use This vs Complete Workflow

Use **execute-task** when:
- The task is well-defined and scoped
- Quick implementation is needed
- The task doesn't require extensive review cycles

Use **complete-workflow** when:
- The task is complex or spans multiple modules
- Rigorous code review is required
- The task involves architectural decisions
- You need full documentation and memory updates

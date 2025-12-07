---
description: Complete NestJS development workflow with iterative development, review, testing, and refactoring
---
ultrathink

## NestJS Full Workflow

You are orchestrating a complete NestJS backend development workflow. Follow these phases STRICTLY and IN ORDER.

### Input
Read this task file : $ARGUMENTS

### Phase 1: Task Initialization
1. Read the task file at the provided path
2. Understand the full scope of work required
3. If task file has a "## Progress" section, understand where the previous agent left off
4. Read relevant CLAUDE.md files to understand project conventions

### Phase 2: Context Gathering
1. Spawn `context-gatherer` agent with:
   - The task file path
   - Instructions to analyze relevant NestJS modules, services, controllers, and DTOs
   - Instructions to identify existing patterns and conventions in the codebase
2. Update the task file with the context manifest if one doesn't exist

### Phase 3: Development Loop
Execute this loop until the task is TRULY complete:

1. **Spawn nestjs-backend-architect agent** with:
   - The full task content
   - Any progress notes from previous iterations
   - Context about existing project patterns (path aliases, config patterns, gRPC services if applicable)
   - Instruction to work on the task and report completion status

2. **After agent completes**, evaluate the result:
   - If task is FULLY complete -> Move to Phase 4
   - If agent ran out of context or task is incomplete:
     a. Spawn `doc-updater` agent to update the task file with:
        - What was completed
        - What remains to be done
        - Current state of implementation
        - Next steps for continuation
     b. Spawn ANOTHER `nestjs-backend-architect` agent with the updated task file
     c. Repeat until truly done

**Note**: Don't assume a task is done. Verify by checking:
- All requirements from the task file are implemented
- All DTOs have proper class-validator decorators
- Services depend on abstractions, not concrete implementations
- Controllers are thin and delegate to services
- Modules properly export/import required providers
- TypeScript compiles without errors (`yarn build`)

### Phase 4: Testing Verification
1. Run the test suite: `yarn test`
2. If tests fail:
   - Analyze failure messages
   - Spawn `nestjs-backend-architect` agent to fix failing tests
   - Repeat until all tests pass
3. Check test coverage for new code:
   - Run `yarn test:cov`
   - Ensure new code has reasonable coverage (aim for >80%)

### Phase 5: Code Review
1. Spawn `code-reviewer` agent with instructions to:
   - Review ALL changes made during development
   - Use `git diff` to see modified files
   - Focus on NestJS-specific concerns:
     - Proper dependency injection patterns
     - DTO validation completeness
     - Error handling with exception filters
     - Async/await usage correctness
     - No circular dependencies
   - Identify: code smells, duplication, security issues, performance problems
   - Document ALL issues found with severity and file locations

2. Spawn `doc-updater` agent to update the task file with:
   - Section "## Code Review Findings"
   - All issues organized by severity (Critical, Warning, Suggestion)
   - Specific file paths and line numbers

### Phase 6: Refactoring
1. Spawn `code-refactor-specialist` agent with:
   - The code review findings
   - Instructions to fix ALL identified issues
   - Focus on:
     - SOLID principles compliance
     - Clean architecture patterns
     - Functional programming where applicable
     - NestJS best practices

2. If any issues remain after refactoring:
   - Repeat code review with `code-reviewer`
   - Continue refactoring until clean

3. Re-run tests after refactoring:
   - `yarn test` must pass
   - No regressions allowed

### Phase 7: Build Verification
1. Run `yarn build` to ensure TypeScript compiles
2. Run `yarn checkCircular` to verify no circular dependencies
3. If any issues found:
   - Fix immediately
   - Return to Phase 5 if significant changes were needed

### Phase 8: Completion
1. Spawn `doc-updater` agent to update the task file:
   - File path: [original task file path]
   - Update type: merge
   - Add section "## Status: COMPLETED"
   - Add completion timestamp
   - Summarize all work done
   - List all files created/modified
   - Include test coverage summary

### Phase 9: Memory Update
1. Spawn `memory-updater` agent with instructions to:
   - Review the entire workflow that was completed
   - Identify any patterns, conventions, or gotchas discovered
   - Update appropriate CLAUDE.md files with new learnings
   - Document any architectural decisions made
   - Note any NestJS-specific patterns established

### Important Rules
- Don't skip any phase - complete every phase before moving on
- Don't assume completion without verification - verify completion before proceeding
- Don't proceed to review until development is truly done - confirm development is finished before starting review
- Update the task file between major phases
- Log progress so work can be resumed if interrupted
- Run tests after any code changes
- Verify the build succeeds before marking complete

### NestJS-Specific Checklist
Before finalizing, ensure:
- [ ] All DTOs use class-validator decorators
- [ ] All endpoints have proper HTTP status codes
- [ ] Services use constructor injection
- [ ] Repository/data access is abstracted
- [ ] Error responses follow consistent structure
- [ ] Swagger/OpenAPI decorators present (if applicable)
- [ ] gRPC services properly typed (if applicable)
- [ ] Configuration uses project config patterns
- [ ] Logging follows project conventions

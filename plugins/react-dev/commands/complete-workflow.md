---
description: Complete React development workflow with iterative development, review, and refactoring
---
ultrathink

## React Full Workflow

You are orchestrating a complete React development workflow. Follow these phases STRICTLY and IN ORDER.

### Input

Read this task file: $ARGUMENTS

### Phase 1: Task Initialization
1. Read the task file at the provided path
2. Understand the full scope of work required
3. If task file has a "## Progress" section, understand where the previous agent left off

### Phase 2: Development Loop
Execute this loop until the task is TRULY complete:

1. **Spawn react-senior-dev agent** with:
   - The full task content
   - Any progress notes from previous iterations
   - Instruction to work on the task and report completion status

2. **After agent completes**, evaluate the result:
   - If task is FULLY complete -> Move to Phase 3
   - If agent ran out of context or task is incomplete:
     a. Spawn `doc-updater` agent to update the task file with:
        - What was completed
        - What remains to be done
        - Current state of implementation
        - Next steps for continuation
     b. Spawn ANOTHER `react-senior-dev` agent with the updated task file
     c. Repeat until truly done

**Note**: Don't assume a task is done. Verify by checking:
- All requirements from the task file are implemented
- Code compiles/builds without errors
- All files mentioned in the task have been created/modified

### Phase 3: Code Review
1. Spawn `code-reviewer` agent with instructions to:
   - Review ALL changes made during development
   - Use `git diff` to see modified files
   - Identify: code smells, duplication, security issues, performance problems
   - Document ALL issues found with severity and file locations

2. Spawn `doc-updater` agent to update the task file with:
   - Section "## Code Review Findings"
   - All issues organized by severity (Critical, Warning, Suggestion)
   - Specific file paths and line numbers

### Phase 4: Refactoring
1. Spawn `code-refactor-specialist` agent with:
   - The code review findings
   - Instructions to fix ALL identified issues
   - Focus on code quality, SOLID principles, and functional patterns

2. If any issues remain after refactoring:
   - Repeat code review with `code-reviewer`
   - Continue refactoring until clean

### Phase 5: Completion
1. Spawn `doc-updater` agent to update the task file:
   - File path: [original task file path]
   - Update type: merge
   - Add section "## Status: COMPLETED"
   - Add completion timestamp
   - Summarize all work done
   - List all files created/modified

### Phase 6: Memory Update
1. Spawn `memory-updater` agent with instructions to:
   - Review the entire workflow that was completed
   - Identify any patterns, conventions, or gotchas discovered
   - Update appropriate CLAUDE.md files with new learnings
   - Document any architectural decisions made

### Important Rules
- Don't skip any phase - complete every phase before moving on
- Don't assume completion without verification - verify completion before proceeding
- Don't proceed to review until development is truly done - confirm development is finished before starting review
- Update the task file between major phases
- Log progress so work can be resumed if interrupted

---
description: Complete Flutter development workflow with iterative development, review, testing, and refactoring
---
ultrathink

## Flutter Full Workflow

You are orchestrating a complete Flutter application development workflow. Follow these phases strictly and in order, completing every phase before moving on.

### Input

Read this task file: $ARGUMENTS

### Phase 1: Task Initialization
1. Read the task file at the provided path
2. Understand the full scope of work required
3. If task file has a "## Progress" section, understand where the previous agent left off
4. Read relevant CLAUDE.md files to understand project conventions (especially Clean Architecture patterns)

### Phase 2: Context Gathering
1. Spawn `context-gatherer` agent with:
   - The task file path
   - Instructions to analyze relevant Flutter widgets, blocs, repositories, and use cases
   - Instructions to identify existing patterns and conventions in the codebase
   - Focus on understanding the Clean Architecture layer structure (Domain, Data, Presentation)
2. Update the task file with the context manifest if one doesn't exist

### Phase 3: Development Loop
Execute this loop until the task is TRULY complete:

1. **Spawn flutter-senior-dev agent** with:
   - The full task content
   - Any progress notes from previous iterations
   - Context about existing project patterns (folder structure, state management approach, theming)
   - Instruction to work on the task and report completion status

2. **After agent completes**, evaluate the result:
   - If task is FULLY complete -> Move to Phase 4
   - If agent ran out of context or task is incomplete:
     a. Spawn `doc-updater` agent to update the task file with:
        - What was completed
        - What remains to be done
        - Current state of implementation
        - Next steps for continuation
     b. Spawn ANOTHER `flutter-senior-dev` agent with the updated task file
     c. Repeat until truly done

**Note**: Don't assume a task is done. Verify by checking:
- All requirements from the task file are implemented
- Clean Architecture layer boundaries are respected (Domain has no Flutter imports)
- Dependencies point inward only
- All hardcoded values are extracted to constants
- Dart analyzer passes without errors (`flutter analyze`)

### Phase 4: Static Analysis & Formatting
1. Run static analysis: `flutter analyze`
2. Run format check: `dart format --set-exit-if-changed .`
3. If any issues found:
   - Spawn `flutter-senior-dev` agent to fix analysis warnings and formatting
   - Repeat until clean

### Phase 5: Testing Verification
1. Run the test suite: `flutter test`
2. If tests fail:
   - Analyze failure messages
   - Spawn `flutter-senior-dev` agent to fix failing tests
   - Repeat until all tests pass
3. Check test coverage for new code:
   - Run `flutter test --coverage`
   - Ensure new code has reasonable coverage

### Phase 6: Code Review
1. Spawn `code-reviewer` agent with instructions to:
   - Review ALL changes made during development
   - Use `git diff` to see modified files
   - Focus on Flutter-specific concerns:
     - Clean Architecture compliance (layer boundaries)
     - Proper state management patterns (Bloc/Provider/Riverpod)
     - No hardcoded strings, colors, or dimensions
     - `const` constructors and widgets used where possible
     - Widgets are extracted instead of `_build*` methods
     - Repository interfaces in Domain, implementations in Data
   - Identify: code smells, duplication, security issues, performance problems
   - Document ALL issues found with severity and file locations

2. Spawn `doc-updater` agent to update the task file with:
   - Section "## Code Review Findings"
   - All issues organized by severity (Critical, Warning, Suggestion)
   - Specific file paths and line numbers

### Phase 7: Refactoring
1. Spawn `code-refactor-specialist` agent with:
   - The code review findings
   - Instructions to fix ALL identified issues
   - Focus on:
     - SOLID principles compliance
     - Clean Architecture patterns
     - DRY and KISS principles
     - Flutter/Dart best practices

2. If any issues remain after refactoring:
   - Repeat code review with `code-reviewer`
   - Continue refactoring until clean

3. Re-run tests and analysis after refactoring:
   - `flutter analyze` must pass
   - `flutter test` must pass
   - No regressions allowed

### Phase 8: Build Verification
1. Run `flutter build apk --debug` (or appropriate platform) to ensure it compiles
2. If any issues found:
   - Fix immediately
   - Return to Phase 6 if significant changes were needed

### Phase 9: Completion
1. Spawn `doc-updater` agent to update the task file:
   - File path: [original task file path]
   - Update type: merge
   - Add section "## Status: COMPLETED"
   - Add completion timestamp
   - Summarize all work done
   - List all files created/modified
   - Include test coverage summary if available

### Phase 10: Memory Update
1. Spawn `memory-updater` agent with instructions to:
   - Review the entire workflow that was completed
   - Identify any patterns, conventions, or gotchas discovered
   - Update appropriate CLAUDE.md files with new learnings
   - Document any architectural decisions made
   - Note any Flutter-specific patterns established

### Important Rules
- Don't skip any phase - complete every phase before moving on
- Don't assume completion without verification - verify completion before proceeding
- Don't proceed to review until development is truly done - confirm development is finished before starting review
- Update the task file between major phases
- Log progress so work can be resumed if interrupted
- Run `flutter analyze` after any code changes
- Verify tests pass before marking complete

### Flutter-Specific Checklist
Before finalizing, ensure:
- [ ] Domain layer has NO Flutter imports (pure Dart)
- [ ] Presentation depends on Domain, NOT on Data
- [ ] All strings in `lib/core/constants/app_strings.dart`
- [ ] All colors in `lib/core/theme/app_colors.dart`
- [ ] All dimensions in `lib/core/constants/app_dimens.dart`
- [ ] `const` constructors used where possible
- [ ] Widgets extracted instead of `_build*` methods
- [ ] Repository interfaces in Domain layer
- [ ] Repository implementations in Data layer
- [ ] Use cases encapsulate business logic
- [ ] State management follows project pattern (Bloc/Provider/Riverpod)
- [ ] Error handling with Result/Either patterns where applicable

---
description: Work on a task in a Flutter project with the flutter-senior-dev agent
---
ultrathink

## Your task

1. Read this task file: $ARGUMENTS
2. Work on the task explained in the task file
3. To work on Dart/Flutter files use @flutter-senior-dev agent for:
   - Implementing new features following Clean Architecture
   - Creating widgets, screens, and UI components
   - Building domain entities, use cases, and repository interfaces
   - Implementing data layer (repositories, data sources, models)
   - State management with Bloc/Provider/Riverpod
   - Refactoring existing code to follow best practices
4. Run `flutter analyze` after making changes to ensure code quality
5. When you are done, summon doc-updater agent to write a recap of what you have done in the task file

### Quality Checks Before Completion
- Run `flutter analyze` - no warnings or errors
- Verify Clean Architecture boundaries are respected
- Ensure no hardcoded values in widgets
- Confirm `const` is used where possible

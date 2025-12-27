# Conventions

## Naming Conventions

- **Files**: kebab-case (e.g., `react-dev`, `context-management`)
- **Directories**: kebab-case for plugins, lowercase for standard dirs
- **Agents**: kebab-case descriptive names (e.g., `react-senior-dev`, `flutter-senior-dev`)
- **Commands**: plugin-name:action format (e.g., `/react-dev:execute-task`)

## Plugin Structure

Each plugin should follow this structure:
```
plugin-name/
├── manifest.json       # Plugin metadata and configuration
├── agents/            # Agent definitions (optional)
├── commands/          # Slash commands (optional)
└── hooks/             # Event hooks (optional)
```

## Code Style

- Use TypeScript for any code examples
- Follow functional programming paradigm
- Prefer immutable patterns
- Use descriptive variable names

## Documentation

- Each plugin should have clear descriptions
- Agent descriptions explain when to use them
- Commands document expected arguments
- Hooks explain trigger conditions

## Testing

- Test plugins manually before committing
- Verify commands work as expected
- Ensure agents produce quality output

## Versioning

- Plugins are versioned via git
- Breaking changes require documentation updates
- Maintain backwards compatibility where possible

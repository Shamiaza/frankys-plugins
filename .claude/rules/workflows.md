# Workflows

## Development Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/Shamiaza/claude-plugins.git
   cd claude-plugins
   ```

2. For local development, link the plugin:
   ```bash
   claude plugins:add ./
   ```

## Creating a New Plugin

1. Create a new directory under `plugins/`:
   ```bash
   mkdir plugins/my-plugin
   ```

2. Create `manifest.json` with plugin metadata

3. Add agents, commands, or hooks as needed

4. Update `README.md` with plugin documentation

## Build Process

No build step required - plugins are loaded directly by Claude Code.

## Testing

1. Install plugin locally for testing:
   ```bash
   claude plugins:add ./
   ```

2. Test commands and agents in a sample project

3. Verify expected behavior

## Deployment

1. Commit changes to git:
   ```bash
   git add .
   git commit -m "feat: add new plugin feature"
   ```

2. Push to GitHub:
   ```bash
   git push origin main
   ```

3. Users can install via:
   ```bash
   claude plugins:add github:Shamiaza/claude-plugins
   ```

## Code Review Process

1. Create feature branch for changes
2. Test locally
3. Submit PR with description
4. Verify CI passes (if applicable)
5. Merge to main

## Adding New Agents

1. Create agent definition in plugin's `agents/` directory
2. Define clear agent description and use cases
3. Specify tools the agent should have access to
4. Add agent to manifest.json
5. Document in README.md

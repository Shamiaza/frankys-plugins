# New Plugin Checklist

When creating a new plugin in this repository, you MUST complete ALL these steps:

## Required Files

1. `plugins/<name>/.claude-plugin/plugin.json` - Plugin metadata
   ```json
   {
     "name": "<name>",
     "version": "1.0.0",
     "description": "<description>",
     "author": {
       "name": "Shamiaza"
     }
   }
   ```

2. `plugins/<name>/commands/*.md` - Commands with YAML frontmatter
   ```yaml
   ---
   description: "Short description"
   argument-hint: "<args>"  # optional
   ---
   ```

3. `plugins/<name>/README.md` - Documentation

## CRITICAL: Update Marketplace

**ALWAYS add the new plugin to `.claude-plugin/marketplace.json`:**

```json
{
  "name": "<name>",
  "description": "<description>",
  "version": "1.0.0",
  "author": {
    "name": "Shamiaza"
  },
  "source": "./plugins/<name>",
  "category": "productivity"  // or "development"
}
```

## CRITICAL: Update CLAUDE.md

Add the plugin to the table in `CLAUDE.md`:
- Available Plugins table
- Key Commands section
- Install Hooks/Rules section (if applicable)

## Verification

Before committing, verify:
- [ ] Plugin appears in `marketplace.json`
- [ ] Commands have YAML frontmatter with `description`
- [ ] `plugin.json` uses `"author": {"name": "..."}` format
- [ ] CLAUDE.md is updated

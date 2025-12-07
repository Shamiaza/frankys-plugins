---
description: Generate documentation for React components
---
ultrathink

# Generate React Documentation

Create documentation for this folder/file/piece of code: $ARGUMENTS following these steps:

1. Use parallel @react-docs-writer agents to read the target and gather information.
2. Summon a @doc-updater every time a react-docs-writer completes to create and update a .md file in the folder /docs with all the discoveries from the react-docs-writer. The .md file name must be the same as the analyzed file. Keep the same folder structure that you find when checking the file. So if the file is under src/components expect to find the .md file under docs/src/components.

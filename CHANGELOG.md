# Changelog

## Unreleased public fork

### Added
- English UI, prompts, and documentation.
- Local KuzuDB-backed knowledge graph storage.
- Anthropic API support.
- OpenAI and OpenAI-compatible API support.
- Optional Codex CLI provider mode.
- Docker/self-hosting path using local runtime volumes.
- Workbench/session/resource abstractions for cleaner backend organization.

### Changed
- Removed hosted graph-service assumptions from the main workflow.
- Updated documentation for public self-hosting.
- Increased default token room for long simulation/report flows.
- Improved compatibility with local OpenAI-compatible models, including Qwen-style reasoning outputs.

### Removed from public release
- Private deployment configuration.
- Claude local OAuth proxy experiments.
- Runtime uploads, graph data, logs, and scenario files.

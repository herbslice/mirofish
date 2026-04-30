# MiroFish

MiroFish is a swarm-intelligence prediction workbench. Upload documents describing a scenario, build a knowledge graph, generate simulated agent personas, run social-media-style interactions, and produce an analysis report.

This repository is a cleaned public fork of [666ghj/MiroFish](https://github.com/666ghj/MiroFish). It focuses on an English UI, local-first graph storage, and practical LLM provider support.

## What it does

1. **Upload reality seeds** — PDFs, Markdown, or text files.
2. **Describe what to predict** — for example, “Predict public reaction to this policy over 30 days.”
3. **Build a world model** — extract entities and relationships into a local graph.
4. **Generate personas** — create simulated agents with distinct attributes and views.
5. **Run simulations** — simulate Twitter/Reddit-style activity across rounds.
6. **Analyze outcomes** — generate a report and chat with the report/agents.

## Changes from upstream

| Area | Upstream | This fork |
|---|---|---|
| Language | Chinese UI and prompts | English UI, prompts, and docs |
| Graph storage | Hosted graph-service dependency | Local embedded KuzuDB |
| LLM support | Original provider path | Anthropic API, OpenAI API, OpenAI-compatible APIs, optional Codex CLI |
| Entity extraction | Managed extraction pipeline | LLM-based extraction using your configured model |
| Architecture | Larger API/service coupling | Workbench/session/resource abstractions and thinner API shells |
| Self-hosting | Upstream defaults | Docker/local-dev setup with runtime data excluded |

## LLM providers

Configure `.env` from `.env.example`.

### Anthropic API

```env
LLM_PROVIDER=anthropic
LLM_API_KEY=your_anthropic_api_key
LLM_MODEL_NAME=claude-sonnet-4-20250514
```

### OpenAI API

```env
LLM_PROVIDER=openai
LLM_API_KEY=your_openai_api_key
LLM_BASE_URL=https://api.openai.com/v1
LLM_MODEL_NAME=gpt-4o-mini
```

### OpenAI-compatible APIs

Use this mode for OpenRouter, LiteLLM, vLLM, LM Studio, Ollama’s OpenAI-compatible endpoint, MLX server, and similar services.

```env
LLM_PROVIDER=openai
LLM_API_KEY=your_key_or_dummy_value_for_local_servers
LLM_BASE_URL=http://localhost:8080/v1
LLM_MODEL_NAME=your-model-name
```

### Codex CLI (optional / experimental)

```env
LLM_PROVIDER=codex-cli
```

This mode shells out to the local `codex` CLI. It is useful for local experimentation, but API providers are recommended for reproducible deployments.

## Quick start

### Prerequisites

- Node.js 18+
- Python 3.11–3.12
- [uv](https://docs.astral.sh/uv/) for Python dependency management

### Local development

```bash
cp .env.example .env
# Edit .env with your provider settings
npm run setup:all
npm run dev
```

Development URLs:

- Frontend: http://localhost:3000
- Backend API: http://localhost:5001

### Docker

```bash
cp .env.example .env
# Edit .env
docker compose up -d --build
```

The Docker image builds the Vue frontend, serves it from the Flask backend, and exposes the combined app on `http://localhost:5001`.

## Architecture

```text
frontend/          Vue 3 + Vite + D3.js
backend/
  app/
    api/           Flask REST endpoints
    core/          Workbench sessions, resource loading, task management
    resources/     Project/document/graph/simulation/report stores
    tools/         Composable workbench operations
    services/
      graph_db.py          KuzuDB-backed knowledge graph
      entity_extractor.py  LLM-based entity and relationship extraction
      graph_builder.py     Ontology-to-graph pipeline
      simulation_runner.py OASIS multi-agent simulation subprocess
      report_agent.py      ReACT-style report agent
      kuzu_tools.py        Search, interview, and analysis tools
    utils/
      llm_client.py        Anthropic/OpenAI-compatible/Codex client wrapper
  scripts/         OASIS simulation runner scripts
```

Runtime state is written under `backend/uploads/` and graph data under `backend/data/`. These directories are intentionally ignored by git and Docker build context.

## Pipeline

```text
Document upload
  → LLM ontology extraction
  → Local KuzuDB knowledge graph
  → Entity filtering
  → Agent persona generation
  → OASIS social simulation
  → Graph memory updates
  → Report generation
  → Interactive report/agent chat
```

## Attribution

- Original project: [MiroFish](https://github.com/666ghj/MiroFish) by 666ghj.
- Major English/local-first fork work: Ali Madad.
- Additional public-release cleanup and provider fixes: herbslice and contributors.
- OASIS simulation framework: [CAMEL-AI OASIS](https://github.com/camel-ai/oasis).
- Embedded graph database: [KuzuDB](https://github.com/kuzudb/kuzu).

See [`NOTICE`](NOTICE) and [`AUTHORS`](AUTHORS) for attribution details.

## Security

Do not commit `.env`, uploads, logs, generated graph data, or simulation output. See [`SECURITY.md`](SECURITY.md).

## License

AGPL-3.0. See [`LICENSE`](LICENSE).

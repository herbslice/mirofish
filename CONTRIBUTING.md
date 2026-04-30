# Contributing

Thanks for improving MiroFish.

## Development

```bash
cp .env.example .env
npm run setup:all
npm run dev
```

Run the frontend build before opening a PR:

```bash
npm run build
```

For backend smoke testing:

```bash
cd backend
uv run python - <<'PY'
from app import create_app
app = create_app()
print('routes', len(app.url_map._rules))
PY
```

## Guidelines

- Preserve AGPL-3.0 licensing and upstream attribution.
- Do not commit runtime data, uploads, graph databases, logs, or secrets.
- Prefer provider-neutral OpenAI-compatible API support where possible.
- Keep deployment-specific configuration out of the default Docker Compose file.

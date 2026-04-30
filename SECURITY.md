# Security Policy

## Sensitive files

Never commit:

- `.env` or environment-specific `.env.*` files
- API keys, tokens, passwords, OAuth material, or private keys
- Uploaded documents or simulation seed data
- Generated graph databases under `backend/data/`
- Runtime uploads under `backend/uploads/`
- Logs under `backend/logs/`

The repository includes `.gitignore` and `.dockerignore` rules for these paths, but contributors should still review diffs before committing.

## Reporting issues

Please open a GitHub security advisory or private issue with the maintainer if you find a vulnerability or accidental secret exposure.

## Deployment note

MiroFish sends uploaded document content to the configured LLM provider. Do not process confidential documents unless you trust the configured provider and deployment environment.

# Spacedog Umbrel App Store

A personal Umbrel Community App Store for maintained self-hosted app packages that are not available, or not sufficiently current, in the official Umbrel App Store.

## Add this store to Umbrel

Add the following Community App Store URL in the umbrelOS App Store settings:

```text
https://github.com/spacedog-r/spacedog-umbrel-app-store
```

## Apps

### Dawarich

- Package ID: `spacedog-dawarich`
- Upstream version: `1.10.0`
- Architecture: `linux/amd64`
- Upstream project: https://github.com/Freika/dawarich

The package uses pinned image tags and manifest digests, app-specific persistent data under Umbrel's app data directory, Umbrel's app proxy, and locally derived per-install secrets. No secrets are stored in this repository.

The official PostGIS image selected by Dawarich 1.10.0 is amd64-only. ARM support can be evaluated separately using the alternative image recommended by Dawarich upstream.

#### Runtime verification

Dawarich 1.10.0 has been verified on an amd64 umbrelOS system:

- installation and first-start database setup
- Umbrel-generated login credentials
- app-proxy access
- GPX upload and import
- Redis and Sidekiq background processing
- PostgreSQL/PostGIS persistence across restarts
- clean uninstall and reinstall

A real in-place upgrade test is deferred until a newer stable upstream release is packaged.

## Security

The package does not use privileged mode, host networking, the Docker socket, device mounts, or broad host mounts. Dawarich API routes bypass Umbrel proxy authentication so mobile clients and trackers can connect; those routes remain protected by Dawarich API keys. The browser UI remains protected by Umbrel authentication.

Dawarich's public upstream demo password is replaced on first start with Umbrel's deterministic per-install app password.

## Updating

Updates are reviewed against the upstream release notes and Compose configuration before image versions or digests are changed. Automatic `latest` updates are intentionally not used.

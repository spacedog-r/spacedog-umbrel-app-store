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

### Grimmory

- Package ID: `spacedog-grimmory`
- Upstream version: `3.2.4`
- Architectures: `linux/amd64`, `linux/arm64`
- Upstream project: https://github.com/grimmory-tools/grimmory

Grimmory uses its official release image and the LinuxServer MariaDB image selected by upstream, both pinned by tag and manifest digest. Application data, books, BookDrop, and MariaDB are stored under Umbrel's app data directory. Database credentials are derived locally per install.

#### Runtime verification

Grimmory 3.2.4 has been verified on an amd64 umbrelOS system:

- installation, database migrations, and first-run admin setup
- app-proxy access and authenticated login
- library creation using the persistent `/books` mount
- browser upload to BookDrop
- EPUB metadata processing and finalization into a library
- built-in EPUB reader
- MariaDB, library metadata, and book-file persistence across restarts
- clean uninstall and reinstall

Grimmory can briefly return `ERR_CONNECTION_RESET` immediately after install or restart while MariaDB, migrations, and the Java application finish starting. Refresh after a short wait. Investigate the container logs if it remains unavailable for more than five minutes.

A real in-place upgrade test is deferred until a newer stable upstream release is packaged.

## Security

Packages do not use privileged mode, host networking, the Docker socket, device mounts, or broad host mounts.

Dawarich API routes bypass Umbrel proxy authentication so mobile clients and trackers can connect; those routes remain protected by Dawarich API keys. Dawarich's public upstream demo password is replaced on first start with Umbrel's deterministic per-install app password.

Grimmory exposes only its OPDS, KOReader, and Kobo integration paths past Umbrel proxy authentication. Grimmory's own account or token authentication remains in force. Its administrator account is created through Grimmory's upstream first-run wizard.

## Updating

Updates are reviewed against the upstream release notes and Compose configuration before image versions or digests are changed. Automatic `latest` updates are intentionally not used.

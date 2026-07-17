<div align="center">

# Spacedog Umbrel App Store

Maintained Umbrel packages for self-hosted apps that are missing or outdated in other app stores.

**2 apps · pinned images · locally generated secrets · runtime tested**

</div>

## Add to Umbrel

1. Open the **App Store** in umbrelOS.
2. Open the Community App Store settings.
3. Add this repository:

```text
https://github.com/spacedog-r/spacedog-umbrel-app-store
```

## Available apps

| App | Package | Version | Platforms | Status |
| --- | --- | --- | --- | --- |
| <img src="./spacedog-dawarich/assets/icon.png" width="44" alt="Dawarich icon"> **Dawarich** | `spacedog-dawarich` | 1.10.0 | amd64 | ✅ Runtime verified |
| <img src="./spacedog-grimmory/assets/icon.png" width="44" alt="Grimmory icon"> **Grimmory** | `spacedog-grimmory` | 3.2.4 | amd64, arm64 | ✅ Runtime verified |

---

## <img src="./spacedog-dawarich/assets/icon.png" width="36" alt=""> Dawarich

A self-hosted location history tracker and Google Timeline alternative.

[Package files](./spacedog-dawarich) · [Upstream project](https://github.com/Freika/dawarich) · [Website](https://dawarich.app)

- Interactive maps, trips, statistics, and insights
- Imports from Google Maps Timeline, OwnTracks, GPX, and GeoJSON
- Mobile app and tracker API support
- PostgreSQL/PostGIS, Redis, and Sidekiq
- Umbrel-generated login password and persistent appdata

> **Compatibility:** This package currently targets amd64 because the official PostGIS image selected by Dawarich 1.10.0 is amd64-only.

<details>
<summary><strong>Runtime verification</strong></summary>

Dawarich 1.10.0 has been tested on an amd64 umbrelOS system:

- Installation and first-start database setup
- Umbrel-generated credentials and app-proxy access
- GPX upload and import
- Redis and Sidekiq background processing
- PostgreSQL/PostGIS persistence across restarts
- Clean uninstall and reinstall

</details>

---

## <img src="./spacedog-grimmory/assets/icon.png" width="36" alt=""> Grimmory

A self-hosted digital library for ebooks, PDFs, comics, and audiobooks.

[Package files](./spacedog-grimmory) · [Upstream project](https://github.com/grimmory-tools/grimmory) · [Website](https://grimmory.org)

- Browser-based readers and metadata lookup
- Smart shelves, annotations, and reading progress
- BookDrop uploads and automatic processing
- OPDS, Kobo, and KOReader integrations
- Multi-user support and persistent MariaDB storage

> **Startup note:** Grimmory can briefly return `ERR_CONNECTION_RESET` after installation or restart while MariaDB, migrations, and the Java application finish starting. Refresh after a short wait. Check the container logs if it remains unavailable for more than five minutes.

<details>
<summary><strong>Runtime verification</strong></summary>

Grimmory 3.2.4 has been tested on an amd64 umbrelOS system:

- Installation, database migrations, and first-run admin setup
- App-proxy access and authenticated login
- Library creation using the persistent `/books` mount
- Browser upload to BookDrop
- EPUB metadata processing and library finalization
- Built-in EPUB reader
- MariaDB, metadata, and book-file persistence across restarts
- Clean uninstall and reinstall

</details>

## Security

- ✅ Image versions and manifest digests are pinned
- ✅ Secrets are generated locally per installation
- ✅ Persistent data stays inside Umbrel's appdata structure
- ✅ No privileged mode or host networking
- ✅ No Docker socket, device mounts, or broad host mounts
- ✅ No `latest` tags

Dawarich API routes bypass Umbrel proxy authentication for mobile clients and trackers, but remain protected by Dawarich API keys.

Grimmory exposes only its OPDS, KOReader, and Kobo integration routes past Umbrel proxy authentication. Grimmory's own account or token authentication remains active.

## Updates

Every update is reviewed against upstream release notes, Compose configuration, environment variables, and image manifests before publication.

Real in-place upgrades are tested when a newer stable upstream release becomes available.

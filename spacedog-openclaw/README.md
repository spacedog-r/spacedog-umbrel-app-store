# OpenClaw for the Spacedog Umbrel Store (preview)

This package follows **OpenClaw 2026.10.4** via the official upstream
`ghcr.io/openclaw/openclaw:2026.10.4` image. It is NOT based on Umbrel's
custom `openclaw-umbrel` image and does not inherit Umbrel's guided first-run UX.

## Install and first run

1. Add the Spacedog community app store to Umbrel and install OpenClaw (Spacedog).
2. The application uses an Umbrel-generated gateway token. Do not replace it with
   a predictable string or commit secrets to Git.
3. The upstream image may require initialization of
   `data/state/openclaw.json` before the gateway becomes usable.
   Use the official CLI onboarding procedure with the app's Docker container and
   its persistent data mount; do not install npm or Node directly on UmbrelOS.
4. Configure `gateway.mode=local`, `gateway.bind=lan`, and the exact
   `gateway.controlUi.allowedOrigins` corresponding to the URL through which
   you access this app. Browser pairing may be required.
5. Verify that Umbrel proxy authentication and OpenClaw gateway token
   authentication both work before connecting chat integrations.

**Status:** Package is proposed, not yet runtime tested on an UmbrelOS host.
Do not deploy over an existing `openclaw` app. This app has the distinct
`spacedog-openclaw` ID and a separate persistent appdata directory.

## Updating

The image is deliberately pinned to a stable version tag rather than
`latest`. Review upstream release notes, bump BOTH the Compose image tag
and manifest version, test the upgrade and data persistence, and then publish.
Umbrel will not automatically pull a fresh image solely because a moving
`latest` tag changes.

## Security

- OpenClaw is a powerful agent; treat its integrations and installed skills as
  privileged and review them carefully.
- The app is behind Umbrel's authenticated app proxy and has no direct published
  gateway port, Docker socket, host network, privileged mode, or extra host mounts.
- Persistent state and auth profiles live in `data/state` and `data/auth`.
- Keep the gateway token secret; back up appdata securely before upgrading.
- This upstream image does NOT include the custom Umbrel browser environment.
  Browser-control behavior has not been tested and should not be assumed.
- If the Control UI refuses access due to an origin/pairing issue, configure
  permitted origins and device pairing; do NOT bypass Gateway authentication.

Upstream documentation: https://docs.openclaw.ai/install/docker

## First-install verification on UmbrelOS

Once this PR is merged into `master`, refresh the community store and install
**OpenClaw (Spacedog)**. This is a preview until runtime validated.

1. In UmbrelOS, verify the app starts and opens through the Umbrel app tile.
2. Over SSH, inspect status and logs without exposing secrets:
   ```sh
   sudo docker ps --filter name=spacedog-openclaw
   sudo docker logs --tail=100 spacedog-openclaw_gateway_1
   ```
   If your Umbrel uses a different container naming convention, take the exact
   name from `docker ps`.
3. The gateway token is generated locally by Umbrel and injected into the
   container environment. To read it **privately** on the host (do not paste it
   into public issues, chat logs or screenshots):
   ```sh
   sudo docker exec spacedog-openclaw_gateway_1 printenv OPENCLAW_GATEWAY_TOKEN
   ```
   Enter that token in OpenClaw's Control UI Settings.
4. If the browser reports `origin not allowed`, configure the exact trusted
   Umbrel URL in `gateway.controlUi.allowedOrigins` within the persistent
   `openclaw.json`. Never enable wildcard origins to work around it.
5. Confirm that Gateway token/device pairing is functional and reboot Umbrel;
   check that config persists and the container returns to a healthy state.
6. Back up the app's data before any upgrade.

The pre-start hook creates a minimal `gateway.mode=local` config when missing.
It will not overwrite subsequent manual settings. A provider/API key must still
be configured using OpenClaw's normal process. No provider secrets are bundled.

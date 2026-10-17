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

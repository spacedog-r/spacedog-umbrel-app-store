# Derive a unique stable Gateway token from Umbrel's per-install entropy.
export APP_SPACEDOG_OPENCLAW_GATEWAY_TOKEN="$(derive_entropy "${app_entropy_identifier}-gateway-token")"

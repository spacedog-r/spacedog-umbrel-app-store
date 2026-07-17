export APP_SPACEDOG_DAWARICH_POSTGRES_PASSWORD="$(derive_entropy "${app_entropy_identifier}-postgres-password")"
export APP_SPACEDOG_DAWARICH_SECRET_KEY_BASE="$(derive_entropy "${app_entropy_identifier}-secret-key-base")"

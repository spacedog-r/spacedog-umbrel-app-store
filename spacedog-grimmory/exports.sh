export APP_SPACEDOG_GRIMMORY_DATABASE_PASSWORD="$(derive_entropy "${app_entropy_identifier}-database-password")"
export APP_SPACEDOG_GRIMMORY_DATABASE_ROOT_PASSWORD="$(derive_entropy "${app_entropy_identifier}-database-root-password")"

Provide common docker environment
- Database initialization script `./backups/backup.sql`
- Initialize Keycloak users and realm `./keycloak-data/import/`


Database initialization script will not run direct with docker. You need to explicit to change Database `./scripts/migrate-db-import.sh`


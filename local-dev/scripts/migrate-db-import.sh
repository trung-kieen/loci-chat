#!/bin/bash
# Import all sql in ../backups/ folder as migration script to docker db service

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# NOTE: run this in current directory not root (use relative path to the ../backups/ folder)
BACKUP_FILE=$(ls -t $SCRIPT_DIR/../backups/*.sql | head -n1)
until docker exec -t loci-db pg_isready -U admin ; do sleep 1; done

# Restore database
cat "$BACKUP_FILE" | docker exec -i loci-db psql -U admin -d locidb

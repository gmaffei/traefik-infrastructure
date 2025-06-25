#!/bin/bash

BACKUP_DIR="/backups/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

echo "🔄 Starting backup..."

# Backup each service
for service in /opt/*/; do
    if [ -f "$service/docker-compose.yml" ]; then
        service_name=$(basename "$service")
        echo "Backing up $service_name..."
        
        cd "$service"
        docker-compose exec -T postgres pg_dump -U dbuser dbname > "$BACKUP_DIR/${service_name}_db.sql" 2>/dev/null || true
    fi
done

echo "✅ Backup completed: $BACKUP_DIR"

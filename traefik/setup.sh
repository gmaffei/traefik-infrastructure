#!/bin/bash

echo "🚀 Setting up Traefik..."

# Check .env
if [ ! -f .env ]; then
    echo "Creating .env from example..."
    cp .env.example .env
    echo "⚠️  Please edit .env with your configuration!"
    exit 1
fi

# Create network
docker network create traefik-public 2>/dev/null || true

# Create acme.json with correct permissions
touch acme.json
chmod 600 acme.json

# Start Traefik
docker-compose up -d

echo "✅ Traefik is running!"
echo "📊 Dashboard will be available at: https://traefik.$BASE_DOMAIN"

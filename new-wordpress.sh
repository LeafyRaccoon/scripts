#!/bin/bash

read -p "Enter site name (e.g. client1): " SITENAME

# Where you keep your sites
SITE_DIR=~/websites/$SITENAME

# Create folder
mkdir -p "$SITE_DIR"
cd "$SITE_DIR" || exit

# Initialize DDEV
ddev config --project-type=wordpress --docroot=web --create-docroot --project-name=$SITENAME
ddev start

# Install Bedrock
composer create-project roots/bedrock web

# Copy and update .env
cp web/.env.example web/.env

# Update .env values
sed -i "s|DB_NAME=.*|DB_NAME=db|" web/.env
sed -i "s|DB_USER=.*|DB_USER=db|" web/.env
sed -i "s|DB_PASSWORD=.*|DB_PASSWORD=db|" web/.env
sed -i "s|DB_HOST=.*|DB_HOST=db|" web/.env
sed -i "s|WP_HOME=.*|WP_HOME=https://${SITENAME}.ddev.site|" web/.env
sed -i "s|WP_SITEURL=.*|WP_SITEURL=https://${SITENAME}.ddev.site/wp|" web/.env

echo ""
echo "✅ WordPress project '$SITENAME' created at $SITE_DIR"
echo "🌐 Visit: https://${SITENAME}.ddev.site"

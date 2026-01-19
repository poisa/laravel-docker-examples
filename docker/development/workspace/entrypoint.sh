#!/bin/bash
set -e

# Source NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Install npm dependencies if node_modules doesn't exist
if [ ! -d /var/www/node_modules ]; then
    echo "Installing npm dependencies..."
    npm install
fi

# Run the default command
exec "$@"

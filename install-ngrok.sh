#!/usr/bin/env bash
# Usage: ./install-ngrok.sh <NGROK_AUTHTOKEN>
set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <NGROK_AUTHTOKEN>"
  exit 1
fi
TOKEN="$1"

NGROK_BIN="/usr/local/bin/ngrok"

# Download ngrok if missing
if ! command -v ngrok >/dev/null 2>&1; then
  echo "ngrok not found — téléchargement..."
  TMPZIP="$(mktemp -u)/ngrok.zip"
  ARCH="$(uname -m)"
  if [ "$ARCH" = "x86_64" ]; then
    URL="https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip"
  else
    # fallback generic
    URL="https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip"
  fi
  curl -sSL -o /tmp/ngrok.zip "$URL"
  unzip -o /tmp/ngrok.zip -d /tmp
  sudo mv /tmp/ngrok "$NGROK_BIN"
  sudo chown root:root "$NGROK_BIN"
  sudo chmod 0755 "$NGROK_BIN"
  rm -f /tmp/ngrok.zip
  echo "ngrok installé dans $NGROK_BIN"
else
  echo "ngrok déjà présent"
fi

# Configure token
echo "Configuration du token ngrok..."
ngrok config add-authtoken "$TOKEN"

echo "Démarrage du tunnel ngrok vers le port 3000 (CTRL+C pour arrêter)..."
# Démarrer le tunnel (foreground)
ngrok http 3000

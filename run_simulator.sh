#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SDK_HOME="${CONNECTIQ_SDK_HOME:-$HOME/.Garmin/ConnectIQ/Sdks/connectiq-sdk-lin-9.1.0-2026-03-09-6a872a80b}"
SDK_BIN="$SDK_HOME/bin"
MONKEYC="$SDK_BIN/monkeyc"
MONKEYDO="$SDK_BIN/monkeydo"
SIMULATOR_LAUNCHER="$SDK_BIN/connectiq"
JUNGLE_FILE="$ROOT_DIR/monkey.jungle"
KEY_FILE="$ROOT_DIR/devkey/developer_key"
OUTPUT_FILE="$ROOT_DIR/bin/GAP.prg"

if [[ ! -x "$MONKEYC" || ! -x "$MONKEYDO" || ! -x "$SIMULATOR_LAUNCHER" ]]; then
    echo "Connect IQ SDK tools not found under: $SDK_BIN" >&2
    echo "Set CONNECTIQ_SDK_HOME to your SDK directory and try again." >&2
    exit 1
fi

if [[ ! -f "$KEY_FILE" ]]; then
    echo "Developer key not found: $KEY_FILE" >&2
    exit 1
fi

DEVICE_ID="${1:-$(sed -n 's/.*<iq:product id="\([^"]*\)".*/\1/p' "$ROOT_DIR/manifest.xml" | head -n 1)}"

if [[ -z "$DEVICE_ID" ]]; then
    echo "Unable to determine a simulator device from manifest.xml." >&2
    echo "Usage: $0 [device_id]" >&2
    exit 1
fi

mkdir -p "$ROOT_DIR/bin"

echo "Building for $DEVICE_ID..."
"$MONKEYC" -f "$JUNGLE_FILE" -o "$OUTPUT_FILE" -y "$KEY_FILE"

if ! pgrep -f "$SDK_BIN/simulator" >/dev/null 2>&1; then
    echo "Starting Connect IQ simulator..."
    "$SIMULATOR_LAUNCHER" &
    SIMULATOR_PID=$!
    disown "$SIMULATOR_PID" 2>/dev/null || true
    sleep 3
else
    echo "Connect IQ simulator already running."
fi

echo "Launching app in simulator..."
echo "Press Ctrl+C to stop this script if you want to leave the simulator open."
exec "$MONKEYDO" "$OUTPUT_FILE" "$DEVICE_ID"

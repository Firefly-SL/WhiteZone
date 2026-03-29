#!/usr/bin/env bash
set -euo pipefail

appName="white-zone"
binaryDirectory="$HOME/.local/bin"
serviceDirectory="$HOME/.config/systemd/user"
serviceName="${appName}.service"
binaryPath="${binaryDirectory}/${appName}"
configDirectory="$HOME/.config/white-zone"
arch=$(uname -m)

if [[ "$arch" != "x86_64" ]]; then
  echo "Error: Detected '$arch', $appName requires x86_64 (amd64) CPU architecture." >&2
  exit 1
fi

uninstall() {
    echo -e "Uninstalling $appName...\n"

  if systemctl --user list-unit-files | grep -q "^${serviceName}"; then
    systemctl --user stop "$serviceName" --quiet || true
    systemctl --user disable "$serviceName" --quiet || true
    rm -f "$serviceDirectory/$serviceName"
    systemctl --user daemon-reload
    echo "     Removed systemd service"
  else
    echo "     Service not found."
  fi

  if [[ -d "$configDirectory" ]]; then
    rm -rf "$configDirectory"
    echo "     Removed config directory: $configDirectory"
  else
    echo "     Config directory not found."
  fi
  
  if [[ -f "$binaryPath" ]]; then
    rm -f "$binaryPath"
    echo -e "     Removed $appName\n"
    echo "$appName Uninstalled."
  else
    echo -e "     $appName not found.\n"
  fi

  exit 0
}

if [[ "${1:-}" == "--uninstall" ]]; then
  uninstall
fi

mkdir -p "$binaryDirectory" "$serviceDirectory"

tmpfile="$(mktemp)"
cleanup() { rm -f "$tmpfile"; }
trap cleanup EXIT

release_json=$(curl -fsSL https://api.github.com/repos/Firefly-SL/WhiteZone/releases/latest)

BINARY_URL=$(printf '%s\n' "$release_json" \
  | awk -F'"' '/"browser_download_url":/ && /whitezone-linux-x64/ {print $4; exit}')

EXPECTED_SHA256=$(printf '%s\n' "$release_json" \
  | awk -F'"' '
    /"name": "whitezone-linux-x64"/ {found=1}
    found && /"digest":/ {
      gsub(/^sha256:/, "", $4)
      print $4
      exit
    }')

if [[ -z "$BINARY_URL" ]]; then
  echo "Error: could not find Linux binary URL" >&2
  exit 1
fi

curl -fL -# "$BINARY_URL" -o "$tmpfile"
echo -e '\n\x08'

if [[ -n "$EXPECTED_SHA256" ]]; then
  actual_sha256="$(sha256sum "$tmpfile" | awk '{print $1}')"
  if [[ "$actual_sha256" != "$EXPECTED_SHA256" ]]; then
    echo "Error: SHA256 mismatch." >&2
    exit 1
  fi
fi

install -m 0755 "$tmpfile" "$binaryPath"

cat > "$serviceDirectory/$serviceName" <<EOF
[Unit]
Description=$appName
After=network-online.target

[Service]
Type=simple
ExecStart=$binaryPath
Restart=on-failure
RestartSec=5

[Install]
WantedBy=default.target
EOF

systemctl --user daemon-reload
systemctl --user enable --now "$serviceName" --quiet

echo "Enabled user service: $serviceName"
echo "$appName Installed: '$binaryPath'"
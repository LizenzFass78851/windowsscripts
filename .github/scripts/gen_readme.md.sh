#!/bin/bash
set -euo pipefail

PATCHTHEFILE=README.md
TEMPFILE=$(mktemp)
trap 'rm -f "$TEMPFILE"' EXIT

cat <<'EOF' > "$TEMPFILE"
# Windows Scripts


Contains scripts and files for retrofitting certain functions under windows

## Overview of the scripts and tools:

| Script / tool |
| --- |
EOF

escape_markdown() {
  local label=$1
  label=${label//\\/\\\\}
  label=${label//\[/\\[}
  label=${label//\]/\\]}
  label=${label//|/\\|}
  printf '%s' "$label"
}

urlencode_path() {
  local value=$1 encoded= character hex index
  local LC_ALL=C

  for ((index = 0; index < ${#value}; index++)); do
    character=${value:index:1}
    case "$character" in
      [a-zA-Z0-9._~-]) encoded+=$character ;;
      *) printf -v hex '%%%02X' "'$character"; encoded+=$hex ;;
    esac
  done

  printf '%s' "$encoded"
}

find . -mindepth 1 -maxdepth 1 -type d ! -name '.git' ! -name '.github' -print0 \
  | LC_ALL=C sort -fz \
  | while IFS= read -r -d '' directory; do
      name=${directory#./}
      label=$(escape_markdown "$name")
      target=$(urlencode_path "$name")
      printf '| [%s](./%s/) |\n' "$label" "$target" >> "$TEMPFILE"
    done

mv "$TEMPFILE" "$PATCHTHEFILE"

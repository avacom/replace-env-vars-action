#!/usr/bin/env bash

set -e
FILENAME=$1

if [ -z "$FILENAME" ]; then
  echo 'The path to the file is required'
  exit 1
fi

printenv | while IFS= read -r line; do
  key="${line%%=*}"          # everything before the first =
  value="${line#*=}"         # everything after the first =

  # escape characters that break sed replacement
  safe_value=$(printf '%s' "$value" | sed -e 's/[\/&\\]/\\&/g')

  sed -i "s|__${key}__|${safe_value}|g" "$FILENAME"
done

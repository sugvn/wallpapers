#!/usr/bin/env bash
set -euo pipefail

out="README.md"
width=500

shopt -s nullglob nocaseglob
images=(*.png *.jpg *.jpeg)

if [ ${#images[@]} -eq 0 ]; then
    echo "no images found" >&2
    exit 1
fi

if [ -e "$out" ] && [ "${1:-}" != "-f" ]; then
    echo "$out already exists, run with -f to overwrite" >&2
    exit 1
fi

{
    echo "# $(basename "$PWD")"
    echo
    for img in "${images[@]}"; do
        echo "<img src=\"${img// /%20}\" alt=\"${img%.*}\" width=\"$width\">"
        echo
    done
} > "$out"

echo "wrote $out with ${#images[@]} images"

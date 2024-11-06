#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "Usage: $0 <path-to-image>"
  exit 1
fi

to_camel_case() {
  local input="$1"
  echo "$input" | awk -F '_' '{
    for (i = 1; i <= NF; i++) {
      if (i == 1) {
        printf "%s", tolower($i)
      } else {
        printf "%s", toupper(substr($i, 1, 1)) tolower(substr($i, 2))
      }
    }
  }'
}

output=$(matugen image "$1" --show-colors)

generate_palette() {
  declare -A sections=(
    ["Primary"]="primary on_primary primary_container on_primary_container inverse_primary primary_fixed primary_fixed_dim on_primary_fixed on_primary_fixed_variant"
    ["Secondary"]="secondary on_secondary secondary_container on_secondary_container secondary_fixed secondary_fixed_dim on_secondary_fixed on_secondary_fixed_variant"
    ["Tertiary"]="tertiary on_tertiary tertiary_container on_tertiary_container tertiary_fixed tertiary_fixed_dim on_tertiary_fixed on_tertiary_fixed_variant"
    ["Error"]="error on_error error_container on_error_container"
    ["Surface"]="surface surface_dim surface_bright surface_container_lowest surface_container_low surface_container surface_container_high surface_container_highest on_surface on_surface_variant inverse_surface inverse_on_surface surface_variant"
    ["Outline"]="outline outline_variant"
    ["Background"]="background on_background"
    ["Shadow"]="shadow scrim"
    ["Source"]="source_color"
  )

  echo "{"

  for section in Primary Secondary Tertiary Error Surface Outline Background Shadow Source; do
    echo "  # $section"
    for attr in ${sections[$section]}; do
      line=$(echo "$output" | grep -E "│ *$attr *│")
      if [[ -n "$line" ]]; then
        dark_color=$(echo "$line" | awk -F '│' '{gsub(/ /, "", $5); print $5}')
        camel_case_name=$(to_camel_case "$attr")
        dark_color=${dark_color/#\#/}
        echo "  $camel_case_name = \"$dark_color\";"
      fi
    done
    echo ""
  done

  echo "}"
}

generate_palette > test_palette.nix
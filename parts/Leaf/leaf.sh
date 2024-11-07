#!/usr/bin/env bash

set -euo pipefail

# Vars
readonly VERSION="v0.2.2"
readonly DEFAULT_FLAKE="${FLAKE:-$(pwd)}"
readonly NAME="Leaf"
readonly CMDNAME="leaf"
readonly HOSTNAME=$(hostname)
readonly PATH_DIRS="/run/current-system/sw/bin:/nix/var/nix/profiles/default/bin:$PATH"

# Colors/Formats
readonly NC='\033[0m'
readonly GREEN='\033[1;32m'
readonly YELLOW='\033[1;33m'
readonly RED='\033[0;31m'
readonly PURPLE='\033[1;35m'
readonly BOLD='\033[1;1m'

# Logging functions
log() { echo -e "${BOLD}${GREEN}[${NAME}]${NC} $*" >&2; }
warn() { echo -e "${BOLD}${YELLOW}[WARNING]${NC} $*" >&2; }
error() { echo -e "${BOLD}${RED}[ERROR]${NC} $*" >&2; }
die() { echo -e "${BOLD}${PURPLE}[FATAL]${NC} $*" >&2; exit 1; }

# Common rebuild function
rebuild_system() {
  local -r action=$1
  local -r old_gen=$(readlink -f /run/current-system)

  log "Starting action '$action'"

  # FEED IT PATH
  if ! run0 --background= --setenv=PATH="$PATH_DIRS" \
    nixos-rebuild "$action" \
    --flake "$DEFAULT_FLAKE#$HOSTNAME" \
    --log-format multiline-with-logs; then
    die "Failed to run action '$action'"
  fi

  local -r new_gen=$(readlink -f /run/current-system)
  log "Showing changes between generations..."
  if ! nvd diff "$old_gen" "$new_gen"; then
    warn "Failed to show generation diff"
  fi

  log "Action '$action' completed successfully"
}

# Rebuild and switch to config
run_switch() {
  rebuild_system "switch"
}

# Rebuild and add boot entry, but don't switch
run_boot() {
  rebuild_system "boot"
}

# Update flake.lock then rebuild & switch
run_upgrade() {
  log "Updating flake inputs..."
  if ! nix flake update --flake $DEFAULT_FLAKE; then
    die "Failed to update flake inputs"
  fi
  log "Flake updated successfully. Rebuilding system..."
  run_switch
}

# Remove old store links and rebuild & boot
run_clean() {
  log "Collecting garbage..."
  if ! run0 --background= --setenv=PATH="$PATH_DIRS" nix-collect-garbage -d; then
    die "Failed to collect garbage"
  fi
  log "Clean completed successfully. Rebuilding system..."
  run_boot
}
# Remove old store links and rebuild & boot
# Just show the help
show_help() {
  echo -e "${BOLD}${GREEN}${NAME}${NC} ${VERSION}
A simple bash NixOS rebuild tool using systemd's run0

Usage: ${GREEN}${CMDNAME}${NC} [OPTION]

${BOLD}Options${NC}:
  ${BOLD}${GREEN}boot${NC}      Rebuild and add a boot entry to a new configuration
  ${BOLD}${GREEN}switch${NC}    Rebuild and switch to a new configuration
  ${BOLD}${GREEN}upgrade${NC}   Update flake.lock and then runs '${CMDNAME} switch'
  ${BOLD}${GREEN}clean${NC}     Garbage collects the store then runs '${CMDNAME} boot'
  ${BOLD}${GREEN}help${NC}      Show this help message

Environment variables:
  FLAKE    Path to your NixOS flake (default: current directory)
"
}

# The main function
main() {
  case "${1:-help}" in
    switch|boot|upgrade|clean)
      # Intercept CTRL+C
      trap 'error "Script interrupted. Exiting."; exit 1' SIGINT
      "run_$1"
      ;;
    help|--help|-h)
      show_help
      ;;
    *)
      error "Unknown command: $1\n"
      show_help
      exit 1
      ;;
  esac
}

# Actually run the main function
main "$@"
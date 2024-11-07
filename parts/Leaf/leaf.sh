#!/usr/bin/env bash

# Aquire hostname
HOSTNAME=$(uname -n)

# Rebuild and switch to config
run_switch() {
  cd $(mktemp -d) &&
  nix build $FLAKE#nixosConfigurations.$HOSTNAME.config.system.build.toplevel  --log-format multiline-with-logs &&
  nvd diff /run/current-system result &&
  sudo result/bin/switch-to-configuration switch
}

# Rebuild and add boot entry, but don't switch
run_boot() {
  cd $(mktemp -d) &&
  nix build $FLAKE#nixosConfigurations.$HOSTNAME.config.system.build.toplevel  --log-format multiline-with-logs &&
  nvd diff /run/current-system result &&
  sudo result/bin/switch-to-configuration boot
}

# Update flake.lock then rebuild & switch
run_upgrade() {
  nix flake update --flake $FLAKE
  echo "Inputs updated. Rebuilding system..."
  run_switch
}

# Remove old store links and rebuild & boot
run_clean() {
  nix-collect-garbage -d
  echo "Clean done. Rebuilding system..."
  run_boot
}

trap 'echo "Script interrupted. Exiting."; exit 1' SIGINT
case "$1" in
    switch)
        run_switch
        ;;
    boot)
        run_boot
        ;;
    upgrade)
        run_upgrade
        ;;
    clean)
        run_clean
        ;;
    *)
        echo " Leaf v0.1.0

Usage: leaf [OPTION]

Options:
  switch    Rebuild and switch to a new configuration
  boot      Rebuild and add a boot entry to a new configuration
  upgrade   Update flake.lock and then runs 'leaf switch'
  clean     Garbage collects the store then runs 'leaf boot'
        "
        exit 1
        ;;
esac
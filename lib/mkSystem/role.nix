{ enum, mkOption, role, ... }:

{
  options.Mint.role = mkOption {
    type = enum [ "laptop" "desktop" "server" "iso" ];
    readOnly = true;
    default = role;
  };
}

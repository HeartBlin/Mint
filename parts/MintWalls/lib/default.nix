_:

let
  inherit (builtins) match;
  cond = x: "^[0-9A-Fa-f]{${x}}$";
in {
  flake.lib = {
    toHyprRGB = x:
      if match (cond "6") x != null then
        "rgb(${x})"
      else
        throw "Invalid color: x must be a 6-character hexadecimal string";

    toHyprRGBA = x: y:
      if match (cond "6") x != null && match (cond "2") y != null then
        "rgba(${x}${y})"
      else
        throw
        "Invalid color: x must be a 6-character hexadecimal string, and y must be a 2-character hexadecimal string";
  };
}

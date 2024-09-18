{ inputs }:

let inherit (inputs.nixpkgs.lib) mkIf mkMerge;
in { mkIfElse = x: y: n: mkMerge [ (mkIf x y) (mkIf (!x) n) ]; }

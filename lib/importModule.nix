{ self }:

{
  importModule = path: module: [
    "${self}/${path}/${module}/config.nix"
    "${self}/${path}/${module}/options.nix"
  ];
}

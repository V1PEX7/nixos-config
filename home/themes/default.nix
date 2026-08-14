# Every *.nix here is a theme; ./lib.nix defines the format.
# The active one is picked in ../settings.nix.
{ lib, settings, ... }:
let
  themeLib = import ./lib.nix { inherit lib; };

  themeFiles = lib.filterAttrs (
    file: kind:
    kind == "regular"
    && lib.hasSuffix ".nix" file
    && !(lib.elem file [
      "default.nix"
      "lib.nix"
    ])
  ) (builtins.readDir ./.);

  themes = lib.mapAttrs' (
    file: _:
    let
      name = lib.removeSuffix ".nix" file;
    in
    lib.nameValuePair name (themeLib.mkTheme name (import (./. + "/${file}")))
  ) themeFiles;

  known = lib.concatStringsSep ", " (lib.attrNames themes);
in
{
  _module.args = {
    theme =
      themes.${settings.theme} or (throw "unknown theme '${settings.theme}'; available: ${known}");
    inherit (themeLib) strip rgba;
  };
}

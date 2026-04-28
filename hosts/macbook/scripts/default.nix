{ pkgs, lib, ... }:
let
  scriptDir = ./.;

  # Pick up every .sh file in this directory, turn each into a
  # writeShellApplication named after the file (without the extension).
  # Runtime deps come from the user's PATH (e.g. git, glab, jq are
  # already installed via the terminal module).
  shellScripts = lib.filter (n: lib.hasSuffix ".sh" n) (
    lib.attrNames (lib.filterAttrs (_: t: t == "regular") (builtins.readDir scriptDir))
  );

  mkScript =
    file:
    pkgs.writeShellApplication {
      name = lib.removeSuffix ".sh" file;
      text = builtins.readFile (scriptDir + "/${file}");
    };
in
{
  home.packages = map mkScript shellScripts;
}

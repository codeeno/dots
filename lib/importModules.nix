dir:
let
  entries = builtins.readDir dir;
  subdirs = builtins.filter (name: entries.${name} == "directory") (builtins.attrNames entries);
  process = name:
    let subDir = dir + "/${name}"; in
    if builtins.pathExists (subDir + "/default.nix")
    then [ subDir ]             # leaf module found
    else importModules subDir;  # intermediate dir, recurse
  importModules = import ./importModules.nix;
in builtins.concatLists (map process subdirs)

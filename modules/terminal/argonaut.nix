{
  pkgs,
  ...
}:
let
  tomlFormat = pkgs.formats.toml { };
in
{
  home.packages = [ pkgs.argonaut ];

  xdg.configFile."argonaut/config.toml".source = tomlFormat.generate "argonaut-config.toml" {
    appearance = {
      theme = "tokyo-night";
    };

    sort = {
      field = "name";
      direction = "asc";
    };

    updates = {
      check_enabled = false;
    };

    default_view = "apps";
  };
}

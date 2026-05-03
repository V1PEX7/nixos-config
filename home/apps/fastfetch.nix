{ pkgs, ... }:
{
  home.packages = [ pkgs.fastfetch ];

  xdg.configFile."fastfetch/config.jsonc".text = builtins.toJSON {
    "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";

    display = {
      separator = ": ";
      color = {
        keys = "blue";
        title = "cyan";
      };
    };

    modules = [
      "title"
      {
        type = "custom";
        format = "───────────────────────────────";
        outputColor = "90";
      }
      { type = "os"; key = "OS"; }
      { type = "kernel"; key = "Kernel"; }
      { type = "uptime"; key = "Uptime"; }
      { type = "packages"; key = "Pkgs"; }
      {
        type = "custom";
        format = "───────────────────────────────";
        outputColor = "90";
      }
      { type = "shell"; key = "Shell"; }
      { type = "wm"; key = "WM"; }
      { type = "terminal"; key = "Term"; }
      {
        type = "custom";
        format = "───────────────────────────────";
        outputColor = "90";
      }
      {
        type = "cpu";
        key = "CPU";
        showPeCoreCount = false;
      }
      {
        type = "gpu";
        key = "GPU";
        hideType = "integrated";
      }
      { type = "memory"; key = "RAM"; }
      {
        type = "custom";
        format = "───────────────────────────────";
        outputColor = "90";
      }
      {
        type = "disk";
        key = "/";
        folders = "/";
      }
      "break"
      "colors"
    ];
  };
}

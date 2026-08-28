{ pkgs, ... }:
{
  settings = {
    theme = "rosepine"; # a file in ./themes

    terminal = "foot";
    terminalOpacity = "0.9";
    terminalPadding = 25;
    gtkTheme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 20;
    };

    font = {
      family = "JetBrains Mono Nerd Font";
      familyPropo = "JetBrainsMono Nerd Font Propo";
      size = 12;
    };

    workspaces = 9;

    rounding = 5;
    border_size = 2;
    blur = true;
    shadow = true;
    animations = true;

    gaps_in = 2;
    gaps_out = 4;
  };
}

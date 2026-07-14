{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.desktop;
in
{
  imports = [
    ./hyprland.nix
    ./niri.nix
  ];

  options.modules.desktop.enable = lib.mkEnableOption "Shared desktop environment";

  config = lib.mkIf cfg.enable {
    services.displayManager.enable = false;

    services.xserver.upscaleDefaultCursor = false;

    programs.dconf.enable = true;
    services.udisks2.enable = true;
    services.tumbler.enable = true;

    programs.thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-archive-plugin
        thunar-volman
        thunar-media-tags-plugin
      ];
    };

    qt.style = "adwaita-dark";

    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      dejavu_fonts
      corefonts
      liberation_ttf
      noto-fonts-cjk-sans
      inter
    ];

    environment.sessionVariables = {
      XCURSOR_PATH = [
        "$HOME/.icons"
        "$HOME/.local/share/icons"
        "/run/current-system/sw/share/icons"
      ];
      XCURSOR_THEME = "Bibata-Modern-Classic";
      XCURSOR_SIZE = "20";
      NIXOS_OZONE_WL = "1";
    };

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
      config.common.default = [
        "hyprland"
        "gtk"
      ];
    };

    environment.systemPackages = with pkgs; [
      ffmpegthumbnailer
      libgsf
      poppler
    ];
  };
}

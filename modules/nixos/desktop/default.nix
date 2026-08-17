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
  ];

  options.modules.desktop.enable = lib.mkEnableOption "Shared desktop environment";

  config = lib.mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings.default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-user-session --asterisks --cmd 'uwsm start hyprland-uwsm.desktop'";
        user = "greeter";
      };
    };

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

    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      dejavu_fonts
      liberation_ttf
      noto-fonts-cjk-sans
      inter
    ];

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

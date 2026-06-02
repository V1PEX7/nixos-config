{
  pkgs,
  lib,
  config,
  ...
}:
let
  mkSandbox = import ../lib/mkSandbox.nix { inherit pkgs lib; };
  home = config.home.homeDirectory;

  vesktop = mkSandbox {
    name = "vesktop";
    package = pkgs.vesktop;
    preset = "gui-av";
    network = true;
    rwPaths = [
      "${home}/.config/vesktop"
      "${home}/.config/Vencord"
      "${home}/Downloads"
    ];
  };

  # discord = mkSandbox {
  #   name = "discord";
  #   package = pkgs.discord.override {
  #     withVencord = true;
  #     withOpenASAR = true;
  #   };
  #   binPath = "bin/Discord";
  #   preset = "gui-av";
  #   network = true;
  #   rwPaths = [
  #     "${home}/.config/discord"
  #     "${home}/.config/Vencord"
  #     "${home}/Downloads"
  #   ];
  # };

  telegram = mkSandbox {
    name = "telegram-desktop";
    package = pkgs.telegram-desktop;
    binPath = "bin/Telegram";
    preset = "gui-av";
    network = true;
    rwPaths = [
      "${home}/.local/share/TelegramDesktop"
      "${home}/.cache/TelegramDesktop"
      "${home}/Downloads"
    ];
  };

  qbittorrent = mkSandbox {
    name = "qbittorrent";
    package = pkgs.qbittorrent;
    preset = "gui";
    network = true;
    rwPaths = [
      "${home}/.config/qBittorrent"
      "${home}/.local/share/qBittorrent"
      "${home}/Downloads"
    ];
  };
in
{
  home.packages = [
    vesktop
    #discord
    telegram
    qbittorrent
  ];
}

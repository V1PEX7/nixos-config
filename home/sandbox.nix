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
    rwPaths = [
      "${home}/.config/vesktop"
      "${home}/.config/Vencord"
      "${home}/Downloads"
    ];
  };

  discord = mkSandbox {
    name = "discord";
    package = pkgs.discord.override {
      withVencord = true;
      withOpenASAR = true;
    };
    binPath = "bin/Discord";
    rwPaths = [
      "${home}/.config/discord"
      "${home}/.config/Vencord"
      "${home}/Downloads"
    ];
  };

  telegram = mkSandbox {
    name = "telegram-desktop";
    package = pkgs.telegram-desktop;
    binPath = "bin/Telegram";
    rwPaths = [
      "${home}/.local/share/TelegramDesktop"
      "${home}/.cache/TelegramDesktop"
      "${home}/Downloads"
    ];
  };

  obsidian = mkSandbox {
    name = "obsidian";
    package = pkgs.obsidian;
    rwPaths = [
      "${home}/.config/obsidian"
      "${home}/Documents/Obsidian"
    ];
  };

  qbittorrent = mkSandbox {
    name = "qbittorrent";
    package = pkgs.qbittorrent;
    rwPaths = [
      "${home}/.config/qBittorrent"
      "${home}/.local/share/qBittorrent"
      "${home}/Downloads"
    ];
    roPaths = [
      "${home}/.config/gtk-3.0"
      "${home}/.config/gtk-4.0"
      "${home}/.config/dconf"
    ];
  };
in
{
  home.packages = [
    vesktop
    discord
    telegram
    obsidian
    qbittorrent
  ];
}

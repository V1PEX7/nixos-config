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

  codeShell = mkSandbox {
    name = "code-shell";
    package = pkgs.zsh;
    binPath = "bin/zsh";
    preset = "cli";
    network = true;
    rwPaths = [ "${home}/Code" ];
    roPaths = [
      "${home}/.zshrc"
      "${home}/.zshenv"
      "${home}/.zprofile"
    ];
    extraArgs = [
      "--setenv PATH ${pkgs.nodejs}/bin:/run/current-system/sw/bin"
      "--setenv IN_CODE_SHELL 1"
      ''--chdir "${home}/Code"''
    ];
  };
in
{
  home.packages = [
    vesktop
    #discord
    telegram
    qbittorrent
    codeShell
  ];
}

{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}:
let
  mkSandbox = import ../lib/mkSandbox.nix { inherit pkgs lib; };
  home = config.home.homeDirectory;
  gamingEnabled = osConfig.modules.apps.gaming.enable;

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
  #

  steam = mkSandbox {
    name = "steam";
    package = pkgs.steam.override {
      extraLibraries = pkgs: with osConfig.hardware.graphics; [ package ] ++ extraPackages;
    };
    preset = "gui-av";
    network = true;

    rwPaths = [
      "${home}/.steam"
      "${home}/.local/share/Steam"
      "${home}/.config/unity3d"
    ];

    roPaths = [
      "${home}/.local/share/applications"
      "${home}/.config/mimeapps.list"
    ];

    extraArgs = [
      "--dev-bind /dev/input /dev/input"
      "--ro-bind-try /run/udev /run/udev"
      "--ro-bind-try /tmp/.X11-unix /tmp/.X11-unix"
    ];
  };

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
    workdirArg = "${home}/Code";
    roPaths = [
      "${home}/.zshrc"
      "${home}/.zshenv"
      "${home}/.zprofile"
    ];
    extraArgs = [
      "--setenv PATH ${pkgs.nodejs}/bin:/run/current-system/sw/bin"
      "--setenv IN_CODE_SHELL 1"
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
  ]
  ++ lib.optional gamingEnabled steam;
}

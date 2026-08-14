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

  # Common DBus permissions for applications that show tray icons and prevent sleep
  commonGuiDbusTalk = [
    "org.freedesktop.StatusNotifierWatcher"
    "org.kde.StatusNotifierWatcher"
    "org.freedesktop.ScreenSaver"
    "org.freedesktop.PowerManagement"
  ];

  commonGuiDbusOwn = [
    "org.kde.StatusNotifierItem.*"
    "org.ayatana.NotificationItem.*"
  ];

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
    extraDbusTalk = commonGuiDbusTalk;
    extraDbusOwn = commonGuiDbusOwn;
  };

  steam = mkSandbox {
    name = "steam";
    package = pkgs.steam.override {
      extraPkgs =
        pkgs: with pkgs; [
          ffmpeg
        ];
    };
    preset = "gui-av";
    network = true;
    dbusSystem = true;
    dbusSystemTalk = [
      "org.freedesktop.UPower"
      "org.freedesktop.UPower.*"
      "org.freedesktop.login1"
      "org.freedesktop.NetworkManager"
      "org.freedesktop.UDisks2"
    ];

    rwPaths = [
      "${home}/.steam"
      "${home}/.local/share/Steam"
      "${home}/.config/unity3d"
    ];

    roPaths = [
      "${home}/.local/share/applications"
      "${home}/.config/mimeapps.list"
    ];

    extraDbusTalk = commonGuiDbusTalk;
    extraDbusOwn = commonGuiDbusOwn ++ [
      "com.steampowered.*"
    ];

    extraArgs = [
      "--dev-bind /dev/input /dev/input"
      "--ro-bind-try /run/udev /run/udev"
      "--ro-bind-try /tmp/.X11-unix /tmp/.X11-unix"
      "--ro-bind-try /run/systemd/resolve /run/systemd/resolve"
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
    extraDbusTalk = commonGuiDbusTalk;
    extraDbusOwn = commonGuiDbusOwn ++ [
      "org.telegram.desktop.*"
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
    extraDbusTalk = commonGuiDbusTalk;
    extraDbusOwn = commonGuiDbusOwn ++ [
      "org.qbittorrent.*"
    ];
  };

  claude = mkSandbox {
    name = "claude";
    package = pkgs.claude-code;
    preset = "cli";
    network = true;
    nix = true;
    bindCwd = true;
    newSession = false;
    rwPaths = [ "${home}/.claude" ];
    roPaths = [
      "${home}/.gitconfig"
      "/etc/profiles"
    ];
    extraArgs = [
      ''--bind-try "$HOME/.claude.json" "$HOME/.claude.json"''
      "--setenv PATH ${pkgs.nodejs}/bin:/etc/profiles/per-user/${config.home.username}/bin:/run/current-system/sw/bin"
    ];
  };

  codeShell = mkSandbox {
    name = "code-shell";
    package = pkgs.zsh;
    binPath = "bin/zsh";
    preset = "cli";
    network = true;
    nix = true;
    newSession = false;
    bindCwd = true;
    rwPaths = [ "${home}/.cache/nix" ];
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
    telegram
    qbittorrent
    claude
    codeShell
  ]
  ++ lib.optional gamingEnabled steam;
}

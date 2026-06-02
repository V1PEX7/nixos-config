{
  pkgs,
  lib,
}:

{
  name,
  package,
  binPath ? "bin/${name}",

  # Capability preset. Deny-by-default: a preset grants a bundle of capabilities
  # cli       - no display/audio/bus (headless)
  # gui       - wayland + gpu + theme + session bus
  # gui-audio - gui + pulse
  # gui-av    - gui + pulse + pipewire (calls, screen-share media)
  preset ? "gui",

  rwPaths ? [ ],
  roPaths ? [ ],
  extraArgs ? [ ],

  # Per-capability overrides. null inherits the preset
  network ? null,
  gpu ? null,
  wayland ? null,
  pipewire ? null,
  pulse ? null,
  dbusSession ? null,
  dbusSystem ? null,
  theme ? null,

  unsetVars ? [
    "SSH_AUTH_SOCK"
    "SSH_AGENT_PID"
    "GPG_AGENT_INFO"
    "GNUPGHOME"
    "PASSWORD_STORE_DIR"
  ],
}:

let
  bwrap = "${pkgs.bubblewrap}/bin/bwrap";

  guiCaps = {
    wayland = true;
    gpu = true;
    theme = true;
    dbusSession = true;
  };
  presets = {
    cli = { };
    gui = guiCaps;
    gui-audio = guiCaps // {
      pulse = true;
    };
    gui-av = guiCaps // {
      pulse = true;
      pipewire = true;
    };
  };

  baseCaps = {
    network = false;
    gpu = false;
    wayland = false;
    pipewire = false;
    pulse = false;
    dbusSession = false;
    dbusSystem = false;
    theme = false;
  };

  presetCaps = presets.${preset} or (throw ''mkSandbox: unknown preset "${preset}"'');

  overrides = lib.filterAttrs (_: v: v != null) {
    inherit
      network
      gpu
      wayland
      pipewire
      pulse
      dbusSession
      dbusSystem
      theme
      ;
  };

  caps = baseCaps // presetCaps // overrides;

  baseArgs = [
    "--unshare-all"
  ]
  ++ lib.optional caps.network "--share-net"
  ++ [
    "--die-with-parent"
    "--new-session"

    "--ro-bind /nix/store /nix/store"
    "--ro-bind /run/current-system /run/current-system"
    "--ro-bind /etc/static /etc/static"
    "--ro-bind /etc/resolv.conf /etc/resolv.conf"
    "--ro-bind /etc/nsswitch.conf /etc/nsswitch.conf"
    "--ro-bind /etc/hosts /etc/hosts"
    "--ro-bind /etc/ssl /etc/ssl"
    "--ro-bind /etc/fonts /etc/fonts"
    "--ro-bind-try /etc/passwd /etc/passwd"
    "--ro-bind-try /etc/group /etc/group"
    "--ro-bind-try /etc/machine-id /etc/machine-id"
    "--ro-bind-try /etc/localtime /etc/localtime"

    "--proc /proc"
    "--dev /dev"
    "--tmpfs /tmp"
  ]
  ++ lib.optionals caps.gpu [
    "--dev-bind /dev/dri /dev/dri"
    "--ro-bind-try /run/opengl-driver /run/opengl-driver"
    "--ro-bind-try /run/opengl-driver-32 /run/opengl-driver-32"
    "--ro-bind-try /sys/dev /sys/dev"
    "--ro-bind-try /sys/devices /sys/devices"
  ];

  homeArgs = [
    ''--tmpfs "$HOME"''
    ''--tmpfs "$XDG_RUNTIME_DIR"''
    ''--chdir "$HOME"''
  ];

  themeArgs = lib.optionals caps.theme [
    "--ro-bind-try /etc/profiles /etc/profiles"
    ''--ro-bind-try "$HOME/.config/gtk-3.0" "$HOME/.config/gtk-3.0"''
    ''--ro-bind-try "$HOME/.config/gtk-4.0" "$HOME/.config/gtk-4.0"''
    ''--ro-bind-try "$HOME/.config/dconf" "$HOME/.config/dconf"''
    ''--ro-bind-try "$HOME/.config/qt5ct" "$HOME/.config/qt5ct"''
    ''--ro-bind-try "$HOME/.config/qt6ct" "$HOME/.config/qt6ct"''
    ''--ro-bind-try "$HOME/.config/kdeglobals" "$HOME/.config/kdeglobals"''
    ''--ro-bind-try "$HOME/.gtkrc-2.0" "$HOME/.gtkrc-2.0"''
    ''--ro-bind-try "$HOME/.icons" "$HOME/.icons"''
    ''--ro-bind-try "$HOME/.local/share/icons" "$HOME/.local/share/icons"''
    ''--ro-bind-try "$HOME/.themes" "$HOME/.themes"''
    ''--ro-bind-try "$HOME/.local/share/themes" "$HOME/.local/share/themes"''
  ];

  bindRw = path: ''--bind-try "${path}" "${path}"'';
  bindRo = path: ''--ro-bind-try "${path}" "${path}"'';
  rwArgs = map bindRw rwPaths;
  roArgs = map bindRo roPaths;

  runtimeArgs =
    lib.optionals caps.wayland [
      ''--bind-try "$XDG_RUNTIME_DIR/wayland-0" "$XDG_RUNTIME_DIR/wayland-0"''
      ''--bind-try "$XDG_RUNTIME_DIR/wayland-1" "$XDG_RUNTIME_DIR/wayland-1"''
    ]
    ++ lib.optionals caps.pipewire [
      ''--bind-try "$XDG_RUNTIME_DIR/pipewire-0" "$XDG_RUNTIME_DIR/pipewire-0"''
      ''--bind-try "$XDG_RUNTIME_DIR/pipewire-0-manager" "$XDG_RUNTIME_DIR/pipewire-0-manager"''
    ]
    ++ lib.optionals caps.pulse [
      ''--bind-try "$XDG_RUNTIME_DIR/pulse" "$XDG_RUNTIME_DIR/pulse"''
    ]
    ++ lib.optionals caps.dbusSession [
      ''--bind-try "$XDG_RUNTIME_DIR/bus" "$XDG_RUNTIME_DIR/bus"''
    ]
    ++ lib.optionals caps.dbusSystem [
      "--ro-bind-try /run/dbus/system_bus_socket /run/dbus/system_bus_socket"
    ];

  unsetArgs = map (v: "--unsetenv ${v}") unsetVars;

  allArgs =
    baseArgs ++ homeArgs ++ themeArgs ++ rwArgs ++ roArgs ++ runtimeArgs ++ unsetArgs ++ extraArgs;
  argsLines = lib.concatStringsSep " \\\n  " allArgs;

  rwPathsBash = lib.concatMapStringsSep " " (p: ''"${p}"'') rwPaths;

  script = ''
    #!${pkgs.runtimeShell}
    set -eu
    : "''${XDG_RUNTIME_DIR:=/run/user/$(${pkgs.coreutils}/bin/id -u)}"
    export PATH=/run/current-system/sw/bin

    for d in ${rwPathsBash}; do
      ${pkgs.coreutils}/bin/mkdir -p "$d"
    done

    exec ${bwrap} \
      ${argsLines} \
      -- ${package}/${binPath} "$@"
  '';

  wrapper = pkgs.writeShellScript "${name}-sandboxed" script;
in
pkgs.runCommand "${name}-sandboxed-${package.version or "0"}"
  {
    meta = (package.meta or { }) // {
      mainProgram = name;
      description = "${name} (sandboxed via bubblewrap)";
    };
  }
  ''
    mkdir -p $out/bin
    install -m755 ${wrapper} $out/bin/${name}

    if [ -d ${package}/share ]; then
      mkdir -p $out/share

      for d in ${package}/share/*; do
        bn=$(${pkgs.coreutils}/bin/basename "$d")
        if [ "$bn" != "applications" ]; then
          ${pkgs.coreutils}/bin/cp -r "$d" $out/share/
        fi
      done

      if [ -d ${package}/share/applications ]; then
        mkdir -p $out/share/applications
        for desktop in ${package}/share/applications/*.desktop; do
          bn=$(${pkgs.coreutils}/bin/basename "$desktop")
          ${pkgs.gnused}/bin/sed -E \
            -e "s|^Exec=[^\n]*|Exec=$out/bin/${name} %U|" \
            -e "s|^TryExec=.*|TryExec=$out/bin/${name}|" \
            "$desktop" > $out/share/applications/$bn
        done
      fi
    fi
  ''

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

  workdirArg ? null,
  bindCwd ? false,
  newSession ? true,

  # Per-capability overrides. null inherits the preset
  network ? null,
  gpu ? null,
  wayland ? null,
  pipewire ? null,
  pulse ? null,
  dbusSession ? null,
  dbusSystem ? null,
  theme ? null,

  dbusProxy ? true,
  defaultDbusTalk ? [
    "org.freedesktop.Notifications"
    "org.freedesktop.portal.*"
    "ca.desrt.dconf"
  ],
  extraDbusTalk ? [ ],
  dbusTalk ? defaultDbusTalk ++ extraDbusTalk,
  dbusSee ? [ ],
  defaultDbusOwn ? [
    "org.mpris.MediaPlayer2.*"
  ],
  extraDbusOwn ? [ ],
  dbusOwn ? defaultDbusOwn ++ extraDbusOwn,
  dbusCall ? [ ],

  dbusSystemProxy ? true,
  dbusSystemTalk ? [ ],
  dbusSystemSee ? [ ],
  dbusSystemOwn ? [ ],
  dbusSystemCall ? [ ],

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
  xdgDbusProxy = "${pkgs.xdg-dbus-proxy}/bin/xdg-dbus-proxy";

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

  dbusFlags =
    (map (x: "--talk=${x}") dbusTalk)
    ++ (map (x: "--see=${x}") dbusSee)
    ++ (map (x: "--own=${x}") dbusOwn)
    ++ (map (x: "--call=${x}") dbusCall);

  # escapeShellArgs prevents shell globbing on DBus wildcards (e.g. portal.*) during proxy launch.
  dbusFlagsStr = lib.escapeShellArgs dbusFlags;
  useDbusProxy = caps.dbusSession && dbusProxy;

  dbusSystemFlags =
    (map (x: "--talk=${x}") dbusSystemTalk)
    ++ (map (x: "--see=${x}") dbusSystemSee)
    ++ (map (x: "--own=${x}") dbusSystemOwn)
    ++ (map (x: "--call=${x}") dbusSystemCall);

  dbusSystemFlagsStr = lib.escapeShellArgs dbusSystemFlags;
  useDbusSystemProxy = caps.dbusSystem && dbusSystemProxy;

  baseArgs = [
    "--unshare-all"
    "--die-with-parent"
  ]
  ++ lib.optional newSession "--new-session"
  ++ [
    "--symlink /run /var/run" # Allows legacy DBus system socket lookups
  ]
  ++ lib.optional caps.network "--share-net"
  ++ [
    "--ro-bind /nix/store /nix/store"
    "--ro-bind /run/current-system /run/current-system"
    "--ro-bind-try /usr/bin/env /usr/bin/env"
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
  ]
  ++ lib.optional (workdirArg == null && !bindCwd) ''--chdir "$HOME"'';

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
    ++ lib.optionals useDbusProxy [
      ''--bind-try "$PROXY_BUS" "$XDG_RUNTIME_DIR/bus"''
      ''--setenv DBUS_SESSION_BUS_ADDRESS "unix:path=$XDG_RUNTIME_DIR/bus"''
    ]
    ++ lib.optionals (caps.dbusSession && !useDbusProxy) [
      ''--bind-try "$XDG_RUNTIME_DIR/bus" "$XDG_RUNTIME_DIR/bus"''
      ''--setenv DBUS_SESSION_BUS_ADDRESS "unix:path=$XDG_RUNTIME_DIR/bus"''
    ]
    ++ lib.optionals useDbusSystemProxy [
      ''--bind-try "$PROXY_SYS_BUS" /run/dbus/system_bus_socket''
      ''--setenv DBUS_SYSTEM_BUS_ADDRESS "unix:path=/run/dbus/system_bus_socket"''
    ]
    ++ lib.optionals (caps.dbusSystem && !useDbusSystemProxy) [
      "--ro-bind-try /run/dbus/system_bus_socket /run/dbus/system_bus_socket"
      ''--setenv DBUS_SYSTEM_BUS_ADDRESS "unix:path=/run/dbus/system_bus_socket"''
    ];

  unsetArgs = map (v: "--unsetenv ${v}") unsetVars;

  workdirArgs = lib.optionals (workdirArg != null || bindCwd) [
    ''--bind-try "$WORKDIR" "$WORKDIR"''
    ''--chdir "$WORKDIR"''
  ];

  allArgs =
    baseArgs
    ++ homeArgs
    ++ themeArgs
    ++ rwArgs
    ++ roArgs
    ++ runtimeArgs
    ++ unsetArgs
    ++ workdirArgs
    ++ extraArgs;
  argsLines = lib.concatStringsSep " \\\n  " allArgs;
  rwPathsBash = lib.concatMapStringsSep " " (p: ''"${p}"'') rwPaths;

  waitForSocketFn = ''
    wait_for_socket() {
      local socket_path="$1"
      local bus_name="$2"
      local proxy_pid="$3"
      for i in $(${pkgs.coreutils}/bin/seq 1 200); do
        [ -S "$socket_path" ] && return 0
        if [ -n "$proxy_pid" ] && ! kill -0 "$proxy_pid" 2>/dev/null; then
          echo "error: $bus_name proxy process ($proxy_pid) exited prematurely" >&2
          return 1
        fi
        sleep 0.01
      done
      echo "warning: $bus_name proxy socket missing after 2s ($socket_path)" >&2
      return 1
    }
  '';

  script = ''
    #!${pkgs.runtimeShell}
    set -eu
    : "''${XDG_RUNTIME_DIR:=/run/user/$(${pkgs.coreutils}/bin/id -u)}"
    export PATH=/run/current-system/sw/bin

    for d in ${rwPathsBash}; do
      ${pkgs.coreutils}/bin/mkdir -p "$d"
    done

    ${lib.optionalString (workdirArg != null) ''
      WORKDIR="''${1:-${workdirArg}}"
      [ "$#" -gt 0 ] && shift || true
      WORKDIR="$(${pkgs.coreutils}/bin/realpath -m "$WORKDIR")"
      ${pkgs.coreutils}/bin/mkdir -p "$WORKDIR"
    ''}

    ${lib.optionalString bindCwd ''
      WORKDIR="$(${pkgs.coreutils}/bin/realpath -m "$PWD")"
      case "$WORKDIR" in
        "$HOME"|"$HOME"/) echo "${name}: run from a project directory under $HOME" >&2; exit 1 ;;
      esac
    ''}

    ${lib.optionalString (useDbusProxy || useDbusSystemProxy) waitForSocketFn}

    # bwrap --bind-try fails on empty strings. Dummy absolute paths ensure safe fallback
    PROXY_BUS="/run/sandbox-no-session-bus-$$"
    PROXY_SYS_BUS="/run/sandbox-no-system-bus-$$"
    SESSION_PROXY_DIR=""
    SYSTEM_PROXY_DIR=""
    SESSION_PROXY_PID=""
    SYSTEM_PROXY_PID=""
    BWRAP_PID=""

    cleanup() {
      trap - EXIT INT TERM

      if [ -n "$BWRAP_PID" ] && kill -0 "$BWRAP_PID" 2>/dev/null; then
        kill -TERM "$BWRAP_PID" 2>/dev/null || true
        wait "$BWRAP_PID" 2>/dev/null || true
      fi

      [ -n "$SESSION_PROXY_PID" ] && kill -TERM "$SESSION_PROXY_PID" 2>/dev/null || true
      [ -n "$SYSTEM_PROXY_PID" ] && kill -TERM "$SYSTEM_PROXY_PID" 2>/dev/null || true
      wait 2>/dev/null || true

      [ -n "$SESSION_PROXY_DIR" ] && [ -d "$SESSION_PROXY_DIR" ] && ${pkgs.coreutils}/bin/rm -rf "$SESSION_PROXY_DIR"
      [ -n "$SYSTEM_PROXY_DIR" ] && [ -d "$SYSTEM_PROXY_DIR" ] && ${pkgs.coreutils}/bin/rm -rf "$SYSTEM_PROXY_DIR"

      return 0
    }
    trap cleanup EXIT INT TERM

    ${lib.optionalString useDbusProxy ''
      SESSION_BUS="''${DBUS_SESSION_BUS_ADDRESS:-unix:path=$XDG_RUNTIME_DIR/bus}"

      if [ -S "$XDG_RUNTIME_DIR/bus" ] || [ -n "''${DBUS_SESSION_BUS_ADDRESS:-}" ]; then
        SESSION_PROXY_DIR="$(${pkgs.coreutils}/bin/mktemp -d -t sandbox-dbus-session-XXXXXX)"
        PROXY_BUS="$SESSION_PROXY_DIR/bus"

        ${xdgDbusProxy} "$SESSION_BUS" "$PROXY_BUS" --filter ${dbusFlagsStr} &
        SESSION_PROXY_PID=$!

        wait_for_socket "$PROXY_BUS" "session bus" "$SESSION_PROXY_PID" || true
      fi
    ''}

    ${lib.optionalString useDbusSystemProxy ''
      if [ -S /run/dbus/system_bus_socket ]; then
        SYSTEM_PROXY_DIR="$(${pkgs.coreutils}/bin/mktemp -d -t sandbox-dbus-system-XXXXXX)"
        PROXY_SYS_BUS="$SYSTEM_PROXY_DIR/bus"

        ${xdgDbusProxy} "unix:path=/run/dbus/system_bus_socket" "$PROXY_SYS_BUS" --filter ${dbusSystemFlagsStr} &
        SYSTEM_PROXY_PID=$!

        wait_for_socket "$PROXY_SYS_BUS" "system bus" "$SYSTEM_PROXY_PID" || true
      fi
    ''}

    exec 3<&0
    ${bwrap} \
      ${argsLines} \
      -- ${package}/${binPath} "$@" <&3 3<&- &
    BWRAP_PID=$!

    status=0
    wait "$BWRAP_PID" || status=$?
    BWRAP_PID=""
    exit "$status"
  '';

  wrapper = pkgs.writeShellScript "${name}-sandboxed" script;
in
pkgs.runCommand "${name}-sandboxed-${package.version or "0"}"
  {
    meta = (package.meta or { }) // {
      mainProgram = name;
      description = "${name} (sandboxed via bubblewrap)";
      outputsToInstall = [ "out" ];
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

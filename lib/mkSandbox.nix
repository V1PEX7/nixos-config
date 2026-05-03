{
  pkgs,
  lib,
}:

{
  name,
  package,
  binPath ? "bin/${name}",
  rwPaths ? [ ],
  roPaths ? [ ],
  extraArgs ? [ ],
  network ? true,
  gpu ? true,
  wayland ? true,
  pipewire ? true,
  pulse ? true,
  dbusSession ? true,
  dbusSystem ? false,
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

  baseArgs = [
    "--unshare-all"
  ]
  ++ lib.optional network "--share-net"
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
  ++ lib.optionals gpu [
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

  bindRw = path: ''--bind-try "${path}" "${path}"'';
  bindRo = path: ''--ro-bind-try "${path}" "${path}"'';
  rwArgs = map bindRw rwPaths;
  roArgs = map bindRo roPaths;

  runtimeArgs =
    lib.optionals wayland [
      ''--bind-try "$XDG_RUNTIME_DIR/wayland-0" "$XDG_RUNTIME_DIR/wayland-0"''
      ''--bind-try "$XDG_RUNTIME_DIR/wayland-1" "$XDG_RUNTIME_DIR/wayland-1"''
    ]
    ++ lib.optionals pipewire [
      ''--bind-try "$XDG_RUNTIME_DIR/pipewire-0" "$XDG_RUNTIME_DIR/pipewire-0"''
      ''--bind-try "$XDG_RUNTIME_DIR/pipewire-0-manager" "$XDG_RUNTIME_DIR/pipewire-0-manager"''
    ]
    ++ lib.optionals pulse [
      ''--bind-try "$XDG_RUNTIME_DIR/pulse" "$XDG_RUNTIME_DIR/pulse"''
    ]
    ++ lib.optionals dbusSession [
      ''--bind-try "$XDG_RUNTIME_DIR/bus" "$XDG_RUNTIME_DIR/bus"''
    ]
    ++ lib.optionals dbusSystem [
      "--ro-bind-try /run/dbus/system_bus_socket /run/dbus/system_bus_socket"
    ];

  unsetArgs = map (v: "--unsetenv ${v}") unsetVars;

  allArgs = baseArgs ++ homeArgs ++ rwArgs ++ roArgs ++ runtimeArgs ++ unsetArgs ++ extraArgs;
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

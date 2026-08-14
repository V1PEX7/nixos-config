{ pkgs }:

pkgs.runCommandCC "wl-security-context"
  {
    nativeBuildInputs = with pkgs; [
      wayland-scanner
      pkg-config
    ];
    buildInputs = [ pkgs.wayland ];
  }
  ''
    xml=${pkgs.wayland-protocols}/share/wayland-protocols/staging/security-context/security-context-v1.xml
    wayland-scanner client-header "$xml" security-context-v1-client-protocol.h
    wayland-scanner private-code "$xml" security-context-v1-protocol.c

    mkdir -p $out/bin
    $CC -O2 -I. -o $out/bin/wl-security-context \
      ${./wl-security-context.c} security-context-v1-protocol.c \
      $(pkg-config --cflags --libs wayland-client)
  ''

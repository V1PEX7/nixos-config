{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (python3.withPackages (
      ps: with ps; [
        pyyaml
      ]
    ))
    uv

    ffmpeg
    yt-dlp

    ncdu
    btop
    nix-tree

    ripgrep
    fd

    pavucontrol

    xarchiver

    keepassxc

    swayimg
    mpv

    brightnessctl

    wl-clipboard
    wl-clip-persist
    playerctl
    grim
    slurp
    satty
    swaybg
    wlr-randr
    wayfreeze
    (tesseract5.override {
      enableLanguages = [
        "eng"
        "rus"
      ];
    })
    imagemagick

    xdg-desktop-portal-gtk
  ];
}

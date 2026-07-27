{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zed-editor
    nixd
    nil
    nixfmt

    (python3.withPackages (
      ps: with ps; [
        pyyaml
      ]
    ))
    uv
    neovim

    ffmpeg
    yt-dlp

    ncdu
    htop
    btop
    nix-tree

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

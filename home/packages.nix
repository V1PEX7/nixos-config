{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ungoogled-chromium

    zed-editor
    nixd
    nil
    nixfmt

    (python3.withPackages (ps: with ps; [
      pyyaml
    ]))
    uv
    neovim
    claude-code

    ffmpeg

    ncdu
    htop
    btop
    pavucontrol
    file-roller

    keepassxc

    swayimg
    mpv

    brightnessctl

    wl-clipboard
    wl-clip-persist
    cliphist
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

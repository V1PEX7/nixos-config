{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ungoogled-chromium

    zed-editor
    nixd
    nil
    nixfmt

    python3
    uv
    neovim

    ncdu
    btop
    pavucontrol
    file-roller

    keepassxc

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
    tesseract
    imagemagick
  ];
}

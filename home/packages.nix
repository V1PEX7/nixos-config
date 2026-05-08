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
    vim

    ncdu
    btop
    pavucontrol
    file-roller

    keepassx2c

    vlc
    (mpv.override {
      scripts = with pkgs.mpvScripts; [
        sponsorblock
        uosc
        thumbfast
      ];
    })
    obs-studio

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

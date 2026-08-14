{ ... }:
{
  imports = [
    ./themes
    ./settings.nix
    ./common.nix
    ./packages.nix
    ./scripts.nix
    ./sandbox.nix
    ./desktop/hyprland.nix
    ./desktop/hyprlock.nix
    ./desktop/hypridle.nix
    ./apps/foot.nix
    ./apps/waybar.nix
    ./apps/fastfetch.nix
    ./apps/firefox.nix
    ./apps/rmpc.nix
    ./apps/zsh.nix
    ./apps/yazi.nix
    ./apps/matugen.nix
    ./apps/rofi.nix
    ./apps/mime.nix
  ];

  home.username = "xnp";
  home.homeDirectory = "/home/xnp";
  home.stateVersion = "25.11";
}

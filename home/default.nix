{ username, ... }:
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
    ./desktop/wayland-restricted.nix
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

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.11";
}

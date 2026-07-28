{ ... }:
{
  imports = [
    ./theme.nix
    ./common.nix
    ./packages.nix
    ./scripts.nix
    ./sandbox.nix
    ./desktop/hyprland.nix
    ./apps/foot.nix
    ./apps/fuzzel.nix
    ./apps/waybar.nix
    ./apps/fastfetch.nix
    ./apps/firefox.nix
    ./apps/rmpc.nix
    ./apps/zsh.nix
    ./apps/yazi.nix
    ./apps/chromium.nix
    ./apps/matugen.nix
  ];

  home.username = "xnp";
  home.homeDirectory = "/home/xnp";
  home.stateVersion = "25.11";
}

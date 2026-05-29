{ ... }:
{
  imports = [
    ./common.nix
    ./packages.nix
    ./scripts.nix
    ./sandbox.nix
    ./desktop/mangowc.nix
    ./apps/foot.nix
    ./apps/fuzzel.nix
    ./apps/waybar.nix
    ./apps/fastfetch.nix
    ./apps/librewolf.nix
    ./apps/rmpc.nix
    ./apps/zsh.nix
    ./apps/yazi.nix
  ];

  home.username = "xnp";
  home.homeDirectory = "/home/xnp";
  home.stateVersion = "25.11";
}

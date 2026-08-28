{ username, ... }:
{
  imports = [
    ./themes
    ./options.nix
    ./settings.nix
    ./common.nix
    ./env.nix
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
    ./apps/mako.nix
    ./apps/mime.nix
    ./apps/neovim.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "26.11";
}

{ repoPath, ... }:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };

  programs.nh = {
    enable = true;
    flake = repoPath;
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 5";
    };
  };
}

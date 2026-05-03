{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    autosuggestion = {
      enable = true;
      strategy = [
        "history"
        "completion"
      ];
    };
    syntaxHighlighting.enable = true;

    history = {
      ignoreAllDups = true;
      share = true;
    };

    completionInit = ''
      autoload -U compinit && compinit
      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
    '';

    shellAliases = {
      rebuild-laptop = "doas nixos-rebuild switch --flake ~/nixos-config#laptop";
      rebuild-desktop = "doas nixos-rebuild switch --flake ~/nixos-config#desktop";
      gc = "doas nix-collect-garbage -d && doas nix profile wipe-history --profile /nix/var/nix/profiles/system";
      flake-update = "cd ~/nixos-config && nix flake update && cd -";
    };

    initContent = ''
      PROMPT='%F{green}➜ %F{cyan}%~%f '

      source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down

      bindkey ';5C' forward-word
      bindkey ';5D' backward-word
      bindkey '^H' backward-kill-word
      bindkey '^[[3;5~' kill-word
      bindkey '^[[H' beginning-of-line
      bindkey '^[[F' end-of-line
      bindkey '^Z' undo
      bindkey '^[.' insert-last-word
    '';
  };

  programs.zsh.profileExtra = ''
    if [ -z "$WAYLAND_DISPLAY" ] && [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
      exec mango
    fi
  '';

  programs.carapace = {
    enable = true;
    enableZshIntegration = true;
  };
}

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

    };

    initContent = ''
      if [[ -n "$IN_CODE_SHELL" ]]; then
        _shell_tag='%F{red}(code-shell)%f '
      elif [[ -n "$IN_NIX_SHELL" ]]; then
        _shell_tag='%F{yellow}(nix-shell)%f '
      else
        _shell_tag=""
      fi
      PROMPT="''${_shell_tag}%F{green}➜ %F{cyan}%~%f "

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
      exec niri-session
    fi
  '';

  programs.carapace = {
    enable = true;
    enableZshIntegration = true;
  };
}

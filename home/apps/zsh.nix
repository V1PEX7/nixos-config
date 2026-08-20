{ ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    defaultKeymap = "emacs";

    autosuggestion = {
      enable = true;
      strategy = [
        "history"
        "completion"
      ];
    };
    syntaxHighlighting.enable = true;

    historySubstringSearch = {
      enable = true;
      searchUpKey = [
        "^[[A"
        "^[OA"
        "$terminfo[kcuu1]"
      ];
      searchDownKey = [
        "^[[B"
        "^[OB"
        "$terminfo[kcud1]"
      ];
    };

    history = {
      ignoreAllDups = true;
      share = true;
    };

    completionInit = ''
      autoload -U compinit && compinit
      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
    '';

    initContent = ''
      if [[ -n "$IN_CODE_SHELL" ]]; then
        _shell_tag='%F{red}(code-shell)%f '
      elif [[ -n "$IN_NIX_SHELL" ]]; then
        _shell_tag='%F{yellow}(nix-shell)%f '
      else
        _shell_tag=""
      fi
      PROMPT="''${_shell_tag}%F{green}➜ %F{cyan}%~%f "

      bindkey '^[[1;5C' forward-word
      bindkey '^[[1;5D' backward-word
      bindkey '^[[1;2C' forward-word
      bindkey '^[[1;2D' backward-word
      bindkey '^H' backward-kill-word
      bindkey '^[[3;5~' kill-word
      bindkey '^[[H' beginning-of-line
      bindkey '^[OH' beginning-of-line
      bindkey '^[[F' end-of-line
      bindkey '^[OF' end-of-line
      bindkey '^Z' undo
      bindkey '^[.' insert-last-word
    '';
  };

  # Interactive fuzzy history search bound to Ctrl+R
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.carapace = {
    enable = true;
    enableZshIntegration = true;
  };
}

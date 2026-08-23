{
  theme,
  settings,
  inputs,
  pkgs,
  hostname,
  repoPath,
  ...
}:
let
  t = theme;

  flake = ''(builtins.getFlake "${repoPath}")'';
  host = "${flake}.nixosConfigurations.${hostname}";
in
{
  imports = [ inputs.nvf.homeManagerModules.default ];

  programs.nvf = {
    enable = true;

    settings.vim = {
      clipboard = {
        enable = true;
        providers.wl-copy.enable = true;
        registers = "unnamedplus";
      };

      lineNumberMode = "number";

      options = {
        shiftwidth = 2;
        tabstop = 2;
      };

      theme = {
        enable = true;
        name = "base16";

        base16-colors = {
          base00 = t.bg;
          base01 = t.surface;
          base02 = t.term.selBg;
          base03 = t.term.brBlack;
          base04 = t.term.brBlack;
          base05 = t.fg;
          base06 = t.term.brWhite;
          base07 = t.term.brWhite;
          base08 = t.red;
          base09 = t.accent;
          base0A = t.yellow;
          base0B = t.green;
          base0C = t.term.cyan;
          base0D = t.term.blue;
          base0E = t.term.magenta;
          base0F = t.term.brRed;
        };
      };

      autocmds = [
        {
          event = [
            "FocusGained"
            "BufEnter"
            "CursorHold"
          ];
          pattern = [ "*" ];
          command = "silent! checktime";
          desc = "Reload files changed outside Neovim";
        }
      ];

      keymaps = [
        {
          key = "<leader>e";
          mode = "n";
          action = ":Neotree toggle<CR>";
          silent = true;
          desc = "Toggle File Explorer";
        }

        {
          key = "<leader>gg";
          mode = "n";
          action = ":Neogit<CR>";
          silent = true;
          desc = "Open Neogit";
        }

        {
          key = "<C-h>";
          mode = "n";
          action = "<C-w>h";
          silent = true;
          desc = "Focus Left (Explorer)";
        }
        {
          key = "<C-l>";
          mode = "n";
          action = "<C-w>l";
          silent = true;
          desc = "Focus Right (Editor)";
        }
      ];

      filetree.neo-tree = {
        enable = true;
        setupOpts = {
          close_if_last_window = true;
          window = {
            position = "left";
            width = 30;
          };
        };
      };

      telescope.enable = true;

      git = {
        gitsigns.enable = true;
        neogit.enable = true;
      };

      binds.whichKey.enable = true;

      visuals = {
        nvim-web-devicons.enable = true;
        fidget-nvim.enable = true;
      };

      statusline.lualine.enable = true;
      tabline.nvimBufferline.enable = true;

      lsp = {
        enable = true;
        formatOnSave = true;

        servers.nixd.settings.nixd = {
          nixpkgs.expr = "${flake}.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}";
          options = {
            nixos.expr = "${host}.options";
            home-manager.expr = "${host}.options.home-manager.users.type.getSubOptions [ ]";
          };
        };
      };

      treesitter = {
        enable = true;
        context.enable = true;
      };

      languages = {
        enableFormat = true;
        enableTreesitter = true;

        nix = {
          enable = true;
          lsp.servers = [ "nixd" ];
          format.type = [ "nixfmt" ];
        };
        python.enable = true;
        markdown.enable = true;
        bash.enable = true;
      };
    };
  };

  xdg.desktopEntries.nvim = {
    name = "Neovim";
    genericName = "Text Editor";
    exec = "${settings.terminal} -e nvim %F";
    icon = "nvim";
    terminal = false;
    categories = [
      "Utility"
      "TextEditor"
    ];
    mimeType = [
      "text/plain"
      "text/markdown"
    ];
  };
}

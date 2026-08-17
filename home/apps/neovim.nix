{
  lib,
  pkgs,
  theme,
  settings,
  ...
}:
let
  t = theme;

  palette = {
    inherit (t.term)
      bg
      fg
      black
      red
      green
      yellow
      blue
      magenta
      cyan
      white
      brBlack
      brRed
      brGreen
      brYellow
      brBlue
      brMagenta
      brCyan
      brWhite
      selBg
      ;
    inherit (t) surface hover accent;
    cursor = t.term.curCursor;
  };

  luaPalette = lib.concatStrings (
    lib.mapAttrsToList (name: color: "  ${name} = \"${color}\",\n") palette
  );

  colorscheme = ''
    local c = {
    ${luaPalette}}

    vim.cmd.highlight("clear")
    if vim.fn.exists("syntax_on") == 1 then
      vim.cmd.syntax("reset")
    end
    vim.o.termguicolors = true
    vim.o.background = "dark"
    vim.g.colors_name = "${settings.theme}"

    local ansi = {
      c.black, c.red, c.green, c.yellow, c.blue, c.magenta, c.cyan, c.white,
      c.brBlack, c.brRed, c.brGreen, c.brYellow, c.brBlue, c.brMagenta, c.brCyan, c.brWhite,
    }
    for i, color in ipairs(ansi) do
      vim.g["terminal_color_" .. (i - 1)] = color
    end

    local groups = {
      Normal = { fg = c.fg },
      NormalNC = { link = "Normal" },
      NormalFloat = { fg = c.fg, bg = c.surface },
      FloatBorder = { fg = c.hover, bg = c.surface },
      FloatTitle = { fg = c.accent, bg = c.surface, bold = true },
      ColorColumn = { bg = c.surface },
      Conceal = { fg = c.brBlack },
      Cursor = { fg = c.bg, bg = c.cursor },
      lCursor = { link = "Cursor" },
      TermCursor = { link = "Cursor" },
      CursorLine = { bg = c.surface },
      CursorColumn = { link = "CursorLine" },
      CursorLineNr = { fg = c.accent, bold = true },
      LineNr = { fg = c.brBlack },
      Directory = { fg = c.blue },
      EndOfBuffer = { fg = c.bg },
      ErrorMsg = { fg = c.red, bold = true },
      WinSeparator = { fg = c.hover },
      Folded = { fg = c.brBlack, bg = c.surface },
      FoldColumn = { fg = c.brBlack },
      SignColumn = { fg = c.brBlack },
      IncSearch = { fg = c.bg, bg = c.accent },
      CurSearch = { link = "IncSearch" },
      Search = { fg = c.fg, bg = c.selBg },
      Substitute = { fg = c.bg, bg = c.red },
      MatchParen = { fg = c.accent, bold = true },
      ModeMsg = { fg = c.fg, bold = true },
      MoreMsg = { fg = c.green },
      NonText = { fg = c.hover },
      Whitespace = { fg = c.hover },
      SpecialKey = { fg = c.hover },
      Pmenu = { fg = c.fg, bg = c.surface },
      PmenuSel = { bg = c.selBg, bold = true },
      PmenuSbar = { bg = c.surface },
      PmenuThumb = { bg = c.hover },
      Question = { fg = c.green },
      QuickFixLine = { bg = c.selBg },
      StatusLine = { fg = c.fg, bg = c.surface },
      StatusLineNC = { fg = c.brBlack, bg = c.surface },
      TabLine = { fg = c.brBlack, bg = c.surface },
      TabLineFill = { bg = c.bg },
      TabLineSel = { fg = c.bg, bg = c.accent },
      Title = { fg = c.accent, bold = true },
      Visual = { bg = c.selBg },
      VisualNOS = { link = "Visual" },
      WarningMsg = { fg = c.yellow },
      WildMenu = { link = "PmenuSel" },
      WinBar = { fg = c.fg, bold = true },
      WinBarNC = { fg = c.brBlack },

      Comment = { fg = c.brBlack, italic = true },
      Constant = { fg = c.cyan },
      String = { fg = c.green },
      Character = { fg = c.green },
      Number = { fg = c.cyan },
      Boolean = { fg = c.cyan },
      Float = { link = "Number" },
      Identifier = { fg = c.fg },
      Function = { fg = c.blue },
      Statement = { fg = c.magenta },
      Conditional = { link = "Statement" },
      Repeat = { link = "Statement" },
      Label = { link = "Statement" },
      Keyword = { link = "Statement" },
      Exception = { link = "Statement" },
      Operator = { fg = c.cyan },
      PreProc = { fg = c.magenta },
      Include = { link = "PreProc" },
      Define = { link = "PreProc" },
      Macro = { link = "PreProc" },
      PreCondit = { link = "PreProc" },
      Type = { fg = c.yellow },
      StorageClass = { link = "Type" },
      Structure = { link = "Type" },
      Typedef = { link = "Type" },
      Special = { fg = c.cyan },
      SpecialChar = { link = "Special" },
      SpecialComment = { fg = c.brBlack, bold = true },
      Debug = { link = "Special" },
      Delimiter = { fg = c.brWhite },
      Tag = { fg = c.red },
      Underlined = { underline = true },
      Ignore = { fg = c.brBlack },
      Error = { fg = c.red },
      Todo = { fg = c.bg, bg = c.yellow, bold = true },
      Added = { fg = c.green },
      Changed = { fg = c.yellow },
      Removed = { fg = c.red },

      DiffAdd = { fg = c.green, bg = c.surface },
      DiffChange = { fg = c.yellow, bg = c.surface },
      DiffDelete = { fg = c.red, bg = c.surface },
      DiffText = { fg = c.bg, bg = c.yellow },

      SpellBad = { sp = c.red, undercurl = true },
      SpellCap = { sp = c.yellow, undercurl = true },
      SpellLocal = { sp = c.blue, undercurl = true },
      SpellRare = { sp = c.magenta, undercurl = true },

      DiagnosticError = { fg = c.red },
      DiagnosticWarn = { fg = c.yellow },
      DiagnosticInfo = { fg = c.blue },
      DiagnosticHint = { fg = c.cyan },
      DiagnosticOk = { fg = c.green },
      DiagnosticUnderlineError = { sp = c.red, undercurl = true },
      DiagnosticUnderlineWarn = { sp = c.yellow, undercurl = true },
      DiagnosticUnderlineInfo = { sp = c.blue, undercurl = true },
      DiagnosticUnderlineHint = { sp = c.cyan, undercurl = true },
      DiagnosticUnnecessary = { fg = c.brBlack },
      DiagnosticDeprecated = { sp = c.brBlack, strikethrough = true },

      LspReferenceText = { bg = c.hover },
      LspReferenceRead = { bg = c.hover },
      LspReferenceWrite = { bg = c.hover },
      LspInlayHint = { fg = c.brBlack },
      LspCodeLens = { fg = c.brBlack },
      LspSignatureActiveParameter = { fg = c.accent, bold = true },

      ["@variable"] = { fg = c.fg },
      ["@variable.builtin"] = { fg = c.red },
      ["@variable.parameter"] = { fg = c.brYellow },
      ["@variable.member"] = { fg = c.cyan },
      ["@property"] = { fg = c.cyan },
      ["@constant.builtin"] = { fg = c.brCyan },
      ["@module"] = { fg = c.yellow },
      ["@constructor"] = { fg = c.yellow },
      ["@function.builtin"] = { fg = c.brBlue },
      ["@punctuation.bracket"] = { fg = c.brWhite },
      ["@punctuation.delimiter"] = { fg = c.brWhite },
      ["@punctuation.special"] = { fg = c.magenta },
      ["@string.escape"] = { fg = c.brGreen },
      ["@string.special"] = { fg = c.cyan },
      ["@tag"] = { fg = c.red },
      ["@tag.attribute"] = { fg = c.yellow },
      ["@tag.delimiter"] = { fg = c.brWhite },
      ["@markup.heading"] = { fg = c.accent, bold = true },
      ["@markup.link"] = { fg = c.blue, underline = true },
      ["@markup.raw"] = { fg = c.green },
      ["@markup.list"] = { fg = c.magenta },
      ["@markup.quote"] = { fg = c.brBlack, italic = true },
      ["@markup.strong"] = { bold = true },
      ["@markup.italic"] = { italic = true },
      ["@markup.strikethrough"] = { strikethrough = true },
      ["@markup.underline"] = { underline = true },
    }

    for name, spec in pairs(groups) do
      vim.api.nvim_set_hl(0, name, spec)
    end
  '';
in
{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    withPython3 = false;
    withRuby = false;

    initLua = ''
      vim.o.number = true
      vim.cmd.colorscheme("system")
    '';
  };

  xdg.configFile."nvim/colors/system.lua".text = colorscheme;
}

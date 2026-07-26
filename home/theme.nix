{ pkgs }:
let

  mkMatugenTheme = import ../lib/mkMatugenTheme.nix { inherit pkgs; };

  generated = mkMatugenTheme {
    seed = "#ad7882"; # paste the hex from `wallpaper-color` here
    mode = "dark";
  };

  themes = {
    omarchy = {
      bg = "#131315";
      surface = "#27272a";
      fg = "#e6d8ba";
      accent = "#ff9b71";
      hover = "#3f3f46";
      red = "#f53c3c";
      green = "#9ece6a";
      yellow = "#e0af68";
      contrast = "#000";
      shadow = "#131313";
      dim = "0.4";
      calMonth = "#ffead3";
      calWeekdays = "#ffcc66";
      calToday = "#ff6699";

      hypr = {
        active_border = "rgba(ff9b71ff)";
        inactive_border = "rgba(595959aa)";
        shadow = "rgba(00000077)";
      };

      term = {
        bg = "#141218";
        fg = "#e7e0e8";
        selText = "#e7e0e8";
        selBg = "#4e3d75";
        curText = "#141218";
        curCursor = "#d1bcfd";
        black = "#141218";
        red = "#ff728e";
        green = "#7efd99";
        yellow = "#ffda72";
        blue = "#bea6f0";
        magenta = "#4f3d75";
        cyan = "#d1bcfd";
        white = "#f4efff";
        brBlack = "#9c98a4";
        brRed = "#ff9fb2";
        brGreen = "#a5ffb8";
        brYellow = "#ffe7a5";
        brBlue = "#d9c7ff";
        brMagenta = "#dfd1ff";
        brCyan = "#ebe1ff";
        brWhite = "#faf8ff";
      };

      fuzzel = {
        bg = "131315ee";
        text = "e6d8baff";
        match = "ff9b71ff";
        selection = "3f3f46ff";
        selText = "e6d8baff";
        selMatch = "ff9b71ff";
        border = "ff9b71ff";
      };
    };

    tokyo-night = {
      bg = "#1a1b26";
      surface = "#24283b";
      fg = "#c0caf5";
      accent = "#7dcfff";
      hover = "#3b3f5c";
      red = "#f7768e";
      green = "#9ece6a";
      yellow = "#e0af68";
      contrast = "#000";
      shadow = "#13131a";
      dim = "0.35";
      calMonth = "#c0caf5";
      calWeekdays = "#e0af68";
      calToday = "#ff007c";

      hypr = {
        active_border = "rgba(7dcfffff)";
        inactive_border = "rgba(3b3f5caa)";
        shadow = "rgba(00000077)";
      };

      term = {
        bg = "#1a1b26";
        fg = "#c0caf5";
        selText = "#c0caf5";
        selBg = "#33467c";
        curText = "#1a1b26";
        curCursor = "#c0caf5";
        black = "#15161e";
        red = "#f7768e";
        green = "#9ece6a";
        yellow = "#e0af68";
        blue = "#7aa2f7";
        magenta = "#bb9af7";
        cyan = "#7dcfff";
        white = "#a9b1d6";
        brBlack = "#414868";
        brRed = "#f7768e";
        brGreen = "#9ece6a";
        brYellow = "#e0af68";
        brBlue = "#7aa2f7";
        brMagenta = "#bb9af7";
        brCyan = "#7dcfff";
        brWhite = "#c0caf5";
      };

      fuzzel = {
        bg = "1a1b26ee";
        text = "c0caf5ff";
        match = "7dcfffff";
        selection = "33467cff";
        selText = "c0caf5ff";
        selMatch = "7dcfffff";
        border = "7dcfffff";
      };
    };

    neon-dusk = {
      bg = "#0e0e14";
      surface = "#1a1a24";
      fg = "#e2e0f0";
      accent = "#00e5ff";
      hover = "#2a2a3a";
      red = "#ff2d8a";
      green = "#62d196";
      yellow = "#ffd580";
      contrast = "#000";
      shadow = "#08080c";
      dim = "0.3";
      calMonth = "#e2e0f0";
      calWeekdays = "#ffd580";
      calToday = "#ff2d8a";

      hypr = {
        active_border = "rgba(00e5ffff)";
        inactive_border = "rgba(2a2a3aaa)";
        shadow = "rgba(00000077)";
      };

      term = {
        bg = "#0e0e14";
        fg = "#e2e0f0";
        selText = "#e2e0f0";
        selBg = "#2e2e4a";
        curText = "#0e0e14";
        curCursor = "#00e5ff";
        black = "#0e0e14";
        red = "#ff2d8a";
        green = "#62d196";
        yellow = "#ffd580";
        blue = "#82aaff";
        magenta = "#c792ea";
        cyan = "#00e5ff";
        white = "#e2e0f0";
        brBlack = "#4e4e6a";
        brRed = "#ff5fa0";
        brGreen = "#8be8b4";
        brYellow = "#ffe4a8";
        brBlue = "#a8c4ff";
        brMagenta = "#dbb4f5";
        brCyan = "#5cf0ff";
        brWhite = "#f4f2ff";
      };

      fuzzel = {
        bg = "0e0e14ee";
        text = "e2e0f0ff";
        match = "00e5ffff";
        selection = "2a2a3aff";
        selText = "e2e0f0ff";
        selMatch = "00e5ffff";
        border = "00e5ffff";
      };
    };

    kanagawa = {
      bg = "#1f1f28";
      surface = "#2a2a37";
      fg = "#dcd7ba";
      accent = "#7e9cd8";
      hover = "#363646";
      red = "#e82424";
      green = "#98bb6c";
      yellow = "#e6c384";
      contrast = "#000";
      shadow = "#16161d";
      dim = "0.35";
      calMonth = "#dcd7ba";
      calWeekdays = "#e6c384";
      calToday = "#d27e99";

      hypr = {
        active_border = "rgba(7e9cd8ff)";
        inactive_border = "rgba(363646aa)";
        shadow = "rgba(00000077)";
      };

      term = {
        bg = "#1f1f28";
        fg = "#dcd7ba";
        selText = "#dcd7ba";
        selBg = "#2d4f67";
        curText = "#1f1f28";
        curCursor = "#c8c093";
        black = "#090618";
        red = "#c34043";
        green = "#76946a";
        yellow = "#c0a36e";
        blue = "#7e9cd8";
        magenta = "#957fb8";
        cyan = "#6a9589";
        white = "#c8c093";
        brBlack = "#727169";
        brRed = "#e82424";
        brGreen = "#98bb6c";
        brYellow = "#e6c384";
        brBlue = "#7fb4ca";
        brMagenta = "#938aa9";
        brCyan = "#7aa89f";
        brWhite = "#dcd7ba";
      };

      fuzzel = {
        bg = "1f1f28ee";
        text = "dcd7baff";
        match = "7e9cd8ff";
        selection = "2d4f67ff";
        selText = "dcd7baff";
        selMatch = "7e9cd8ff";
        border = "7e9cd8ff";
      };
    };

    rosepine = {
      bg = "#191724";
      surface = "#1f1d2e";
      fg = "#e0def4";
      accent = "#c4a7e7";
      hover = "#26233a";
      red = "#eb6f92";
      green = "#9ccfd8";
      yellow = "#f6c177";
      contrast = "#000";
      shadow = "#131020";
      dim = "0.35";
      calMonth = "#e0def4";
      calWeekdays = "#f6c177";
      calToday = "#eb6f92";

      hypr = {
        active_border = "rgba(c4a7e7ff)";
        inactive_border = "rgba(26233aaa)";
        shadow = "rgba(00000077)";
      };

      term = {
        bg = "#191724";
        fg = "#e0def4";
        selText = "#e0def4";
        selBg = "#26233a";
        curText = "#191724";
        curCursor = "#e0def4";
        black = "#26233a";
        red = "#eb6f92";
        green = "#31748f";
        yellow = "#f6c177";
        blue = "#9ccfd8";
        magenta = "#c4a7e7";
        cyan = "#ebbcba";
        white = "#e0def4";
        brBlack = "#6e6a86";
        brRed = "#eb6f92";
        brGreen = "#31748f";
        brYellow = "#f6c177";
        brBlue = "#9ccfd8";
        brMagenta = "#c4a7e7";
        brCyan = "#ebbcba";
        brWhite = "#e0def4";
      };

      fuzzel = {
        bg = "191724ee";
        text = "e0def4ff";
        match = "c4a7e7ff";
        selection = "26233aff";
        selText = "e0def4ff";
        selMatch = "c4a7e7ff";
        border = "c4a7e7ff";
      };
    };

    mono = {
      bg = "#0c0c0c";
      surface = "#181818";
      fg = "#d0d0d0";
      accent = "#f0f0f0";
      hover = "#222222";
      red = "#c04040";
      green = "#888888";
      yellow = "#aaaaaa";
      contrast = "#000";
      shadow = "#050505";
      dim = "0.3";
      calMonth = "#d0d0d0";
      calWeekdays = "#909090";
      calToday = "#ffffff";

      hypr = {
        active_border = "rgba(f0f0f0ff)";
        inactive_border = "rgba(303030aa)";
        shadow = "rgba(00000077)";
      };

      term = {
        bg = "#0c0c0e";
        fg = "#d0d4de";
        selText = "#d0d4de";
        selBg = "#252530";
        curText = "#0c0c0e";
        curCursor = "#f0f0f0";
        black = "#111116";
        red = "#c4607c";
        green = "#60b890";
        yellow = "#c4a858";
        blue = "#5898d4";
        magenta = "#a868c8";
        cyan = "#40b8d8";
        white = "#d0d4de";
        brBlack = "#404050";
        brRed = "#e07090";
        brGreen = "#78d0a8";
        brYellow = "#dcc070";
        brBlue = "#70b0e8";
        brMagenta = "#c080e0";
        brCyan = "#58d0ec";
        brWhite = "#eaeef8";
      };

      fuzzel = {
        bg = "0c0c0cee";
        text = "d0d0d0ff";
        match = "f0f0f0ff";
        selection = "222222ff";
        selText = "d0d0d0ff";
        selMatch = "f0f0f0ff";
        border = "f0f0f0ff";
      };
    };

    catppuccin = {
      bg = "#1e1e2e";
      surface = "#313244";
      fg = "#cdd6f4";
      accent = "#cba6f7";
      hover = "#45475a";
      red = "#f38ba8";
      green = "#a6e3a1";
      yellow = "#f9e2af";
      contrast = "#000";
      shadow = "#11111b";
      dim = "0.35";
      calMonth = "#cdd6f4";
      calWeekdays = "#f9e2af";
      calToday = "#f5c2e7";

      hypr = {
        active_border = "rgba(6c7086ff)";
        inactive_border = "rgba(45475aaa)";
        shadow = "rgba(00000077)";
      };

      term = {
        bg = "#1e1e2e";
        fg = "#cdd6f4";
        selText = "#cdd6f4";
        selBg = "#585b70";
        curText = "#1e1e2e";
        curCursor = "#f5e0dc";
        black = "#45475a";
        red = "#f38ba8";
        green = "#a6e3a1";
        yellow = "#f9e2af";
        blue = "#89b4fa";
        magenta = "#f5c2e7";
        cyan = "#94e2d5";
        white = "#bac2de";
        brBlack = "#585b70";
        brRed = "#f38ba8";
        brGreen = "#a6e3a1";
        brYellow = "#f9e2af";
        brBlue = "#89b4fa";
        brMagenta = "#f5c2e7";
        brCyan = "#94e2d5";
        brWhite = "#a6adc8";
      };

      fuzzel = {
        bg = "1e1e2eee";
        text = "cdd6f4ff";
        match = "cba6f7ff";
        selection = "45475aff";
        selText = "cdd6f4ff";
        selMatch = "cba6f7ff";
        border = "cba6f7ff";
      };
    };

    peppermint = {
      bg = "#0c0c0c";
      surface = "#131313";
      fg = "#dedede";
      accent = "#96dcda";
      hover = "#1e1e1e";
      red = "#e64569";
      green = "#89d287";
      yellow = "#dab752";
      contrast = "#0c0c0c";
      shadow = "#060606";
      dim = "0.35";
      calMonth = "#dedede";
      calWeekdays = "#dab752";
      calToday = "#e64569";

      hypr = {
        active_border = "rgba(96dcdaff)";
        inactive_border = "rgba(1e1e1eaa)";
        shadow = "rgba(00000077)";
      };

      term = {
        bg = "#0c0c0c";
        fg = "#dedede";
        selText = "#dedede";
        selBg = "#2a4050";
        curText = "#0c0c0c";
        curCursor = "#96dcda";
        black = "#353535";
        red = "#e64569";
        green = "#89d287";
        yellow = "#dab752";
        blue = "#439ecf";
        magenta = "#d961dc";
        cyan = "#64aaaf";
        white = "#b3b3b3";
        brBlack = "#535353";
        brRed = "#e4859a";
        brGreen = "#a2cca1";
        brYellow = "#e1e387";
        brBlue = "#6fbbe2";
        brMagenta = "#e586e7";
        brCyan = "#96dcda";
        brWhite = "#dedede";
      };

      fuzzel = {
        bg = "0c0c0cee";
        text = "dededeff";
        match = "96dcdaff";
        selection = "1e1e1eff";
        selText = "dededeff";
        selMatch = "96dcdaff";
        border = "96dcdaff";
      };
    };

    sakura = {
      bg = "#181115";
      surface = "#241b20";
      fg = "#e6d8dd";
      accent = "#c07898";
      hover = "#362830";
      red = "#e0607a";
      green = "#8dc47a";
      yellow = "#d4a860";
      contrast = "#000";
      shadow = "#100b0e";
      dim = "0.38";
      calMonth = "#e6d8dd";
      calWeekdays = "#d4a860";
      calToday = "#c07898";

      hypr = {
        active_border = "rgba(c07898ff)";
        inactive_border = "rgba(362830aa)";
        shadow = "rgba(00000077)";
      };

      term = {
        bg = "#181115";
        fg = "#e6d8dd";
        selText = "#e6d8dd";
        selBg = "#4a2a36";
        curText = "#181115";
        curCursor = "#c07898";
        black = "#181115";
        red = "#e0607a";
        green = "#8dc47a";
        yellow = "#d4a860";
        blue = "#7e9ec0";
        magenta = "#c07898";
        cyan = "#78a896";
        white = "#ccc0c4";
        brBlack = "#6a5058";
        brRed = "#e88098";
        brGreen = "#a8d896";
        brYellow = "#e4c080";
        brBlue = "#9ab8d8";
        brMagenta = "#d898b0";
        brCyan = "#96c0b4";
        brWhite = "#e6d8dd";
      };

      fuzzel = {
        bg = "181115ee";
        text = "e6d8ddff";
        match = "c07898ff";
        selection = "362830ff";
        selText = "e6d8ddff";
        selMatch = "c07898ff";
        border = "c07898ff";
      };
    };

    orchid = {
      bg = "#141214";
      surface = "#201c20";
      fg = "#e0d4e0";
      accent = "#b87eb8";
      hover = "#2e283e";
      red = "#d86878";
      green = "#88c47a";
      yellow = "#c8a860";
      contrast = "#000";
      shadow = "#0c0a0c";
      dim = "0.38";
      calMonth = "#e0d4e0";
      calWeekdays = "#c8a860";
      calToday = "#b87eb8";

      hypr = {
        active_border = "rgba(b87eb8ff)";
        inactive_border = "rgba(2e283eaa)";
        shadow = "rgba(00000077)";
      };

      term = {
        bg = "#141214";
        fg = "#e0d4e0";
        selText = "#e0d4e0";
        selBg = "#3c2a48";
        curText = "#141214";
        curCursor = "#b87eb8";
        black = "#141214";
        red = "#d86878";
        green = "#88c47a";
        yellow = "#c8a860";
        blue = "#7898c8";
        magenta = "#b87eb8";
        cyan = "#70a898";
        white = "#c0b4c0";
        brBlack = "#604858";
        brRed = "#e88898";
        brGreen = "#a4d898";
        brYellow = "#dcc080";
        brBlue = "#98b4e0";
        brMagenta = "#d0a0d0";
        brCyan = "#90c0b0";
        brWhite = "#e0d4e0";
      };

      fuzzel = {
        bg = "141214ee";
        text = "e0d4e0ff";
        match = "b87eb8ff";
        selection = "2e283eff";
        selText = "e0d4e0ff";
        selMatch = "b87eb8ff";
        border = "b87eb8ff";
      };
    };

    mochi = {
      bg = "#131118";
      surface = "#1e1924";
      fg = "#e4d8e8";
      accent = "#d07a9a";
      hover = "#2a2236";
      red = "#e06070";
      green = "#88c480";
      yellow = "#d0a858";
      contrast = "#000";
      shadow = "#0d0b10";
      dim = "0.38";
      calMonth = "#e4d8e8";
      calWeekdays = "#d0a858";
      calToday = "#d07a9a";

      hypr = {
        active_border = "rgba(d07a9aff)";
        inactive_border = "rgba(2a2236aa)";
        shadow = "rgba(00000077)";
      };

      term = {
        bg = "#131118";
        fg = "#e4d8e8";
        selText = "#e4d8e8";
        selBg = "#44283e";
        curText = "#131118";
        curCursor = "#d07a9a";
        black = "#131118";
        red = "#e06070";
        green = "#88c480";
        yellow = "#d0a858";
        blue = "#7888c8";
        magenta = "#d07a9a";
        cyan = "#6898a0";
        white = "#c4b8cc";
        brBlack = "#5e4868";
        brRed = "#e88898";
        brGreen = "#a4d898";
        brYellow = "#dcc078";
        brBlue = "#98a8e0";
        brMagenta = "#e098b8";
        brCyan = "#88b8c0";
        brWhite = "#e4d8e8";
      };

      fuzzel = {
        bg = "131118ee";
        text = "e4d8e8ff";
        match = "d07a9aff";
        selection = "2a2236ff";
        selText = "e4d8e8ff";
        selMatch = "d07a9aff";
        border = "d07a9aff";
      };
    };

    nightowl = {
      bg = "#131318";
      surface = "#1f1f25";
      fg = "#e4e1e9";
      accent = "#bec2ff";
      hover = "#34343a";
      red = "#ffb4ab";
      green = "#a8c47a";
      yellow = "#e8c08e";
      contrast = "#000";
      shadow = "#0c0c10";
      dim = "0.4";
      calMonth = "#e4e1e9";
      calWeekdays = "#e8c08e";
      calToday = "#ffb2b8";

      hypr = {
        active_border = "rgba(bec2ffff)";
        inactive_border = "rgba(34343aaa)";
        shadow = "rgba(00000077)";
      };

      term = {
        bg = "#131318";
        fg = "#e4e1e9";
        selText = "#e4e1e9";
        selBg = "#2a292f";
        curText = "#131318";
        curCursor = "#bec2ff";
        black = "#1f1f25";
        red = "#ffb2b8";
        green = "#a8c47a";
        yellow = "#e8c08e";
        blue = "#bec2ff";
        magenta = "#e8b9d5";
        cyan = "#c5c4dd";
        white = "#c7c5d0";
        brBlack = "#46464f";
        brRed = "#ffdadb";
        brGreen = "#c2dba0";
        brYellow = "#ffddb4";
        brBlue = "#e0e0ff";
        brMagenta = "#ffd8ee";
        brCyan = "#e1e0f9";
        brWhite = "#f0eef7";
      };

      fuzzel = {
        bg = "131318ee";
        text = "e4e1e9ff";
        match = "bec2ffff";
        selection = "2a292fff";
        selText = "e4e1e9ff";
        selMatch = "bec2ffff";
        border = "bec2ffff";
      };
    };

    rosewood = {
      bg = "#1a1112";
      surface = "#271d1e";
      fg = "#f0dedf";
      accent = "#ffb2b8";
      hover = "#3d3233";
      red = "#ffb4ab";
      green = "#9ec48a";
      yellow = "#e8c08e";
      contrast = "#000";
      shadow = "#100a0b";
      dim = "0.4";
      calMonth = "#f0dedf";
      calWeekdays = "#e8c08e";
      calToday = "#ffb2b8";

      hypr = {
        active_border = "rgba(ffb2b8ff)";
        inactive_border = "rgba(3d3233aa)";
        shadow = "rgba(00000077)";
      };

      term = {
        bg = "#1a1112";
        fg = "#f0dedf";
        selText = "#f0dedf";
        selBg = "#312828";
        curText = "#1a1112";
        curCursor = "#ffb2b8";
        black = "#271d1e";
        red = "#ffb2b8";
        green = "#9ec48a";
        yellow = "#e8c08e";
        blue = "#9ab8d8";
        magenta = "#e6bdbf";
        cyan = "#a8c4bf";
        white = "#d7c1c2";
        brBlack = "#524344";
        brRed = "#ffdadb";
        brGreen = "#bcd9a8";
        brYellow = "#ffddb4";
        brBlue = "#bcd2e8";
        brMagenta = "#f4ddde";
        brCyan = "#c8e0db";
        brWhite = "#fff8f7";
      };

      fuzzel = {
        bg = "1a1112ee";
        text = "f0dedfff";
        match = "ffb2b8ff";
        selection = "312828ff";
        selText = "f0dedfff";
        selMatch = "ffb2b8ff";
        border = "ffb2b8ff";
      };
    };
  };
  # themes: omarchy, tokyo-night, neon-dusk, kanagawa, rosepine, mono, peppermint, sakura, orchid, mochi, nightowl, rosewood
in
{
  theme = themes.nightowl;
  settings = {
    rounding = 5;
    blur = true;
    animations = true;
  };
}

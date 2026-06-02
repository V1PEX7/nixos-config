let
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

      mango = {
        focus = "0xff9b71ff";
        border = "0x595959aa";
        urgent = "0xf53c3cff";
        scratchpad = "0x516c93ff";
        global = "0xb153a7ff";
        overlay = "0x14a57cff";
        maximize = "0x89aa61ff";
        root = "0x131315ff";
        shadow = "0x00000077";
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

      mango = {
        focus = "0x7dcfffff";
        border = "0x3b3f5caa";
        urgent = "0xf7768eff";
        scratchpad = "0x7aa2f7ff";
        global = "0xbb9af7ff";
        overlay = "0x9ece6aff";
        maximize = "0x73dacaff";
        root = "0x1a1b26ff";
        shadow = "0x00000077";
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

      mango = {
        focus = "0x00e5ffff";
        border = "0x2a2a3aaa";
        urgent = "0xff2d8aff";
        scratchpad = "0x82aaffff";
        global = "0xc792eaff";
        overlay = "0x62d196ff";
        maximize = "0x62d196ff";
        root = "0x0e0e14ff";
        shadow = "0x00000077";
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

      mango = {
        focus = "0x7e9cd8ff";
        border = "0x363646aa";
        urgent = "0xe82424ff";
        scratchpad = "0x7fb4caff";
        global = "0x957fb8ff";
        overlay = "0x98bb6cff";
        maximize = "0x6a9589ff";
        root = "0x1f1f28ff";
        shadow = "0x00000077";
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

      mango = {
        focus = "0xc4a7e7ff";
        border = "0x26233aaa";
        urgent = "0xeb6f92ff";
        scratchpad = "0x9ccfd8ff";
        global = "0xc4a7e7ff";
        overlay = "0x31748fff";
        maximize = "0x9ccfd8ff";
        root = "0x191724ff";
        shadow = "0x00000077";
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

      mango = {
        focus = "0xf0f0f0ff";
        border = "0x303030aa";
        urgent = "0xc04040ff";
        scratchpad = "0x707070ff";
        global = "0x909090ff";
        overlay = "0x606060ff";
        maximize = "0x808080ff";
        root = "0x0c0c0cff";
        shadow = "0x00000077";
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

      mango = {
        focus = "0x6c7086ff";
        border = "0x45475aaa";
        urgent = "0xf38ba8ff";
        scratchpad = "0x89b4faff";
        global = "0xf5c2e7ff";
        overlay = "0xa6e3a1ff";
        maximize = "0x94e2d5ff";
        root = "0x1e1e2eff";
        shadow = "0x00000077";
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

      mango = {
        focus = "0x96dcdaff";
        border = "0x1e1e1eaa";
        urgent = "0xe64569ff";
        scratchpad = "0x439ecfff";
        global = "0xd961dcff";
        overlay = "0x89d287ff";
        maximize = "0x64aaafff";
        root = "0x0c0c0cff";
        shadow = "0x00000077";
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

      mango = {
        focus = "0xc07898ff";
        border = "0x362830aa";
        urgent = "0xe0607aff";
        scratchpad = "0x7e9ec0ff";
        global = "0xa87ec0ff";
        overlay = "0x8dc47aff";
        maximize = "0x78a896ff";
        root = "0x181115ff";
        shadow = "0x00000077";
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

      mango = {
        focus = "0xb87eb8ff";
        border = "0x2e283eaa";
        urgent = "0xd86878ff";
        scratchpad = "0x7898c8ff";
        global = "0xb87eb8ff";
        overlay = "0x88c47aff";
        maximize = "0x70a898ff";
        root = "0x141214ff";
        shadow = "0x00000077";
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

      mango = {
        focus = "0xd07a9aff";
        border = "0x2a2236aa";
        urgent = "0xe06070ff";
        scratchpad = "0x7888c8ff";
        global = "0xa880c8ff";
        overlay = "0x88c480ff";
        maximize = "0x6898a0ff";
        root = "0x131118ff";
        shadow = "0x00000077";
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
  };
  # themes: omarchy, tokyo-night, neon-dusk, kanagawa, rosepine, mono, peppermint, sakura, orchid, mochi
in
themes.mochi

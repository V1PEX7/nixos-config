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
  };
in
themes.omarchy

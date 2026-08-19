{ lib }:
let
  strip = c: lib.removePrefix "#" c;
  rgba = alpha: c: "rgba(${strip c}${alpha})";

  brightOf = {
    brBlack = "black";
    brRed = "red";
    brGreen = "green";
    brYellow = "yellow";
    brBlue = "blue";
    brMagenta = "magenta";
    brCyan = "cyan";
    brWhite = "white";
  };

  resolve =
    name: what: defaults: given:
    let
      unknown = lib.attrNames (removeAttrs given (lib.attrNames defaults));
    in
    lib.throwIf (
      unknown != [ ]
    ) "theme '${name}': unknown ${what}key(s) ${lib.concatStringsSep ", " unknown}" (defaults // given);

  mkTheme =
    name: raw:
    let
      need = k: throw "theme '${name}': missing ${k}";

      givenTop = removeAttrs raw [
        "term"
        "hypr"
      ];

      topBase = {
        bg = need "bg";
        surface = need "surface";
        fg = need "fg";
        accent = need "accent";
        hover = need "hover";
        red = need "red";
        green = need "green";
        yellow = need "yellow";

        contrast = "#000000";
        dim = "0.35";
      };

      topSeed = topBase // builtins.intersectAttrs topBase givenTop;

      topDerived = {
        shadow = topSeed.bg;
        calMonth = topSeed.fg;
        calWeekdays = topSeed.yellow;
        calToday = topSeed.accent;
      };

      top = resolve name "" (topBase // topDerived) givenTop;

      givenTerm = raw.term or { };

      termBase = {
        black = need "term.black";
        red = need "term.red";
        green = need "term.green";
        yellow = need "term.yellow";
        blue = need "term.blue";
        magenta = need "term.magenta";
        cyan = need "term.cyan";
        white = need "term.white";
        selBg = need "term.selBg";
        curCursor = need "term.curCursor";

        bg = top.bg;
        fg = top.fg;
      };

      termSeed = termBase // builtins.intersectAttrs termBase givenTerm;

      termDerived = {
        selText = termSeed.fg;
        curText = termSeed.bg;
      }
      // lib.mapAttrs (_: src: termSeed.${src}) brightOf;

      term = resolve name "term " (termBase // termDerived) givenTerm;

      hypr = resolve name "hypr " {
        active_border = rgba "ff" top.accent;
        inactive_border = rgba "aa" top.hover;
        shadow = "rgba(00000077)";
      } (raw.hypr or { });
    in
    top // { inherit term hypr; };
in
{
  inherit strip rgba mkTheme;
}

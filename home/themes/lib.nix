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

      top =
        resolve name ""
          {
            bg = need "bg";
            surface = need "surface";
            fg = need "fg";
            accent = need "accent";
            hover = need "hover";
            red = need "red";
            green = need "green";
            yellow = need "yellow";

            contrast = "#000000";
            shadow = top.bg;
            dim = "0.35";
            calMonth = top.fg;
            calWeekdays = top.yellow;
            calToday = top.accent;
          }
          (
            removeAttrs raw [
              "term"
              "hypr"
            ]
          );

      term = resolve name "term " (
        {
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
          selText = term.fg;
          curText = term.bg;
        }
        // lib.mapAttrs (_: src: term.${src}) brightOf
      ) (raw.term or { });

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

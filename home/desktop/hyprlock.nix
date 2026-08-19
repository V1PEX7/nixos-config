{
  theme,
  settings,
  strip,
  ...
}:
let
  t = theme;
  s = settings;
in
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
      };

      animations = {
        enabled = false;
      };

      background = [
        {
          monitor = "";
          path = s.wallpaper;
          blur_passes = 4;
          blur_size = 8;

          brightness = 0.4;
          contrast = 0.9;
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "250, 50";
          outline_thickness = 2;
          dots_size = 0.33;
          dots_spacing = 0.15;
          dots_center = true;
          outer_color = "rgb(${strip t.accent})";
          inner_color = "rgb(${strip t.surface})";
          font_color = "rgb(${strip t.fg})";
          fade_on_empty = false;
          placeholder_text = "<i>Password...</i>";
          position = "0, -20";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        # Clock
        {
          monitor = "";
          text = "$TIME";
          color = "rgb(${strip t.fg})";
          font_size = 64;
          font_family = s.font.family;
          position = "0, 80";
          halign = "center";
          valign = "center";
        }
        # Keyboard Layout
        {
          monitor = "";
          text = "$LAYOUT";
          color = "rgb(${strip t.fg})";
          font_size = 12;
          font_family = s.font.family;
          position = "0, -85";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}

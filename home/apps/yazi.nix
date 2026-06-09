{ ... }:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";
    settings = {
      mgr = {
        show_hidden = true;
        sort_by = "natural";
        sort_dir_first = true;
        linemode = "size";
      };
      preview = {
        image_filter = "lanczos3";
        image_quality = 90;
        max_width = 1000;
        max_height = 1000;
      };
    };
  };
}

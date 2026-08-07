{ ... }:
let
  browser = "firefox.desktop";
  fileManager = "thunar.desktop";
  imageViewer = "swayimg.desktop";
  mediaPlayer = "mpv.desktop";
  archiveManager = "xarchiver.desktop";
  textEditor = "zed.desktop";
in
{
  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "text/html" = [ browser ];
      "x-scheme-handler/http" = [ browser ];
      "x-scheme-handler/https" = [ browser ];
      "x-scheme-handler/about" = [ browser ];
      "x-scheme-handler/unknown" = [ browser ];
      "application/xhtml+xml" = [ browser ];

      "application/pdf" = [ browser ];

      "inode/directory" = [ fileManager ];

      "image/png" = [ imageViewer ];
      "image/jpeg" = [ imageViewer ];
      "image/gif" = [ imageViewer ];
      "image/webp" = [ imageViewer ];
      "image/bmp" = [ imageViewer ];
      "image/tiff" = [ imageViewer ];
      "image/svg+xml" = [ imageViewer ];

      "video/mp4" = [ mediaPlayer ];
      "video/x-matroska" = [ mediaPlayer ];
      "video/webm" = [ mediaPlayer ];
      "video/avi" = [ mediaPlayer ];
      "video/quicktime" = [ mediaPlayer ];
      "audio/mpeg" = [ mediaPlayer ];
      "audio/flac" = [ mediaPlayer ];
      "audio/wav" = [ mediaPlayer ];
      "audio/ogg" = [ mediaPlayer ];

      "application/zip" = [ archiveManager ];
      "application/x-tar" = [ archiveManager ];
      "application/x-gzip" = [ archiveManager ];
      "application/x-bzip2" = [ archiveManager ];
      "application/x-7z-compressed" = [ archiveManager ];
      "application/x-rar" = [ archiveManager ];
      "application/x-compressed-tar" = [ archiveManager ];

      "text/plain" = [ textEditor ];
      "text/markdown" = [ textEditor ];

      "application/x-bittorrent" = [ "qbittorrent.desktop" ];
      "x-scheme-handler/magnet" = [ "qbittorrent.desktop" ];

      "x-scheme-handler/tg" = [ "telegram-desktop.desktop" ];
      "x-scheme-handler/discord" = [ "vesktop.desktop" ];
    };
  };
}

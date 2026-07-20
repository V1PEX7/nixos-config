{ pkgs, lib, ... }:
let
  fetchCrx =
    {
      name,
      url,
      sha256,
    }:
    pkgs.fetchurl {
      inherit url sha256;
      name = "${name}.crx";
    };

  mkCrxUrl =
    id:
    "https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${lib.versions.major pkgs.ungoogled-chromium.version}&x=id%3D${id}%26installsource%3Dondemand%26uc";
in
{
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;

    extensions = [
      {
        id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
        crxPath = fetchCrx {
          name = "ublock-origin";
          url = mkCrxUrl "cjpalhdlnbpafiamejdnhcphjbkeiagm";
          sha256 = "sha256-bgLY5tzlae7HIbUx+cfShAPlQmRCQX1ahVoX3SiLVvg=";
        };
        version = "1.72.2";
      }
      {
        id = "dbepggeogbaibhgnhhndojpepiihcmeb";
        crxPath = fetchCrx {
          name = "vimium";
          url = mkCrxUrl "dbepggeogbaibhgnhhndojpepiihcmeb";
          sha256 = "sha256-MZjCaqcZvkYt6lhQUPvtm4uAYo1X6oihE7q/UzTFUXw=";
        };
        version = "2.4.2";
      }
      {
        id = "pkehgijcmpdhfbdbbnkijodmdjhbjlgp";
        crxPath = fetchCrx {
          name = "privacy-badger";
          url = mkCrxUrl "pkehgijcmpdhfbdbbnkijodmdjhbjlgp";
          sha256 = "sha256-r7/6OKSQ1D/45WoTsKS0+95ch7BtU9kImNnn4vzQj0A=";
        };
        version = "2026.6.16";
      }
      {
        id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";
        crxPath = fetchCrx {
          name = "dark-reader";
          url = mkCrxUrl "eimadpbcbfnmbkopoojfekhnkhdbieeh";
          sha256 = "sha256-ncsb1tytQ4kt3AKP9l+YLfPtuhNammRF5PpxZx43qhM=";
        };
        version = "4.9.129";
      }
    ];
  };
}

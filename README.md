# nixos-config

My NixOS dotfiles. Two machines (desktop + laptop), single user.

<img width="2160" height="1440" alt="image" src="https://github.com/user-attachments/assets/9d7e5695-7793-4dfd-a187-9b4af8c8d83e" />

## Stack

- **compositor:** [hyprland](https://github.com/hyprwm/Hyprland) (UWSM)
- **login manager:** tuigreet
- **session locking:** hyprlock + hypridle
- **bar:** waybar
- **launcher:** [rofi](https://github.com/davatorium/rofi)
- **terminal:** foot
- **browser:** firefox (with Firefox Containers & `resistFingerprinting`)
- **shell:** zsh (with carapace completions)
- **file manager:** thunar, yazi
- **editor:** zed
- **music:** mpd + rmpc
- **video:** mpv
- **screenshots:** grim + slurp + satty + wayfreeze, OCR via tesseract
- **clipboard:** wl-clip-persist (keeps clipboard alive across compositor restarts)
- **wallpaper:** swaybg, rofi thumbnail grid picker (`wallpicker`)
- **vpn:** throne (tun mode)
- **gtk theme:** adw-gtk3-dark
- **auth:** doas (sudo is disabled)
- **dns:** quad9 over tls, dnssec, no fallback
- **rebuilds:** nh

## Sandboxing

Some apps run inside bubblewrap sandboxes: `vesktop`, `telegram-desktop`, `qbittorrent`, and (when gaming is enabled) `steam`.

Each sandbox isolates the application with a tmpfs `$HOME`, strict file permissions, and **`xdg-dbus-proxy` filtering**. DBus session and system buses are proxy-filtered so applications can only interact with explicitly whitelisted interfaces (e.g., status tray notifications, MPRIS media controls, or screensaver/power management). GUI sandboxes get a portal-backed `xdg-open`/`xdg-email` on their `PATH` (`portalOpen`).
There's also a `code-shell` sandbox: a network-enabled, headless zsh environment scoped to `~/Code` for running untrusted project tooling without full home-directory access.

Defined in `home/sandbox.nix`, wrapper and proxy logic in `lib/mkSandbox.nix`.

Adding a new sandboxed app takes ~5 lines:

```nix
myapp = mkSandbox {
  name = "myapp";
  package = pkgs.myapp;
  preset = "gui";
  rwPaths = [ "${home}/.config/myapp" "${home}/Downloads" ];
};
```

## Screen capture

Hyprland's permission system is enforced (`ecosystem.enforce_permissions`). Only explicitly whitelisted binaries can grab the screen via `screencopy` - grim, wayfreeze, and the hyprland portal. Matching is by executable path, so this stops incidental capture, not an app that can exec `grim` itself. Firefox private windows and KeePassXC additionally carry `no_screen_share` rules.

## Hardening

Four toggleable modules under `modules/nixos/hardening/`:

- **kernel.basic** - `dmesg_restrict`, `kptr_restrict`, `sysrq` off, ASLR, protected symlinks/hardlinks/fifos/regular files, no core dumps (via sysctl and a hard PAM limit)
- **kernel.strict** - `ptrace_scope=2`, `perf_event_paranoid=3`, unprivileged BPF disabled. Breaks some anti-cheat software and profilers, so it's off on desktop and on for laptop
- **network** - no ICMP redirects, no source routing, log martians, SYN cookies, IPv6 privacy extensions
- **modules** - blacklists `parport`, `dccp`, `sctp`, `rds`, `tipc`, `can`, `atm`, `floppy`, `pcspkr`, `mac_hid`, `mousedev`, `mtd`/`spi_nor`, and other unused legacy drivers. Hard-disables `esp4`/`esp6`/`rxrpc` and blacklists Intel hardware telemetry modules (`intel_pmc_ssram_telemetry`, `pmt_*`)

## Theme management

Palettes live in `home/themes/`, one file per theme, selected with `theme` in `home/settings.nix` alongside the UI settings (`rounding`, `blur`, gaps). Both reach Home Manager modules via `_module.args`, so Waybar, Rofi, Foot, GTK, and Hyprland consume `theme` and `settings` directly. A theme states its core palette and the 8 ANSI colors; `mkTheme` in `home/themes/lib.nix` derives the rest, and misspelled keys fail the build. `mktheme` generates one from a wallpaper or hex color via [matugen](https://github.com/InioX/matugen) - `mktheme > home/themes/generated.nix`.

## Gaming

Gaming is opt-in per host (`modules.apps.gaming.enable`). Includes Steam (sandboxed), `gamescope`, `lact` (AMD GPU tuning), and 32-bit graphics support. `kernel.strict` is kept off on gaming hosts so anti-cheats don't complain, and `allow_tearing` is enabled in Hyprland.

## Virtualization (opt-in)

A `modules.apps.vm.enable` toggle exists for a full libvirt/virt-manager stack (with SPICE USB redirection) with NAT routing via `throne-tun`. Enabled on laptop.

## Hardware

Two host configs under `hosts/`:

- **desktop** - AMD GPU (`RADV`), dual monitor setup (2560x1440@180 + 1920x1080@240), gaming enabled, relaxed kernel hardening
- **laptop** - Intel GPU (`i915` + `iHD` media driver), power-profiles-daemon, strict kernel hardening, speaker fix script, VM enabled

GPU modules for AMD, Intel, and NVIDIA exist separately under `modules/nixos/hardware/`. Audio is driven by PipeWire (ALSA 32-bit disabled, 48kHz clock rate base with dynamic rate switching).

## Layout

```
flake.nix                  two inputs: nixpkgs, home-manager
lib/
  default.nix              mkHost factory
  mkSandbox.nix            bwrap wrapper + xdg-dbus-proxy setup
hosts/
  common/                  shared: doas, locale, nix settings, user
  desktop/                 amd, gaming, relaxed hardening
  laptop/                  intel, power management, strict hardening, vm
modules/nixos/
  hardening/               kernel.basic, kernel.strict, network, modules
  hardware/                amd, intel, nvidia, audio
  desktop/                 fonts, portals, thunar, hyprland
  networking.nix           quad9 dot, firewall, no bluetooth default
  apps.nix                 zsh, git, localsend, throne (vpn), gaming (gamescope+lact), docker, vm (libvirt, opt-in)
home/
  default.nix              imports themes, settings and home modules
  themes/                  one file per palette + mkTheme, exposed via _module.args
  settings.nix             ui settings (rounding, gaps, blur, animations)
  common.nix               gtk theme (adw-gtk3), cursor, icons, dotfile linking
  packages.nix             unsandboxed apps
  sandbox.nix              bwrap-wrapped apps (vesktop, telegram, qbittorrent, steam, code-shell)
  scripts.nix              screenshot helpers, wallpicker (rofi grid), hypr-zoom
  desktop/
    hyprland.nix           compositor config (lua) + autostart
    hyprlock.nix           lock screen configuration
    hypridle.nix           idle/power management
  apps/                    foot, fastfetch, firefox, rmpc, rofi, waybar, yazi, zsh, matugen, mime
dotfiles/                  mutable configs (zed, etc)
```

## Fair warning

This config is opinionated and makes choices that will lock you out of things if you don't understand them:

- `sudo` is fully disabled. If you don't know what `doas` is and you paste my config, you lose root access. Hope you kept a live usb around
- DNS has no fallback. Quad9 goes down or you hit a captive portal - no internet until you fix it manually
- Bluetooth is off by default
- Vesktop, telegram, and qbittorrent run inside bubblewrap sandboxes with heavy restrictions. They can't see your home directory, can't talk to most of your system, and will refuse to do things you might expect to work
- Several kernel hardening options are on. Things might not work and you won't know why until you read what `kernel.strict` does
- Theme and UI settings are driven from `home/themes/` and `home/settings.nix` via module arguments. To change themes, update `theme = "<name>";` in `home/settings.nix` and rebuild
- I mass-delete, rename, and restructure modules without warning. These are my personal dotfiles - if you fork this expecting stability you will have a bad time

# nixos-config

My NixOS dotfiles. Two machines (desktop + laptop), single user.

<img width="2160" height="1440" alt="image" src="https://github.com/user-attachments/assets/9d7e5695-7793-4dfd-a187-9b4af8c8d83e" />

## Stack

- **compositor:** [hyprland](https://github.com/hyprwm/Hyprland)
- **bar:** waybar
- **launcher:** [rofi](https://github.com/davatorium/rofi) (with `rofi-calc`)
- **terminal:** foot
- **browsers:** ungoogled-chromium (hardened, extensions pinned by hash), firefox (with Firefox Containers & `resistFingerprinting`)
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

Each sandbox isolates the application with a tmpfs `$HOME`, strict file permissions, and **`xdg-dbus-proxy` filtering**. DBus session and system buses are proxy-filtered so applications can only interact with explicitly whitelisted interfaces (e.g., status tray notifications, MPRIS media controls, or screensaver/power management).

There's also a `code-shell` sandbox: a network-enabled, headless zsh environment scoped to `~/Code` for running untrusted project tooling without full home-directory access.

AppArmor is enabled system-wide on top of bubblewrap.

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

Hyprland's permission system is enforced (`ecosystem.enforce_permissions`). Only explicitly whitelisted binaries can grab the screen via `screencopy` - grim, wayfreeze, and the hyprland portal. Anything else (including a compromised browser or a random Wayland client) is blocked at the compositor level. Firefox and Chromium private/incognito windows, as well as KeePassXC, additionally carry `no_screen_share` rules.

## Hardening

Four toggleable modules under `modules/nixos/hardening/`:

- **kernel.basic** - `dmesg_restrict`, `kptr_restrict`, `sysrq` off, ASLR, protected symlinks/hardlinks/fifos/regular files, no core dumps (via sysctl and a hard PAM limit)
- **kernel.strict** - `ptrace_scope=2`, `perf_event_paranoid=3`, unprivileged BPF disabled. Breaks some anti-cheat software and profilers, so it's off on desktop and on for laptop
- **network** - no ICMP redirects, no source routing, log martians, SYN cookies, IPv6 privacy extensions
- **modules** - blacklists `parport`, `dccp`, `sctp`, `rds`, `tipc`, `can`, `atm`, `floppy`, `pcspkr`, `mac_hid`, `mousedev`, `mtd`/`spi_nor`, and other unused legacy drivers. Hard-disables `esp4`/`esp6`/`rxrpc` and blacklists Intel hardware telemetry modules (`intel_pmc_ssram_telemetry`, `pmt_*`)

## Theme management

Theme palettes and UI settings (`rounding`, `border_size`, `blur`, `animations`, `gaps_in`, `gaps_out`) are configured in `home/theme.nix` and exposed globally to Home Manager modules via `_module.args`. Waybar, Rofi, Foot, GTK, and Hyprland consume `theme` and `settings` directly.

- **Theme presets:** `home/theme.nix` defines a library of color schemes (`omarchy`, `tokyo-night`, `neon-dusk`, `kanagawa`, `rosepine`, `mono`, `catppuccin`, `peppermint`, `oxocarbon`, `kanagawa-dragon`, `nightowl`, `lavender`). `nightowl` is currently selected.
- **Theme generation (`mktheme`):** The `mktheme` CLI tool uses [matugen](https://github.com/InioX/matugen) with custom blended color rules to generate a complete Nix theme attribute set to stdout. Running `mktheme` without arguments defaults to reading `~/.config/wallpaper`, or you can explicitly pass a hex color or image path (`mktheme #RRGGBB` or `mktheme /path/to/img`).

## Gaming

Gaming is opt-in per host (`modules.apps.gaming.enable`). Includes Steam (sandboxed), `gamescope`, `lact` (AMD GPU tuning), and 32-bit graphics support. `kernel.strict` is kept off on gaming hosts so anti-cheats don't complain, and `allow_tearing` is enabled in Hyprland.

## Virtualization (opt-in)

A `modules.apps.vm.enable` toggle exists for a full libvirt/virt-manager stack (with SPICE USB redirection), but it is disabled by default.

## Hardware

Two host configs under `hosts/`:

- **desktop** - AMD GPU (`RADV`), dual monitor setup (2560x1440@180 + 1920x1080@240), gaming enabled, relaxed kernel hardening
- **laptop** - Intel GPU (`i915` + `iHD` media driver), power-profiles-daemon, strict kernel hardening, speaker fix script

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
  laptop/                  intel, power management, strict hardening
modules/nixos/
  hardening/               kernel.basic, kernel.strict, network, modules
  hardware/                amd, intel, nvidia, audio
  desktop/                 fonts, portals, thunar, hyprland
  networking.nix           quad9 dot, firewall, no bluetooth default
  apps.nix                 zsh, git, localsend, throne (vpn), gaming (gamescope+lact), docker, vm (libvirt, opt-in)
  sandbox.nix              apparmor + bwrap
home/
  default.nix              imports theme.nix and home modules
  theme.nix                theme palette library and settings exposed via _module.args
  common.nix               gtk theme (adw-gtk3), cursor, icons, dotfile linking
  packages.nix             unsandboxed apps
  sandbox.nix              bwrap-wrapped apps (vesktop, telegram, qbittorrent, steam, code-shell)
  scripts.nix              screenshot helpers, wallpicker (rofi grid), hypr-zoom
  desktop/hyprland.nix     compositor config + autostart
  apps/                    foot, fastfetch, firefox, rmpc, rofi, waybar, yazi, zsh, chromium, matugen
dotfiles/                  mutable configs (zed, etc)
```

## Fair warning

This config is opinionated and makes choices that will lock you out of things if you don't understand them:

- `sudo` is fully disabled. If you don't know what `doas` is and you paste my config, you lose root access. Hope you kept a live usb around
- DNS has no fallback. Quad9 goes down or you hit a captive portal - no internet until you fix it manually
- Bluetooth is off by default
- Vesktop, telegram, and qbittorrent run inside bubblewrap sandboxes with heavy restrictions. They can't see your home directory, can't talk to most of your system, and will refuse to do things you might expect to work
- Several kernel hardening options are on. Things might not work and you won't know why until you read what `kernel.strict` does
- No login manager (SDDM, etc.). Autologin on both devices is on by default. If you disable autologin, you will have to login through tty1
- Theme and UI settings are driven from `home/theme.nix` via module arguments. To change themes, update `theme = themes.<name>;` in `home/theme.nix` and rebuild
- I mass-delete, rename, and restructure modules without warning. These are my personal dotfiles, not a framework - if you fork this expecting stability you will have a bad time

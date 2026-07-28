# nixos-config

My nixos dotfiles. Two machines (desktop + laptop), single user.

<img width="2160" height="1440" alt="image" src="https://github.com/user-attachments/assets/9d7e5695-7793-4dfd-a187-9b4af8c8d83e" />

## Stack

- **compositor:** [hyprland](https://github.com/hyprwm/Hyprland)
- **bar:** waybar
- **launcher:** fuzzel
- **terminal:** foot
- **browsers:** ungoogled-chromium (hardened, extensions pinned by hash), firefox
- **shell:** zsh (with carapace completions)
- **file manager:** thunar, yazi
- **editor:** zed
- **music:** mpd + rmpc
- **video:** mpv
- **screenshots:** grim + slurp + satty + wayfreeze, ocr via tesseract
- **clipboard:** wl-clip-persist (keeps clipboard alive across compositor restarts)
- **wallpaper:** swaybg, fuzzel as picker (`wallpicker`)
- **vpn:** throne (tun mode)
- **auth:** doas (sudo is disabled)
- **dns:** quad9 over tls, dnssec, no fallback
- **rebuilds:** nh

## Sandboxing

Some apps run inside bubblewrap sandboxes: vesktop, telegram-desktop, qbittorrent, and (when gaming is enabled) steam. There's also a `code-shell` sandbox: a network-enabled, headless zsh environment scoped to `~/Code` for running untrusted project tooling without full home-directory access. Each sandbox gets a tmpfs `$HOME` and can only write to the paths it's explicitly given (usually its own config dir + `~/Downloads`, or a working directory for `code-shell`). Defined in `home/sandbox.nix`, wrapper logic in `lib/mkSandbox.nix`.

Apparmor is enabled system-wide on top of that.

Adding a new sandboxed app is ~5 lines:

```nix
myapp = mkSandbox {
  name = "myapp";
  package = pkgs.myapp;
  rwPaths = [ "${home}/.config/myapp" "${home}/Downloads" ];
};
```

> Discord (non-Vencord build) is defined but commented out in `home/sandbox.nix`. Vesktop is the one actually installed.

## Screen capture

Hyprland's permission system is enforced (`ecosystem.enforce_permissions`). Only explicitly whitelisted binaries can grab the screen via `screencopy` - grim, wayfreeze, and the hyprland portal. Anything else (including a compromised browser or a random Wayland client) is blocked at the compositor. Firefox and Chromium private/incognito windows, and KeePassXC, additionally carry `no_screen_share` rules so they never show up in a screenshare picker.

## Hardening

Four toggleable modules under `modules/nixos/hardening/`:

- **kernel.basic** - dmesg_restrict, kptr_restrict, sysrq off, aslr, protected symlinks/hardlinks/fifos/regular files, no core dumps (via sysctl and a hard pam limit)
- **kernel.strict** - ptrace_scope=2, perf_event_paranoid=3, unprivileged bpf disabled. Breaks some anti-cheat and profilers, so it's off on desktop and on for laptop
- **network** - no redirects, no source routing, log martians, syn cookies, ipv6 privacy extensions
- **modules** - blacklists parport, dccp, sctp, rds, tipc, can, atm, floppy, pcspkr, mac_hid, mousedev, mtd/spi_nor, and other stuff you don't need. Also hard-disables `esp4`/`esp6`/`rxrpc` and blacklists Intel's hardware telemetry modules (`intel_pmc_ssram_telemetry`, `pmt_*`)

## Theme management

Theme palette and UI settings (rounding, blur, animations) are configured in `home/theme.nix` and exposed globally to Home Manager modules via `_module.args`. Waybar, Fuzzel, Foot, and Hyprland consume `theme` and `settings` directly.

- **Theme presets:** `home/theme.nix` defines a library of hand-crafted color schemes (omarchy, tokyo-night, neon-dusk, kanagawa, rosepine, mono, catppuccin, peppermint, sakura, orchid, mochi, nightowl, rosewood). `nightowl` is currently selected.
- **Theme generation (`mktheme`):** The `mktheme` CLI tool uses [matugen](https://github.com/InioX/matugen) with custom blended color rules to generate a complete Nix theme attribute set to stdout. Running `mktheme` without arguments defaults to reading `~/.config/wallpaper`, or you can explicitly pass a hex color or image path (`mktheme #RRGGBB` or `mktheme /path/to/img`).

## Gaming

Desktop has steam (sandboxed) + gamescope + lact (amd gpu tuning). `kernel.strict` is off so anti-cheats don't complain. `allow_tearing` is on globally;

## Virtualization (opt-in)

A `modules.apps.vm.enable` toggle exists for a full libvirt/virt-manager stack (with spice USB redirection), but it's off on both hosts by default.

## Hardware

Two host configs under `hosts/`:

- **desktop** - amd gpu (radv), dual monitor (2560x1440@180 + 1920x1080@240), gaming enabled
- **laptop** - power-profiles-daemon, strict hardening, no gaming

GPU modules for amd and nvidia exist separately under `modules/nixos/hardware/`. Audio is pipewire (no jack).

## Layout

```
flake.nix                  two inputs: nixpkgs, home-manager
lib/
  default.nix              mkHost factory
  mkSandbox.nix            bwrap wrapper
hosts/
  common/                  shared: doas, locale, nix settings, user
  desktop/                 amd, gaming, relaxed hardening
  laptop/                  power management, strict hardening
modules/nixos/
  hardening/               kernel.basic, kernel.strict, network, modules
  hardware/                amd, nvidia, audio
  desktop/                 fonts, portals, thunar, hyprland
  networking.nix           quad9 dot, firewall, no bluetooth default
  apps.nix                 zsh, git, localsend, throne (vpn), gaming (gamescope+lact), docker, vm (libvirt, opt-in)
  sandbox.nix              apparmor + bwrap
home/
  default.nix              imports theme.nix and home modules
  theme.nix                theme palette library and settings exposed via _module.args
  common.nix               gtk theme, cursor, icons, dotfile linking
  packages.nix             unsandboxed apps
  sandbox.nix              bwrap-wrapped apps (vesktop, telegram, qbittorrent, steam, code-shell)
  scripts.nix              screenshot helpers, wallpicker, hypr-zoom
  desktop/hyprland.nix     compositor config + autostart
  apps/                    foot, fastfetch, fuzzel, firefox, rmpc, waybar, yazi, zsh, chromium, matugen
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

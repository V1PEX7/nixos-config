# nixos-config

My nixos dotfiles. Two machines (desktop + laptop), single user.

<img width="2558" height="1440" alt="image" src="https://github.com/user-attachments/assets/0bc053c6-85d2-41fa-a75e-cbc1f2ab99e5" />

## Stack

- **compositor:** [mangowm](https://github.com/mangowm/mango)
- **bar:** waybar
- **launcher:** fuzzel
- **terminal:** foot
- **browsers:** ungoogled-chromium, librewolf
- **shell:** zsh (with carapace completions)
- **file manager:** thunar
- **editor:** zed
- **music:** mpd + rmpc
- **video:** mpv
- **screenshots:** grim + slurp + satty + wayfreeze, ocr via tesseract
- **clipboard:** cliphist + wl-clip-persist, fuzzel as picker
- **wallpaper:** swaybg, fuzzel as picker
- **vpn:** throne (tun mode)
- **auth:** doas (sudo is disabled)
- **dns:** quad9 over tls, dnssec, no fallback

## Sandboxing

Some apps run inside bubblewrap sandboxes: vesktop, discord, telegram-desktop, obsidian, qbittorrent. Each gets a tmpfs `$HOME` and can only write to its own config dir + `~/Downloads`. Defined in `home/sandbox.nix`, wrapper logic in `lib/mkSandbox.nix`.

Apparmor is enabled system-wide on top of that.

Adding a new sandboxed app is ~5 lines:

```nix
myapp = mkSandbox {
  name = "myapp";
  package = pkgs.myapp;
  rwPaths = [ "${home}/.config/myapp" "${home}/Downloads" ];
};
```

## Hardening

Four toggleable modules under `modules/nixos/hardening/`:

- **kernel.basic** - dmesg_restrict, kptr_restrict, sysrq off, aslr, protected symlinks/hardlinks/fifos, no core dumps
- **kernel.strict** - ptrace_scope=2, perf_event_paranoid=3, unprivileged bpf disabled. Breaks some anti-cheat and profilers, so it's off on desktop and on for laptop
- **network** - no redirects, no source routing, log martians, syn cookies, ipv6 privacy extensions
- **modules** - blacklists parport, dccp, sctp, rds, tipc, can, atm, floppy, pcspkr, and other stuff you don't need

## Theme switching

`home/theme.nix` defines color palettes. waybar, fuzzel, foot, and mango borders all read from it. Change the last line:

```
themes.omarchy       - zinc/cream/orange
themes.tokyo-night   - navy/cyan/purple
themes.neon-dusk     - near-black/electric cyan/pink
themes.kanagawa      - indigo/wave blue
themes.rosepine      - warm dark/iris purple
themes.mono          - the name speaks for itself
```

Rebuild. Everything switches.

## Gaming

Desktop has steam + proton-ge + lact (amd gpu tuning). `kernel.strict` is off so anti-cheats don't complain. Games on tag 6 get `force_tearing:1`.

## Hardware

Two host configs under `hosts/`:

- **desktop** - amd gpu (radv), dual monitor (2560x1440@180 + 1920x1080@240), gaming enabled
- **laptop** - power-profiles-daemon, strict hardening, no gaming

GPU modules for amd and nvidia exist separately under `modules/nixos/hardware/`. Audio is pipewire (no jack).

## Layout

```
flake.nix                  three inputs: nixpkgs, home-manager, mango
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
  desktop/                 fonts, portals, thunar, mango
  networking.nix           quad9 dot, firewall, no bluetooth default
  apps.nix                 zsh, git, throne, localsend, steam, docker
  sandbox.nix              apparmor + bwrap
home/
  theme.nix                color palettes
  common.nix               gtk theme, cursor, icons, dotfile linking
  packages.nix             unsandboxed apps
  sandbox.nix              bwrap-wrapped apps
  scripts.nix              screenshot helpers, wallpicker
  desktop/mangowc.nix      compositor config + autostart
  apps/                    foot, fastfetch, fuzzel, librewolf, rmpc, waybar, zsh
dotfiles/                  mutable configs (zed, etc)
```

## Fair warning

This config is opinionated and makes choices that will lock you out of things if you don't understand them:

- `sudo` is fully disabled. If you don't know what `doas` is and you paste my config, you lose root access. Hope you kept a live usb around
- DNS has no fallback. Quad9 goes down or you hit a captive portal - no internet until you fix it manually
- Bluetooth is off by default
- Vesktop, telegram, obsidian, and qbittorrent run inside bubblewrap sandboxes with heavy restrictions. They can't see your home directory, can't talk to most of your system, and will refuse to do things you might expect to work
- Several kernel hardening options are on. Things might not work and you won't know why until you read what `kernel.strict` does
- No login manager (SDDM, etc.). Autologin on both devices is on by default. If you disable autologin, you will have to login through tty1
- I mass-delete, rename, and restructure modules without warning. These are my personal dotfiles, not a framework - if you fork this expecting stability you will have a bad time

# NixOS Personal Configuration
**Host:** `NixOSThinkpadX1C9`
**User:** Danny Kurniawan
**NixOS Version:** 26.05
**Timezone:** Asia/Jakarta (WIB, UTC+7)

---
![Screenshot](https://github.com/dnnykur/nix/blob/main/photo_2026-06-07_11-26-42.jpg?raw=true)

## Overview

This is my personal NixOS `configuration.nix` for a **ThinkPad X1 Carbon (Gen 9)**. It sets up a KDE Plasma 6 desktop.

---

## System

| Component | Value |
|-----------|-------|
| Bootloader | systemd-boot (EFI) |
| Kernel | `linuxPackages_latest` |
| Boot splash | Plymouth with `nixos-bgrt` theme |
| Filesystems | NTFS, Btrfs |
| Swap | zRAM (zstd, 50% RAM) |
| Locale | `en_US.UTF-8` |

---

## Desktop

- **Display Manager:** Plasma Login Manager
- **Desktop Environment:** KDE Plasma 6
- **Audio:** PipeWire (PulseAudio compat + ALSA + JACK + WirePlumber)
- **Input:** libinput
- **Printing:** enabled

---

## Hardware

### Intel GPU (i915)
- Intel Media Driver (VAAPI)
- Intel Compute Runtime + Level Zero (OpenCL)
- Vulkan (loader, validation layers, tools)
- 32-bit graphics support enabled
- PSR (Panel Self-Refresh) enabled via kernel param

### Bluetooth
- Enabled on boot
- Experimental features enabled (battery level, etc.)

### Other
- ACPI backlight control (`acpilight`)
- Keyboard backlight control (`kbdlight`)
- Fingerprint reader (`fprintd`)
- Intel GPU tools

---

## Networking

- **NetworkManager** for connection management
- **DNSCrypt-proxy** for encrypted DNS
  - Resolvers: Cloudflare, Google (IPv4 + IPv6)
  - Listening on `127.0.0.1:53` and `[::1]:53`
  - `require_nolog` and `require_nofilter` enforced

---

## Virtualisation & Containers

- **libvirtd** + **virt-manager** — full VM management (KVM/QEMU)
- **Podman** with Docker compatibility shim
- **Distrobox** — run other Linux distros in containers

---

## Applications

### Internet & Communication
- Firefox, Brave
- Vesktop (Discord client), Telegram Desktop
- qBittorrent
- KDE Connect

### Development
- Git, Vim, Neovim, VSCode
- Python 3
- Android Tools (ADB/Fastboot)

### Gaming
- Steam
- Prism Launcher (Minecraft)
- ProtonPlus (Proton version manager)
- MangoHud + GOverlay (performance overlay)
- GPU Screen Recorder + GTK GUI

### Media & Creative
- MPV (video player)
- GIMP (image editing)
- Kdenlive (video editing)
- EasyEffects (audio processing)
- Gwenview, Spectacle (KDE image viewer & screenshot)

### Office & Productivity
- LibreOffice
- OnlyOffice Desktop Editors
- KCalc, Ark, Dolphin (KDE utilities)

### System Utilities
- btop, fastfetch
- GParted, btrfs-progs
- efibootmgr
- tree, wget

---

## Fonts

| Category | Primary | Fallback |
|----------|---------|---------|
| Sans-serif | Liberation Sans | Noto Sans |
| Serif | Liberation Serif | Noto Serif |
| Monospace | Liberation Mono | Noto Sans Mono |
| Emoji | Noto Color Emoji | — |

Additional packages: JetBrains Mono Nerd Font, Noto CJK (Sans + Serif), Core Fonts.

Font rendering: antialiasing enabled, full hinting, no subpixel (suitable for non-ClearType displays).

---

## Portals & Flatpak

- Flatpak enabled
- XDG portal: `xdg-desktop-portal-gtk` (default: `gtk`)

---

## User Groups

User `danny` belongs to:
- `wheel` — sudo access
- `libvirtd`, `kvm` — virtualisation
- `adbusers` — Android debugging

---

## GPU Screen Recorder

`gsr-kms-server` is wrapped with `cap_sys_admin` capability for KMS-based screen capture without needing a full root process.

---

## Rebuilding

```bash
# Apply configuration changes
sudo nixos-rebuild switch

# Test without making it the default boot entry
sudo nixos-rebuild test

# Build without activating
sudo nixos-rebuild build
```

---

## File Structure

```
/etc/nixos/
├── configuration.nix       # This file — main system config
└── hardware-configuration.nix  # Auto-generated hardware config
```

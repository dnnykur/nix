# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.grub.enable = false;
  boot.supportedFilesystems = [ "ntfs" "btrfs" ];

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  boot.plymouth = {
    enable = true;
    theme = "nixos-bgrt";
    themePackages = [ pkgs.nixos-bgrt-plymouth ];
  };

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  boot.initrd.systemd.enable = true;

  boot.kernelParams = [
    "quiet"
    "splash"
    "i915.enable_psr=1"
  ];

  networking.hostName = "NixOSThinkpadX1C9";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Jakarta";
  i18n.defaultLocale = "en_US.UTF-8";

  services = {
    xserver.enable = true;

    displayManager = {
      plasma-login-manager = {
        enable = true;
      };
    };

    desktopManager.plasma6.enable = true;
    printing.enable = true;
    libinput.enable = true;

    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
  };

  hardware.intel-gpu-tools.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime
      level-zero
      vulkan-loader
      vulkan-validation-layers
      vulkan-tools
    ];

    extraPackages32 = with pkgs.pkgsi686Linux; [
      intel-media-driver
    ];
  };

  services.dnscrypt-proxy = {
  enable = true;
  settings = {
    server_names = [ "cloudflare" "cloudflare-ipv6" "google" "google-ipv6" ];

    listen_addresses = [ "127.0.0.1:53" "[::1]:53" ];
    require_dnssec = false;
    require_nolog  = true;
    require_nofilter = true;

    sources.public-resolvers = {
      urls = [
        "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
        "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/cache/dnscrypt-proxy/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };
    };
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General.Experimental = true;
  };

  users.users.danny = {
    isNormalUser = true;
    description = "Danny Kurniawan";
    extraGroups = [ "wheel" "libvirtd" "kvm" "adbusers"];
    packages = with pkgs; [
      tree
    ];
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  hardware.acpilight.enable = true;
  programs.firefox.enable = true;
  programs.kbdlight.enable = true;
  programs.kdeconnect.enable = true;
  services.flatpak.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "gtk";

  security.wrappers.gsr-kms-server = {
    source = "${pkgs.gpu-screen-recorder}/bin/gsr-kms-server";
    capabilities = "cap_sys_admin+ep";
    owner = "root";
    group = "root";
  };

  fonts.enableDefaultPackages = true;
  fonts.fontconfig = {
  enable = true;
  antialias = true;

  hinting = {
    enable = true;
    autohint = false;
    style = "full";
  };

  subpixel = {
    rgba = "none";
    lcdfilter = "none";
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    btrfs-progs
    git
    android-tools
    btop
    kdePackages.dolphin
    kdePackages.ark
    kdePackages.gwenview
    kdePackages.spectacle
    kdePackages.kcalc
    mpv
    steam
    libreoffice
    corefonts
    gparted
    fastfetch
    neovim
    easyeffects
    gimp
    kdePackages.kdenlive
    fprintd
    vscode
    efibootmgr
    vesktop
    telegram-desktop
    prismlauncher
    protonplus
    distrobox
    python3
    mangohud
    goverlay
    dnsmasq
    onlyoffice-desktopeditors
    brave
    qbittorrent
    gpu-screen-recorder
    gpu-screen-recorder-gtk
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    liberation_ttf
  ];

  fonts.fontconfig.defaultFonts = {
    sansSerif = [ "Liberation Sans" "Noto Sans" ];
    serif     = [ "Liberation Serif" "Noto Serif" ];
    monospace = [ "Liberation Mono" "Noto Sans Mono" ];
    emoji     = [ "Noto Color Emoji" ];
  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "26.05";
}

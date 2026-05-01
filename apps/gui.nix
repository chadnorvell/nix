{ pkgs, ... }:
{
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  environment.systemPackages = with pkgs; [
    blender
    calibre
    chromium
    darktable
    discord
    firefox
    gimp
    (google-chrome.override {
      commandLineArgs = [
        "--ozone-platform=wayland"
        "--enable-features=UseOzonePlatform,VaapiVideoDecodeLinuxGL,VaapiVideoEncoder,Vulkan,VulkanFromANGLE,DefaultANGLEVulkan,VaapiIgnoreDriverChecks,VaapiVideoDecoder,PlatformHEVCDecoderSupport,UseMultiPlaneFormatForHardwareVideo"
      ];
    })
    hunspell
    hunspellDicts.en_US
    hyphenDicts.en_US
    inkscape
    kicad
    kitty
    libreoffice-fresh
    mpv
    obsidian
    openscad
    orca-slicer
    proton-pass
    protonmail-bridge
    qbittorrent
    signal-desktop
    sqlitebrowser
    sublime-merge
    sublime4
    thunderbird
    vlc
    vscode-fhs
    wl-clipboard
    zathura
    zoom-us
  ];

  fonts.packages = with pkgs; [
    font-awesome
    iosevka
    libertine
    nerd-fonts.iosevka
    nerd-fonts.symbols-only
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    source-code-pro
    source-han-code-jp
    source-han-mono
    source-han-sans
    source-han-serif
    source-sans
    source-serif
    ubuntu-sans
    ubuntu-sans-mono
  ];
}

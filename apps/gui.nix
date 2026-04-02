{ pkgs, ... }:
{
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
    meld
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
    zoom-us
  ];

  fonts.packages = with pkgs; [
    font-awesome
    iosevka
    libertine
    nerd-fonts.iosevka
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    ubuntu-sans
    ubuntu-sans-mono
  ];
}

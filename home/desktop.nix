{ nixDir }:
{ lib, pkgs, ... }:
let
  google-chrome = "google-chrome";

  googleChromePersonalProfile = {
    name = "Default";
    displayName = "Personal";
  };

  googleChromeCalcbaseProfile = {
    name = "Calcbase";
    displayName = "Calcbase";
  };

  googleChromeForProfile = profile: {
    "google-chrome-${profile.name}" = {
      name = "Google Chrome (${profile.displayName})";
      genericName = "Web Browser";
      comment = "Access the Internet";
      icon = "google-chrome";
      type = "Application";
      exec = "${google-chrome} --profile-directory=${profile.name} %U";
      terminal = false;
      startupNotify = true;

      categories = [
        "Network"
        "WebBrowser"
      ];

      mimeType = [
        "application/pdf"
        "application/rdf+xml"
        "application/rss+xml"
        "application/xhtml+xml"
        "application/xhtml_xml"
        "application/xml"
        "image/gif"
        "image/jpeg"
        "image/png"
        "image/webp"
        "text/html"
        "text/xml"
        "x-scheme-handler/http"
        "x-scheme-handler/https"
        "x-scheme-handler/google-chrome"
      ];

      actions = {
        new-window = {
          name = "New Window";
          exec = "${google-chrome} --profile-directory=${profile.name}";
        };
      };
    };
  };

  googleChromePwas = {
    "Google Chat" = {
      appId = "mdpkiolbdkhdjpekfbkbmhigcaggjagi";
      profile = googleChromeCalcbaseProfile;
      icon = "cxn-google-chat";
      categories = [ "Network" ];
    };

    "Google Messages" = {
      appId = "hpfldicfbfomlpcikngkocigghgafkph";
      profile = googleChromePersonalProfile;
      icon = "cxn-google-messages";
      categories = [ "Network" ];
    };

    "TickTick" = {
      appId = "cfammbeebmjdpoppachopcohfchgjapd";
      profile = googleChromePersonalProfile;
      icon = "cxn-ticktick";
      categories = [ "Office" ];
    };

    "WhatsApp" = {
      appId = "hnpfjngllnobngcgfapefoaidbinmjnm";
      profile = googleChromePersonalProfile;
      icon = "cxn-whatsapp";
      categories = [ "Network" ];
    };
  };

  makeGoogleChromePwa =
    key: data:
    lib.nameValuePair ("chrome-${data.appId}-${data.profile.name}") ({
      name = key;
      type = "Application";
      terminal = false;
      icon = data.icon;
      exec = "${google-chrome} --profile-directory=${data.profile.name} --app-id=${data.appId}";
      categories = data.categories;
      settings.StartupWMClass = "crx_${data.appId}";
    });

  svgIcons = [
    "cxn-google-chat.svg"
    "cxn-google-messages.svg"
    "cxn-whatsapp.svg"
  ];

  copySvgIcons = lib.listToAttrs (
    map (f: {
      name = ".local/share/icons/${f}";
      value.source = "${nixDir.home}/icons/${f}";
    }) svgIcons
  );

  hicolorIcons = [
    "cxn-ticktick.png"
  ];

  copyHicolorIcons = lib.listToAttrs (
    lib.lists.crossLists
      (f: d: {
        name = ".local/share/icons/hicolor/${d}/apps/${f}";
        value.source = "${nixDir.home}/icons/hicolor/${d}/apps/${f}";
      })
      [
        hicolorIcons
        [
          "32x32"
          "48x48"
          "128x128"
          "256x256"
          "512x512"
        ]
      ]
  );
in
{
  home.file = copySvgIcons // copyHicolorIcons;

  xdg.desktopEntries =
    googleChromeForProfile googleChromePersonalProfile
    // googleChromeForProfile googleChromeCalcbaseProfile
    // lib.attrsets.mapAttrs' makeGoogleChromePwa googleChromePwas;

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "application/pdf" = [ "org.kde.okular.desktop" ];
      "image/jpeg" = [ "org.kde.gwenview.desktop" ];
      "image/png" = [ "org.kde.gwenview.desktop" ];
      "inode/directory" = [ "org.kde.dolphin.desktop" ];
      "text/html" = [ "google-chrome.desktop" ];

      "x-scheme-handler/http" = [ "google-chrome.desktop" ];
      "x-scheme-handler/https" = [ "google-chrome.desktop" ];
      "x-scheme-handler/about" = [ "google-chrome.desktop" ];
      "x-scheme-handler/unknown" = [ "google-chrome.desktop" ];

      "x-scheme-handler/obsidian" = [ "obsidian.desktop" ];
    };
  };

  # Apps may mutate this file; uncomment to force overwrite it
  # xdg.configFile."mimeapps.list".force = true;
}

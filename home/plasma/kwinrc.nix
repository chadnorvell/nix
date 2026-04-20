let
  karouselWindowRulesJson = ''
    [
      {
          "class": "(org\\.kde\\.)?plasmashell",
          "tile": false
      },
      {
          "class": "(org\\.kde\\.)?polkit-kde-authentication-agent-1",
          "tile": false
      },
      {
          "class": "(org\\.kde\\.)?kded6",
          "tile": false
      },
      {
          "class": "(org\\.kde\\.)?kcalc",
          "tile": false
      },
      {
          "class": "(org\\.kde\\.)?kfind",
          "tile": true
      },
      {
          "class": "(org\\.kde\\.)?kruler",
          "tile": false
      },
      {
          "class": "(org\\.kde\\.)?krunner",
          "tile": false
      },
      {
          "class": "(org\\.kde\\.)?yakuake",
          "tile": false
      },
      {
          "class": "(org\\.kde\\.)?systemsettings",
          "title": "Configure — System Settings",
          "tile": false
      },
      {
          "class": "1password",
          "tile": false
      },
      {
          "class": "electron",
          "title": "Proton Pass",
          "tile": false
      },
      {
          "class": "steam",
          "caption": "Steam Big Picture Mode",
          "tile": false
      },
      {
          "class": "zoom",
          "caption": "Zoom Cloud Meetings|zoom|zoom <2>",
          "tile": false
      },
      {
          "class": "jetbrains-.*",
          "caption": "splash",
          "tile": false
      },
      {
          "class": "jetbrains-.*",
          "caption": "Unstash Changes|Paths Affected by stash@.*",
          "tile": true
      }
    ]
  '';
in
{
  Windows = {
    DelayFocusInterval = 150;
    ElectricBorderMaximize = false;
    ElectricBorderTiling = false;
    FocusPolicy = "FocusFollowsMouse";
  };

  Desktops = {
    Rows = 1;
    Number = 10;
    Id_1 = "b1f3eb01-33ca-4497-b358-48b43ae2b56f";
    Id_2 = "081a82a3-4a0d-4176-9427-6dfd5446420c";
    Id_3 = "4f187ce6-9b13-4920-9a69-4a50bb083b39";
    Id_4 = "014d69cd-2a7c-464b-8090-9ed701509568";
    Id_5 = "2cd0334f-f953-43d7-94fe-7121ca7b2ebe";
    Id_6 = "00dd3d14-41c3-4edf-9003-43704d7f3b08";
    Id_7 = "853801c1-520b-4b56-8222-18af6a8f8ff4";
    Id_8 = "4b452d73-865d-4743-912b-37ab18ddd1fa";
    Id_9 = "fdf2cffb-6e3b-461f-97bb-40c8c8ec0b02";
    Id_10 = "520011d0-7c1e-4496-8e09-4bcc813f633d";
  };

  Plugins = {
    karouselEnabled = true;
    kwin4_effect_geometry_changeEnabled = true;
    slideEnabled = false;
    virtualdesktopsonlyonprimaryEnabled = true;
  };

  "Script-karousel" = {
    gapsOuterBottom = 8;
    gapsOuterLeft = 8;
    gapsOuterRight = 8;
    gapsOuterTop = 8;
    gestureScroll = true;
    presetWidths = "33.333333%, 50%, 66.666667%, 100%";
    resizeNeighborColumn = true;
    tiledDesktops = "Desktop\\s\\d$";

    windowRules = karouselWindowRulesJson;
  };
}

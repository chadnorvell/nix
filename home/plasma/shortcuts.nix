let
  bind = primary: label: [
    primary
    "none"
    label
  ];

  bind2 = primary: secondary: label: [
    primary
    secondary
    label
  ];

  disable = label: [
    "none"
    "none"
    label
  ];
in
{
  kwin = {
    # KWin bindings
    "Kill Window" = "Meta+Ctrl+Esc";
    "Switch to Desktop 1" = "Meta+1";
    "Switch to Desktop 2" = "Meta+2";
    "Switch to Desktop 3" = "Meta+3";
    "Switch to Desktop 4" = "Meta+4";
    "Switch to Desktop 5" = "Meta+5";
    "Switch to Desktop 6" = "Meta+6";
    "Switch to Desktop 7" = "Meta+7";
    "Switch to Desktop 8" = "Meta+8";
    "Switch to Desktop 9" = "Meta+9";
    "Switch to Desktop 10" = "Meta+10";
    "Window Close" = "Meta+Q";

    # Karousel focus movement
    "karousel-focus-left" = bind2 "Meta+H" "Meta+[" "Karousel: Move focus left";
    "karousel-focus-down" = bind "Meta+J" "Karousel: Move focus down";
    "karousel-focus-up" = bind "Meta+K" "Karousel: Move focus up";
    "karousel-focus-right" = bind2 "Meta+L" "Meta+]" "Karousel: Move focus right";

    # Karousel window movement
    "karousel-window-move-left" = bind "Meta+Ctrl+H" "Karousel: Move window left";
    "karousel-window-move-down" = bind "Meta+Ctrl+J" "Karousel: Move window down";
    "karousel-window-move-up" = bind "Meta+Ctrl+K" "Karousel: Move window up";
    "karousel-window-move-right" = bind "Meta+Ctrl+L" "Karousel: Move window right";

    # Karousel column movement
    "karousel-column-move-left" = bind "Meta+{" "Karousel: Move column left";
    "karousel-column-move-right" = bind "Meta+}" "Karousel: Move column right";
    "karousel-column-move-to-desktop-1" = bind "Meta+!" "Karousel: Move column to desktop 1";
    "karousel-column-move-to-desktop-2" = bind "Meta+@" "Karousel: Move column to desktop 2";
    "karousel-column-move-to-desktop-3" = bind "Meta+#" "Karousel: Move column to desktop 3";
    "karousel-column-move-to-desktop-4" = bind "Meta+$" "Karousel: Move column to desktop 4";
    "karousel-column-move-to-desktop-5" = bind "Meta+%" "Karousel: Move column to desktop 5";
    "karousel-column-move-to-desktop-6" = bind "Meta+^" "Karousel: Move column to desktop 6";
    "karousel-column-move-to-desktop-7" = bind "Meta+&" "Karousel: Move column to desktop 7";
    "karousel-column-move-to-desktop-8" = bind "Meta+*" "Karousel: Move column to desktop 8";
    "karousel-column-move-to-desktop-9" = bind "Meta+(" "Karousel: Move column to desktop 9";
    "karousel-column-move-to-desktop-10" = bind "Meta+)" "Karousel: Move column to desktop 10";
    "karousel-tail-move-to-desktop-1" =
      bind "Meta+Ctrl+1" "Karousel: Move this and all following columns to desktop 1";
    "karousel-tail-move-to-desktop-2" =
      bind "Meta+Ctrl+2" "Karousel: Move this and all following columns to desktop 2";
    "karousel-tail-move-to-desktop-3" =
      bind "Meta+Ctrl+3" "Karousel: Move this and all following columns to desktop 3";
    "karousel-tail-move-to-desktop-4" =
      bind "Meta+Ctrl+4" "Karousel: Move this and all following columns to desktop 4";
    "karousel-tail-move-to-desktop-5" =
      bind "Meta+Ctrl+5" "Karousel: Move this and all following columns to desktop 5";
    "karousel-tail-move-to-desktop-6" =
      bind "Meta+Ctrl+6" "Karousel: Move this and all following columns to desktop 6";
    "karousel-tail-move-to-desktop-7" =
      bind "Meta+Ctrl+7" "Karousel: Move this and all following columns to desktop 7";
    "karousel-tail-move-to-desktop-8" =
      bind "Meta+Ctrl+8" "Karousel: Move this and all following columns to desktop 8";
    "karousel-tail-move-to-desktop-9" =
      bind "Meta+Ctrl+9" "Karousel: Move this and all following columns to desktop 9";
    "karousel-tail-move-to-desktop-10" =
      bind "Meta+Ctrl+0" "Karousel: Move this and all following columns to desktop 10";

    # Karousel scrolling
    "karousel-grid-scroll-start" = bind "Meta+<" "Karousel: Scroll to start";
    "karousel-grid-scroll-end" = bind "Meta+>" "Karousel: Scroll to end";
    "karousel-grid-scroll-left-column" = bind "Meta+\\," "Karousel: Scroll one column to the left";
    "karousel-grid-scroll-right-column" = bind "Meta+." "Karousel: Scroll one column to the right";
    "karousel-grid-scroll-left" = bind "Meta+Ctrl+\\," "Karousel: Scroll left";
    "karousel-grid-scroll-right" = bind "Meta+Ctrl+." "Karousel: Scroll right";

    # Karousel column width adjustment
    "karousel-columns-width-equalize" = bind "Meta+=" "Karousel: Equalize widths of visible columns";
    "karousel-cycle-preset-widths" = bind "Meta+Ctrl+]" "Karousel: Cycle through preset column widths";
    "karousel-cycle-preset-widths-reverse" =
      bind "Meta+Ctrl+[" "Karousel: Cycle through preset column widths in reverse";

    # Karousel window toggles
    "karousel-grid-scroll-focused" = bind "Meta+Shift+Return" "Karousel: Center focused window";
    "karousel-window-toggle-floating" = bind "Meta+Space" "Karousel: Toggle floating";

    # Karousel disabled
    "karousel-column-move-end" = disable "Karousel: Move column to end";
    "karousel-column-move-start" = disable "Karousel: Move column to start";
    "karousel-column-move-to-column-1" = disable "Karousel: Move column to position 1";
    "karousel-column-move-to-column-2" = disable "Karousel: Move column to position 2";
    "karousel-column-move-to-column-3" = disable "Karousel: Move column to position 3";
    "karousel-column-move-to-column-4" = disable "Karousel: Move column to position 4";
    "karousel-column-move-to-column-5" = disable "Karousel: Move column to position 5";
    "karousel-column-move-to-column-6" = disable "Karousel: Move column to position 6";
    "karousel-column-move-to-column-7" = disable "Karousel: Move column to position 7";
    "karousel-column-move-to-column-8" = disable "Karousel: Move column to position 8";
    "karousel-column-move-to-column-9" = disable "Karousel: Move column to position 9";
    "karousel-column-move-to-column-10" = disable "Karousel: Move column to position 10";
    "karousel-column-move-to-column-11" = disable "Karousel: Move column to position 11";
    "karousel-column-move-to-column-12" = disable "Karousel: Move column to position 12";
    "karousel-column-move-to-desktop-11" = disable "Karousel: Move column to desktop 11";
    "karousel-column-move-to-desktop-12" = disable "Karousel: Move column to desktop 12";
    "karousel-column-toggle-stacked" = disable "Karousel: Toggle stacked layout for focused column";
    "karousel-column-width-decrease" = disable "Karousel: Decrease column width";
    "karousel-column-width-increase" = disable "Karousel: Increase column width";
    "karousel-columns-squeeze-left" = disable "Karousel: Squeeze left column onto the screen";
    "karousel-columns-squeeze-right" = disable "Karousel: Squeeze right column onto the screen";
    "karousel-focus-1" = disable "Karousel: Move focus to column 1";
    "karousel-focus-2" = disable "Karousel: Move focus to column 2";
    "karousel-focus-3" = disable "Karousel: Move focus to column 3";
    "karousel-focus-4" = disable "Karousel: Move focus to column 4";
    "karousel-focus-5" = disable "Karousel: Move focus to column 5";
    "karousel-focus-6" = disable "Karousel: Move focus to column 6";
    "karousel-focus-7" = disable "Karousel: Move focus to column 7";
    "karousel-focus-8" = disable "Karousel: Move focus to column 8";
    "karousel-focus-9" = disable "Karousel: Move focus to column 9";
    "karousel-focus-10" = disable "Karousel: Move focus to column 10";
    "karousel-focus-11" = disable "Karousel: Move focus to column 11";
    "karousel-focus-12" = disable "Karousel: Move focus to column 12";
    "karousel-focus-end" = disable "Karousel: Move focus to end";
    "karousel-focus-next" = disable "Karousel: Move focus to the next window in grid";
    "karousel-focus-previous" = disable "Karousel: Move focus to the previous window in grid";
    "karousel-focus-start" = disable "Karousel: Move focus to start";
    "karousel-screen-switch" = disable "Karousel: Move Karousel grid to the current screen";
    "karousel-window-move-end" = disable "Karousel: Move window to end";
    "karousel-window-move-next" = disable "Karousel: Move window to the next position in grid";
    "karousel-window-move-previous" = disable "Karousel: Move window to the previous position in grid";
    "karousel-window-move-start" = disable "Karousel: Move window to start";
    "karousel-window-move-to-column-1" = disable "Karousel: Move window to column 1";
    "karousel-window-move-to-column-2" = disable "Karousel: Move window to column 2";
    "karousel-window-move-to-column-3" = disable "Karousel: Move window to column 3";
    "karousel-window-move-to-column-4" = disable "Karousel: Move window to column 4";
    "karousel-window-move-to-column-5" = disable "Karousel: Move window to column 5";
    "karousel-window-move-to-column-6" = disable "Karousel: Move window to column 6";
    "karousel-window-move-to-column-7" = disable "Karousel: Move window to column 7";
    "karousel-window-move-to-column-8" = disable "Karousel: Move window to column 8";
    "karousel-window-move-to-column-9" = disable "Karousel: Move window to column 9";
    "karousel-window-move-to-column-10" = disable "Karousel: Move window to column 10";
    "karousel-window-move-to-column-11" = disable "Karousel: Move window to column 11";
    "karousel-window-move-to-column-12" = disable "Karousel: Move window to column 12";
    "karousel-tail-move-to-desktop-11" =
      disable "Karousel: Move this and all following columns to desktop 11";
    "karousel-tail-move-to-desktop-12" =
      disable "Karousel: Move this and all following columns to desktop 12";

    # KWin disabled
    "Activate Window Demanding Attention" = [ ];
    "Edit Tiles" = [ ];
    "Grid View" = [ ];
    Overview = [ ];
    "Show Desktop" = [ ];
    "Switch One Desktop Down" = [ ];
    "Switch One Desktop Up" = [ ];
    "Switch One Desktop to the Left" = [ ];
    "Switch One Desktop to the Right" = [ ];
    "Switch Window Down" = [ ];
    "Switch Window Left" = [ ];
    "Switch Window Right" = [ ];
    "Switch Window Up" = [ ];
    "Walk Through Windows" = [ ];
    "Walk Through Windows (Reverse)" = [ ];
    "Window One Desktop Down" = [ ];
    "Window One Desktop Up" = [ ];
    "Window One Desktop to the Left" = [ ];
    "Window One Desktop to the Right" = [ ];
    "Window Quick Tile Bottom" = [ ];
    "Window Quick Tile Bottom Left" = [ ];
    "Window Quick Tile Bottom Right" = [ ];
    "Window Quick Tile Left" = [ ];
    "Window Quick Tile Right" = [ ];
    "Window Quick Tile Top" = [ ];
    "Window Quick Tile Top Left" = [ ];
    "Window Quick Tile Top Right" = [ ];
  };

  plasmashell = {
    "activate application launcher" = bind "Meta+Esc" "Activate Application Launcher";

    # Disabled
    "activate task manager entry 1" = disable "Activate Task Manager Entry 1";
    "activate task manager entry 2" = disable "Activate Task Manager Entry 2";
    "activate task manager entry 3" = disable "Activate Task Manager Entry 3";
    "activate task manager entry 4" = disable "Activate Task Manager Entry 4";
    "activate task manager entry 5" = disable "Activate Task Manager Entry 5";
    "activate task manager entry 6" = disable "Activate Task Manager Entry 6";
    "activate task manager entry 7" = disable "Activate Task Manager Entry 7";
    "activate task manager entry 8" = disable "Activate Task Manager Entry 8";
    "activate task manager entry 9" = disable "Activate Task Manager Entry 9";
    "activate task manager entry 10" = disable "Activate Task Manager Entry 10";
    "manage activities" = disable "Show Activity Switcher";
    "next activity" = disable "Walk through activities";
    "previous activity" = disable "Walk through activities (Reverse)";
    "show-on-mouse-pos" = disable "Show Clipboard Items at Mouse Position";
  };

  org_kde_powerdevil.powerProfile = disable "Switch Power Profile";

  "services/org.kde.dolphin.desktop"._launch = "Meta+A";
  "services/org.kde.krunner.desktop"._launch = "Meta+D";
  "services/kitty.desktop"._launch = "Meta+Z";

  "services/google-chrome-Default.desktop"._launch = "Meta+B";
  "services/google-chrome-Calcbase.desktop"._launch = "Meta+Shift+B";

  # Disabled
  "services/org.kde.plasma-systemmonitor.desktop"._launch = "none";
}

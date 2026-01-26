{
  home.file.se98 = {
    source = ./SE98C;
    target = ".local/share/icons/SE98C";
    recursive = true;
  };

  home.file.plasma-overdose-look-and-feel = {
    source = ./Plasma-Overdose-master/plasma/look-and-feel/Plasma-Overdose;
    target = ".local/share/plasma/look-and-feel/Plasma-Overdose";
    recursive = true;
  };

  home.file.plasma-overdose-colors = {
    source = ./Plasma-Overdose-master/colorschemes/PlasmaOverdose.colors;
    target = ".local/share/color-schemes/PlasmaOverdose.colors";
  };

  home.file.plasma-overdose-aurorae = {
    source = ./Plasma-Overdose-master/aurorae;
    target = ".local/share/aurorae/themes";
    recursive = true;
  };

  home.file.plasma-overdose-sounds = {
    source = ./Plasma-Overdose-master/sounds;
    target = ".local/share/sounds/Plasma-Overdose";
    recursive = true;
  };

  home.file.miku-cursors = {
    source = ./miku-cursor-linux;
    target = ".local/share/icons/miku-cursor-linux";
    recursive = true;
  };

  programs.plasma = {
    enable = true;

    workspace = {
      lookAndFeel = "Plasma Overdose";
      colorScheme = "Plasma Overdose";
      iconTheme = "SE98C";
      soundTheme = "Plasma Overdose";
      splashScreen = {
        theme = "Plasma Overdose";
      };
      windowDecorations = {
        library = "org.kde.kwin.aurorae";
        theme = "__aurorae__svg__Plasma-Overdose_x1.5";
      };
      cursor = {
        theme = "Miku Cursor";
      };
      wallpaper = ./fh000011.jpg;
    };

    powerdevil = {
      AC = {
        powerButtonAction = "lockScreen";
        autoSuspend = {
          action = "sleep";
          idleTimeout = 1000;
        };
        turnOffDisplay = {
          idleTimeout = 1000;
          idleTimeoutWhenLocked = "immediately";
        };
      };
      battery = {
        powerButtonAction = "sleep";
        whenSleepingEnter = "standbyThenHibernate";
      };
      lowBattery = {
        whenLaptopLidClosed = "hibernate";
      };
    };

    shortcuts = {
      "kwin"."karousel-window-move-next" = "Meta+Right";
      "kwin"."karousel-window-move-previous" = "Meta+Left";
      "kwin"."karousel-window-toggle-floating" = "Meta+F";
    };
    configFile = {
      katerc.filetree.middleClickToClose = true;
      katerc.lspclient.FormatOnSave = true;
      kcminputrc."ButtonRebinds/Tablet/HUION Huion Tablet_GS1331"."0" = "Key,Ctrl+Z";
      kcminputrc."ButtonRebinds/Tablet/HUION Huion Tablet_GS1331"."1" = "Key,Ctrl+Shift+Z";
      kcminputrc."ButtonRebinds/Tablet/HUION Huion Tablet_GS1331"."2" = "Key,E";
      kcminputrc."ButtonRebinds/Tablet/HUION Huion Tablet_GS1331"."3" = "Key,Ctrl+=";
      kcminputrc."ButtonRebinds/Tablet/HUION Huion Tablet_GS1331"."4" = "Key,Ctrl+-";
      kcminputrc."ButtonRebinds/Tablet/HUION Huion Tablet_GS1331"."5" = "Key,M";
      kcminputrc."ButtonRebinds/Tablet/HUION Huion Tablet_GS1331"."6" = "Key,[";
      kcminputrc."ButtonRebinds/Tablet/HUION Huion Tablet_GS1331"."7" = "Key,]";
      kcminputrc."Libinput/13364/53321/Keychron Keychron M6 8K".PointerAccelerationProfile = 1;
      kcminputrc."Libinput/22597/22098/Xelus Xelus Valor Rev3 Consumer Control".Enabled = false;
      kcminputrc."Libinput/22597/22098/Xelus Xelus Valor Rev3 Mouse".Enabled = false;
      kcminputrc."Libinput/9580/109/HUION Huion Tablet_GS1331 Dial".Enabled = false;
      kcminputrc."Libinput/9580/109/HUION Huion Tablet_GS1331 Stylus".MapToWorkspace = false;
      #       kcminputrc.Mouse.cursorTheme = "kasane-teto-cursors";
      "kxkbrc"."Layout"."Options" = "korean:ralt_hangul,korean:rctrl_hanja,caps:backspace";
      kded5rc.Module-browserintegrationreminder.autoload = false;
      kded5rc.Module-device_automounter.autoload = false;
      kdeglobals.General.XftHintStyle = "hintslight";
      kdeglobals.General.XftSubPixel = "none";
      kdeglobals.General.fixed = "ComicShannsMono Nerd Font,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
      kdeglobals.General.font = "rainyhearts,12,-1,5,500,0,0,0,0,0,0,0,0,0,0,1,Medium";
      kdeglobals.General.menuFont = "rainyhearts,12,-1,5,500,0,0,0,0,0,0,0,0,0,0,1,Medium";
      kdeglobals.General.smallestReadableFont = "rainyhearts,10,-1,5,500,0,0,0,0,0,0,0,0,0,0,1,Medium";
      kdeglobals.General.toolBarFont = "rainyhearts,12,-1,5,500,0,0,0,0,0,0,0,0,0,0,1,Medium";
      #       kdeglobals.Icons.Theme = "Memphis98";
      kdeglobals.KDE.AnimationDurationFactor = 0.125;
      kdeglobals.KDE.widgetStyle = "Windows";
      kwinrc.Wayland."InputMethod[$e]" = "/run/current-system/sw/share/applications/fcitx5-wayland-launcher.desktop";
      kwinrc.Wayland."InputMethod\x5b$e\x5d" = "/run/current-system/sw/share/applications/fcitx5-wayland-launcher.desktop";
      kwinrc.Wayland.VirtualKeyboardEnabled = true;
      kwinrc.Desktops.Number = {
        value = 4;
        # Forces kde to not change this value (even through the settings app).
        immutable = true;
      };
      spectaclerc.ImageSave.translatedScreenshotsFolder = "Screenshots";
      spectaclerc.VideoSave.translatedScreencastsFolder = "Screencasts";
    };
  };
}

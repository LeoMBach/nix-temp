{
  home.file = {
    kde-keybinds = {
      source = ./kglobalshortcutsrc;
      target = ".config/kglobalshortcutsrc";
    };

    krunnerrc = {
      target = ".config/krunnerrc";
      text = ''
        [Plugins]
        baloosearchEnabled=false
        bookmarksEnabled=false
        browsertabsEnabled=false
        calculatorEnabled=false
        CharacterRunnerEnabled=false
        desktopsessionsEnabled=false
        DictionaryEnabled=false
        katesessionsEnabled=false
        Kill RunnerEnabled=false
        konsoleprofilesEnabled=false
        krunner_appstreamEnabled=false
        kwinEnabled=false
        locationsEnabled=false
        org.kde.activitiesEnabled=false
        org.kde.datetimeEnabled=false
        org.kde.windowedwidgetsEnabled=false
        placesEnabled=false
        plasma-desktopEnabled=false
        PowerDevilEnabled=false
        recentdocumentsEnabled=false
        servicesEnabled=true
        shellEnabled=false
        Spell CheckerEnabled=false
        unitconverterEnabled=false
        webshortcutsEnabled=false
        windowsEnabled=false
      '';
    };
  };
}

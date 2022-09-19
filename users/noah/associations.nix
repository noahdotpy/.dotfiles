let
  browser = ["librewolf.desktop"];

  xdgAssociations = {
    "text/html" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/chrome" = ["com.github.Eloston.UngoogledChromium.desktop"];
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/unknown" = browser;
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/xhtml+xml" = browser;
    "application/x-extension-xhtml" = browser;
    "application/x-extension-xht" = browser;

    # "text/*" = [ "emacs.desktop" ];
    "audio/*" = ["mpv.desktop"];
    "video/*" = ["mpv.dekstop"];
    "image/*" = ["imv.desktop"];
    #"text/calendar" = [ "thunderbird.desktop" ];
    "application/json" = browser;
    "application/pdf" = ["okularApplication_pdf.desktop"];
    "x-scheme-handler/tg" = ["telegramdesktop.desktop"];
    "x-scheme-handler/spotify" = ["com.spotify.Client.desktop"];
    "x-scheme-handler/discord" = ["com.discordapp.Discord.desktop"];
  };
in {
  home.sessionVariables = {
    BROWSER = "librewolf";
    EDITOR = "nvim";
    TERMINAL = "kitty";
    TERM = "kitty";
  };

  xdg.mimeApps.enable = true;
  xdg.mimeApps.associations.added = xdgAssociations;
  xdg.mimeApps.defaultApplications = xdgAssociations;
}
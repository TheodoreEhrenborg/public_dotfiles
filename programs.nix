{
  pkgs-home-manager,
  firefox-addons,
  lite,
}: {
  direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  jujutsu = {
    enable = true;
    package = pkgs-home-manager.unstable.jujutsu;
    settings.user = {
      name = "Theodore Ehrenborg";
      email = "theodore.ehrenborg@gmail.com";
    };
    settings.ui = {
      default-command = "show";
    };
  };
  git = {
    enable = true;
    userEmail = "theodore.ehrenborg@gmail.com";
    userName = "TheodoreEhrenborg";
    lfs.enable = true;
    difftastic = {
      enable = false;
    };
  };
  home-manager = {
    enable = true;
  };
  emacs = {
    enable = true;
  };
  firefox =
    if !lite
    then {
      enable = true;
      profiles = {
        default = {
          isDefault = true;
          settings = {
            "browser.tabs.closeWindowWithLastTab" = true;

            # Fully disable Pocket. See
            # https://www.reddit.com/r/linux/comments/zabm2a.
            "extensions.pocket.enabled" = false;
            "extensions.pocket.api" = "0.0.0.0";
            "extensions.pocket.loggedOutVariant" = "";
            "extensions.pocket.oAuthConsumerKey" = "";
            "extensions.pocket.onSaveRecs" = false;
            "extensions.pocket.onSaveRecs.locales" = "";
            "extensions.pocket.showHome" = false;
            "extensions.pocket.site" = "0.0.0.0";
            "browser.newtabpage.activity-stream.pocketCta" = "";
            "browser.newtabpage.activity-stream.section.highlights.includePocket" =
              false;
            "services.sync.prefs.sync.browser.newtabpage.activity-stream.section.highlights.includePocket" =
              false;
          };

          extensions = with firefox-addons.packages.x86_64-linux; [
            tridactyl
            ublock-origin
            istilldontcareaboutcookies
          ];
        };
      };
    }
    else {
      enable = false;
    };
}

{zen-browser, ...}: {
  imports = [zen-browser.homeModules.twilight];

  programs.zen-browser = {
    enable = true;

    # https://mozilla.github.io/policy-templates
    policies = {
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };

      ExtensionSettings = import ./extensions.nix;

      # https://searchfox.org/firefox-main/source/modules/libpref/init/StaticPrefList.yaml
      Preferences = let
        lockedPrefs = builtins.mapAttrs (_: Value: {
          inherit Value;
          Status = "locked";
        });
      in
        lockedPrefs {
          "browser.tabs.hoverPreview.enabled" = true;
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.topsites.contile.enabled" = false;
          "browser.startup.page" = 3; # restore prev windows/tabs

          "browser.tabs.tabmanager.enabled" = true;
          "toolkit.tabbox.switchByScrolling" = true;
          "general.smoothScroll" = false;

          "browser.display.background_color.dark" = "#000000";
          "browser.display.background_color" = "#000000";
          "browser.display.focus_background_color" = "#000000";
          "browser.display.focus_background_color.dark" = "#000000";
          "browser.newtabpage.enabled" = false;

          "privacy.resistFingerprinting" = true;
          # "privacy.resistFingerprinting" = false; # breaks alt + [0-9] for switching tabs

          "privacy.resistFingerprinting.letterboxing" = false;

          "privacy.firstparty.isolate" = false;

          "network.cookie.cookieBehavior" = 5;

          "gfx.webrender.all" = true;
          "gfx.webrender.precache-shaders" = true;
          "gfx.webrender.compositor" = true;
          "gfx.webrender.compositor.force-enabled" = true;
          "network.http.http3.enabled" = true;

          "devtools.debugger.remote-enabled" = true;
          "devtools.chrome.enabled" = true;
        };
    };

    profiles.default = {
      settings = {
        "zen.workspaces.continue-where-left-off" = true;
        "zen.workspaces.natural-scroll" = true;
        "zen.view.compact.hide-tabbar" = true;
        "zen.view.compact.hide-toolbar" = true;
        "zen.view.compact.animate-sidebar" = false;
        "zen.theme.content-element-separation" = 0;
        "zen.urlbar.show-domain-only-in-sidebar" = false;
      };

      spacesForce = true;
      # https://github.com/0xc000022070/zen-browser-flake?tab=readme-ov-file#spaces
      spaces = {
        "Docs" = {
          id = "13f8f82f-ccf4-4db3-9f0b-2f810e668cb3";
          icon = "🔭";
          position = 1000;
          theme = {
            type = "gradient";
            colors = [
              {
                red = 226;
                green = 182;
                blue = 184;
                algorithm = "floating";
                type = "explicit-lightness";
              }
            ];
            opacity = 0.2;
            texture = 0.5;
          };
        };

        "Music" = {
          id = "db987cc4-e7b0-4715-9715-04760f33e036";
          icon = "🎵";
          position = 2000;
          theme = {
            type = "gradient";
            colors = [
              {
                red = 50;
                green = 50;
                blue = 50;
                algorithm = "floating";
                type = "explicit-lightness";
              }
            ];
            opacity = 0.1;
            texture = 0.5;
          };
        };

        "Movie" = {
          id = "8968e43c-be80-4a78-a492-75b7efab106c";
          icon = "🎥";
          position = 3000;
          theme = {
            type = "gradient";
            colors = [
              {
                red = 127;
                green = 155;
                blue = 203;
                algorithm = "floating";
                type = "explicit-lightness";
              }
            ];
            opacity = 0.2;
            texture = 0.5;
          };
        };
      };

      search = {
        force = true;
        default = "ddg";

        engines = {
          ddg = {
            urls = [
              {
                template = "https://duckduckgo.com/";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          NixPackages = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = ["np"];
          };

          MyNixOS = {
            urls = [
              {
                template = "https://mynixos.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = ["my"];
          };

          noogle = {
            urls = [
              {
                template = "https://noogle.dev/q";
                params = [
                  {
                    name = "term";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = ["no"];
          };

          emoji = {
            urls = [
              {
                template = "https://emojis.wiki/search/";
                params = [
                  {
                    name = "s";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            definedAliases = ["em"];
          };
        };
      };
    };
  };
}

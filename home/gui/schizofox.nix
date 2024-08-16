{schizofox, ...}: {
  imports = [schizofox.homeManagerModule];

  programs.schizofox = {
    enable = true;

    security = {
      sanitizeOnShutdown = false;
      userAgent = "Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/115.0";
      sandbox = false;
    };

    misc = {
      displayBookmarksInToolbar = "newtab";
      drm.enable = true;
      firefoxSync = true;
      contextMenu.enable = true;
    };

    search = rec {
      defaultSearchEngine = "Searxng";
      removeEngines = ["Bing" "Amazon.com" "eBay" "Twitter"];
      searxUrl = "https://search.notashelf.dev";
      searxQuery = "${searxUrl}/search?q={searchTerms}&categories=general";
      addEngines = [
        {
          Name = "Searxng";
          Description = "Decentralized search engine";
          Alias = "sx";
          Method = "GET";
          URLTemplate = "${searxQuery}";
        }
        {
          Name = "Yandex";
          Description = "Yandex";
          Alias = "!y";
          Method = "GET";
          URLTemplate = "https://yandex.com/search/?text={searchTerms}";
        }
        {
          Name = "Ggle";
          Description = "Ggle";
          Alias = "!g";
          Method = "GET";
          URLTemplate = "https://www.google.com/search?q={searchTerms}";
        }
        {
          Name = "pp";
          Description = "Perplexity";
          Alias = "!pe";
          Method = "GET";
          URLTemplate = "https://www.perplexity.ai/search?q={searchTerms}";
        }
        {
          Name = "noogle";
          Descriptiom = "Noogle Search";
          Alias = "!no";
          Method = "GET";
          URLTemplate = "https://noogle.dev/q?term={searchTerms}";
        }
        {
          Name = "Wikipedia";
          Description = "Wikipedia";
          Alias = "!w";
          Method = "GET";
          URLTemplate = "https://en.wikipedia.org/w/index.php?search={searchTerms}";
        }
      ];
    };

    extensions = {
      simplefox.enable = true;
      darkreader.enable = false;

      enableDefaultExtensions = true;

      enableExtraExtensions = true;
      extraExtensions = let
        extensions = [
          {
            id = "addon@darkreader.org";
            name = "darkreader";
          }
          {
            id = "{1018e4d6-728f-4b20-ad56-37578a4de76}";
            name = "flagfox";
          }
          {
            id = "{74145f27-f039-47ce-a470-a662b129930a}";
            name = "clearurls";
          }
          {
            id = "{b86e4813-687a-43e6-ab65-0bde4ab75758}";
            name = "localcdn-fork-of-decentraleyes";
          }
          {
            id = "skipredirect@sblask";
            name = "skip-redirect";
          }
          {
            id = "DontFuckWithPaste@raim.ist";
            name = "dont-fuck-with-paste";
          }
          {
            id = "{d7742d87-e61d-4b78-b8a1-b469842139fa}";
            name = "vimium-ff";
          }
          {
            id = "{92e6fe1c-6e1d-44e1-8bc6-d309e59406af}";
            name = "hover-zoom-plus";
          }
          {
            id = "idcac-pub@guus.ninja";
            name = "istilldontcareaboutcookies";
          }
        ];

        mappedExtensions =
          map (extension: {
            name = extension.id;
            value = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/${extension.name}/latest.xpi";
            };
          })
          extensions;
      in
        builtins.listToAttrs mappedExtensions;
    };

    settings = {
      "browser.tabs.tabmanager.enabled" = true; # remove list all tabs button
      "toolkit.tabbox.switchByScrolling" = true; # allowes scrolling through tabs with scrollwheel
      "privacy.resistFingerprinting" = false; # breaks alt + [0-9] for switching tabs
      "general.smoothScroll" = false;
      "browser.startup.page" = 3;
      "browser.startup.homepage" = "chrome://browser/content/blanktab.html";

      "browser.display.background_color.dark" = "#000000";
      "browser.display.background_color" = "#000000";
      "browser.display.focus_background_color" = "#000000";
      "browser.display.focus_background_color.dark" = "#000000";

      # *some "borrowed" from https://github.com/yokoffing/Betterfox
      "full-screen-api.warning.delay" = -1;
      "full-screen-api.warning.timeout" = 0;
      "browser.privatebrowsing.vpnpromourl" = "";
      "gfx.webrender.all" = true;
      "gfx.webrender.precache-shaders" = true;
      "gfx.webrender.compositor" = true;
      "gfx.webrender.compositor.force-enabled" = true;
      "gfx.canvas.accelerated.cache-items" = 4096;
      "gfx.canvas.accelerated.cache-size" = 512;
      "gfx.content.skia-font-cache-size" = 20;
      "layers.gpu-process.enabled" = true;
      "media.ffmpeg.vaapi.enabled" = true;
      "media.hardware-video-decoding.enabled" = true;
      "browser.low_commit_space_threshold_percent" = 33;
      "privacy.globalprivacycontrol.enabled" = true;
      "image.mem.decode_bytes_at_a_time" = 32768;
      "media.cache_readahead_limit" = 7200;
      "media.cache_resume_threshold" = 3600;
      "network.buffer.cache.size" = 262144;
      "network.buffer.cache.count" = 128;
      "network.http.max-connections" = 1800;
      "network.ssl_tokens_cache_capacity" = 10240;

      "privacy.firstparty.isolate" = false;
    };

    theme = {
      defaultUserChrome.enable = false;
      defaultUserContent.enable = false;

      extraUserChrome = ''
        /* extraUserChrome from nix */

        :root {
            --sfwindow: #000000;
            --sfsecondary: #151515;
        }

        browser[type="content-primary"],
        browser[type="content"] {
            background-color: #000000 !important;
        }

        .titlebar-buttonbox-container,
        #alltabs-button {
            display: none !important;
        }
        .tabbrowser-tab:not([pinned]) .tab-icon-image,
        .bookmark-item .toolbarbutton-icon,
        #back-button,
        #context-viewsource,
        #context-openlinkinusercontext-menu,
        #context-searchselect {
          display: flex !important;
        }
      '';
      extraUserContent = ''
        :root {
          scrollbar-width: auto !important;
        }

        @-moz-document url(about:privatebrowsing) {
          :root {
            scrollbar-width: auto !important;
          }
        }
      '';
    };
  };
}

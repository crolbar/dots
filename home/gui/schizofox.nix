{schizofox, ...}: {
  imports = [schizofox.homeManagerModule];

  programs.schizofox = {
    enable = true;

    security = {
      sanitizeOnShutdown.enable = false;
      userAgent = "Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/115.0";
      sandbox.enable = false;
    };

    misc = {
      displayBookmarksInToolbar = "newtab";
      drm.enable = true;
      firefoxSync = true;
      contextMenu.enable = true;
    };

    search = {
      defaultSearchEngine = "DuckDuckGo";
      removeEngines = ["Bing" "Amazon.com" "eBay" "Twitter"];
      addEngines = [
        {
          Name = "DuckDuckGo";
          Description = "duck";
          Alias = "dk";
          Method = "GET";
          URLTemplate = "https://duckduckgo.com/?q={searchTerm}";
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
      simplefox.enable = false; # im adding it manualy in theme
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
          {
            id = "Tab-Session-Manager@sienori";
            name = "Tab-Session-Manager";
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
      "browser.newtabpage.enabled" = false;

      # some* "borrowed" from https://github.com/yokoffing/Betterfox
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
      "layers.gpu-process.enabled" = false; # causes slow startup in x11 after my flake update in commit `a7f2909`
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

      # enables ctrl + shift + alt + i
      "devtools.debugger.remote-enabled" = true;
      "devtools.chrome.enabled" = true;

      "privacy.resistFingerprinting.letterboxing" = false;
    };

    theme = let
      mainColor = "#000000";
      secondaryColor = "#151515";
    in {
      defaultUserChrome.enable = false;
      defaultUserContent.enable = false;

      # modified https://github.com/migueravila/SimpleFox/blob/master/chrome/userChrome.css
      extraUserChrome = ''
        :root {
          --sfwindow: ${mainColor};
          --sfsecondary: ${secondaryColor};
        }

        /* Urlbar View */

        .urlbarView {
          display: none !important;
        }

        /*─────────────────────────────*/

        /*
        ┌─┐┌─┐┬  ┌─┐┬─┐┌─┐
        │  │ ││  │ │├┬┘└─┐
        └─┘└─┘┴─┘└─┘┴└─└─┘
        */

        /* Tabs colors  */
        #tabbrowser-tabs:not([movingtab])
          > #tabbrowser-arrowscrollbox
          > .tabbrowser-tab
          > .tab-stack
          > .tab-background[multiselected='true'],
        #tabbrowser-tabs:not([movingtab])
          > #tabbrowser-arrowscrollbox
          > .tabbrowser-tab
          > .tab-stack
          > .tab-background[selected='true'] {
          background-image: none !important;
          background-color: var(--toolbar-bgcolor) !important;
        }

        /* Inactive tabs color */
        #navigator-toolbox {
          background-color: var(--sfwindow) !important;
        }

        /* Window colors  */
        :root {
          --toolbar-bgcolor: var(--sfsecondary) !important;
          --tabs-border-color: var(--sfsecondary) !important;
          --lwt-sidebar-background-color: var(--sfwindow) !important;
          --lwt-toolbar-field-focus: var(--sfsecondary) !important;
        }

        /* Sidebar color  */
        #sidebar-box,
        .sidebar-placesTree {
          background-color: var(--sfwindow) !important;
        }

        /*

        ┌┬┐┌─┐┬  ┌─┐┌┬┐┌─┐
         ││├┤ │  ├┤  │ ├┤
        ─┴┘└─┘┴─┘└─┘ ┴ └─┘
        ┌─┐┌─┐┌┬┐┌─┐┌─┐┌┐┌┌─┐┌┐┌┌┬┐┌─┐
        │  │ ││││├─┘│ ││││├┤ │││ │ └─┐
        └─┘└─┘┴ ┴┴  └─┘┘└┘└─┘┘└┘ ┴ └─┘

        */

        /* Tabs elements  */
        .tab-close-button {
          display: none;
        }

        .titlebar-buttonbox-container,
        .titlebar-spacer,
        #alltabs-button {
          display: none !important;
        }

        #nav-bar:not([tabs-hidden='true']) {
          box-shadow: none;
        }

        #tabbrowser-tabs[haspinnedtabs]:not([positionpinnedtabs])
          > #tabbrowser-arrowscrollbox
          > .tabbrowser-tab[first-visible-unpinned-tab] {
          margin-inline-start: 0 !important;
        }

        :root {
          --toolbarbutton-border-radius: 0 !important;
          --tab-border-radius: 0 !important;
          --tab-block-margin: 0 !important;
        }

        .tab-background {
          border-right: 0px solid rgba(0, 0, 0, 0) !important;
          margin-left: -4px !important;
        }

        .tabbrowser-tab:is([visuallyselected='true'], [multiselected])
          > .tab-stack
          > .tab-background {
          box-shadow: none !important;
        }

        .tabbrowser-tab[last-visible-tab='true'] {
          padding-inline-end: 0 !important;
        }

        #tabs-newtab-button {
          padding-left: 0 !important;
        }

        #titlebar:-moz-window-inactive {
          opacity: 1 !important; /* force opacity to remain the same */
          transition: none !important;
        }

        /* Url Bar  */

        .urlbar-input-container { /* changed to a class in new versions */
          background-color: var(--sfsecondary) !important;
          border: none !important;
        }

        #nav-bar {
          border: none !important;
        }

        #urlbar-container {
          margin-left: 0 !important;
        }

        #urlbar[focused] > #urlbar-background { /* changed [focused='true'] to  [focused] */
          box-shadow: none !important;
        }

        #nav-bar toolbarspring { /* urlbar spacers */
          display: none !important;
        }

        #navigator-toolbox {
          border: none !important;
        }

        /* Bookmarks bar  */
        toolbarbutton.bookmark-item:not(.subviewbutton) {
          min-width: 1.6em;
        }

        /* Toolbar  */
        #tracking-protection-icon-container,
        #star-button-box,
        #pageActionButton,
        #pageActionSeparator,
        #tabs-newtab-button,
        #PanelUI-button,
        #forward-button,
        .tab-secondary-label {
          display: none !important;
        }

        .urlbarView-url {
          color: #dedede !important;
        }

        /* Disable elements  */
        #context-navigation,
        #context-savepage,
        #context-pocket,
        #context-sendpagetodevice,
        #context-selectall,
        #context-inspect-a11y,
        #context-sendlinktodevice,
        #context-bookmarklink,
        #context-savelink,
        #context-savelinktopocket,
        #context-sendlinktodevice,
        #context-sendimage,
        #context-print-selection {
          display: none !important;
        }

        #context_bookmarkTab,
        #context_moveTabOptions,
        #context_sendTabToDevice,
        #context_reopenInContainer,
        #context_selectAllTabs,
        #context_closeTabOptions {
          display: none !important;
        }

        browser[type="content-primary"],
        browser[type="content"] {
            background-color: #000000 !important;
        }
      '';
    };
  };
}

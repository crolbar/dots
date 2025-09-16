builtins.listToAttrs
(
  map
  (
    extension: {
      name = extension.id;
      value = {
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/${extension.name}/latest.xpi";
        installation_mode = "force_installed";
      };
    }
  )
  [
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
      id = "uBlock0@raymondhill.net";
      name = "ublock-origin";
    }
  ]
)

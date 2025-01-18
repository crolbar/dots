{...}: rec {
  # removes newlines
  mk1lnr = multilineStr:
    builtins.replaceStrings ["\n"] [""] multilineStr;

  # removes backslashes + newlines
  mk1lnrCmd = multilineStrCmd:
    mk1lnr (builtins.replaceStrings ["\\\n"] [""] multilineStrCmd);
}

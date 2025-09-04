{lib, ...}: rec {
  # removes newlines
  mk1lnr = multilineStr:
    builtins.replaceStrings ["\n"] [""] multilineStr;

  # removes backslashes + newlines
  mk1lnrCmd = multilineStrCmd:
    mk1lnr (builtins.replaceStrings ["\\\n"] [""] multilineStrCmd);

  toRonImpSome = value:
    "#![enable(implicit_some)]\n"
    + (toRon value);

  toRon = value:
    if builtins.isString value
    then ''"${value}"''
    else if builtins.isInt value
    then toString value
    else if builtins.isList value
    then "[${builtins.concatStringsSep "," (map toRon value)}]"
    else if builtins.isAttrs value
    then let
      genPairs = attrs: let
        mapf = key: value: ["${key}: ${toRon value}"];
      in
        lib.attrsets.mapAttrsToList mapf attrs;
      listListsToStr = lists:
        builtins.concatStringsSep ",\n"
        (builtins.concatLists lists);
    in "(${listListsToStr (genPairs value)})"
    else if builtins.isFunction value
    then value {}
    else abort "toRon: unsupported type";

  _cIf = type: cond: val:
    if cond
    then val
    else
      (
        if type == "string"
        then ""
        else if type == "list"
        then []
        else if type == "attrset"
        then {}
        else null
      );

  ifS = _cIf "string";
  ifL = _cIf "list";
  ifA = _cIf "attrset";
}

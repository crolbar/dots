lib: rec {
  # from
  # vimBinds [[mod] moveFocus]
  #
  # to
  #
  # [
  #   [[mod] "k" moveFocus.up]
  #   [[mod] "j" moveFocus.down]
  #   [[mod] "h" moveFocus.left]
  #   [[mod] "l" moveFocus.right]
  # ];
  # takes a list of mods at index 0 that is an list of modifiyers and
  # `cmdSet` at index 1 that is an attr set with fields up, down, left, right
  vim = opts: let
    cmdSet = builtins.elemAt opts 1;
    mods = builtins.elemAt opts 0;
  in
    map (key: let
      cmdMap = {
        "k" = cmdSet.up;
        "j" = cmdSet.down;
        "h" = cmdSet.left;
        "l" = cmdSet.right;
      };
    in [mods key cmdMap.${key}]) ["k" "j" "h" "l"];

  # generates binds for workspaces from 1 - 10
  # takes a list of modifiyers at index 0 and a cmd at index 1
  # which is a function that takes the number of the workspace
  # and outputs the cmd
  workspaces = opts: let
    mods = builtins.elemAt opts 0;
    cmd = builtins.elemAt opts 1;
  in (lib.concatMap
    (
      i: let
        num = toString i;
        workspaceNum =
          if i == 0
          then "10"
          else num;
      in [[mods num (cmd workspaceNum)]]
    )
    (builtins.genList (i: i) 10));

  # given a list of binds
  # which command that they execute can be missing from `settings.cmds`
  # output the binds if the cmd exists else
  # output empty list. so it can be used to exdend the final binds
  mkOptionalBinds = settings: binds: let
    # im passing just the cmd name as an str. so I need to get the actual cmd
    setCmdFormBind = bind: let
      cmd = builtins.elemAt bind 2;
    in
      map
      (
        bindPart:
          if bindPart == cmd
          then settings.cmds.${cmd}
          else bindPart
      )
      bind;

    filteredBinds =
      lib.filter (
        bind:
          builtins.hasAttr
          (builtins.elemAt bind 2)
          settings.cmds
      )
      binds;
  in
    map setCmdFormBind filteredBinds;

  has = field: attrSet:
    builtins.hasAttr field attrSet;

  escapeQuotes = str:
    builtins.replaceStrings ["\""] ["\\\""] str;

  fixI3 = str:
    builtins.replaceStrings ["\""] ["'"] str;

  # transforms an attrset like this
  #
  # input:
  #
  # {
  #   foo = {
  #     bar = ["foo"];
  #   };
  #   bar = ["foo"];
  #   foo2 = {
  #     bar = {
  #       foo = {
  #         bar = ["bar"];
  #       };
  #     };
  #   };
  # }
  # into a single list of the items from the lists in the attrset
  #
  # output:
  #
  # [ "foo" "foo" "bar" ]
  concatBinds = binds:
    with builtins; let
      toList = x:
        if isAttrs x
        then concatBinds x
        else x;
      listOflists = map toList (attrValues binds);
    in
      concatLists listOflists;
}

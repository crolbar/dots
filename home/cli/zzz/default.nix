{
  pkgs,
  lib,
  discaml,
  ...
}: {
  imports = [
    ./dapu.nix
    discaml.homeManagerModules.default
  ];

  programs.discaml = {
    enable = true;
    scriptPath = let
      date = lib.getExe' pkgs.coreutils "date";
      cat = lib.getExe' pkgs.coreutils "cat";
      grep = lib.getExe' pkgs.gnugrep "grep";
      cut = lib.getExe' pkgs.coreutils "cut";
      bc = lib.getExe' pkgs.bc "bc";
      awk = lib.getExe' pkgs.gawk "awk";
      uname = lib.getExe' pkgs.coreutils "uname";
    in
      toString (pkgs.writers.writeBash "discaml-up" ''
        os="$(${cat} /etc/os-release | ${grep} PRETTY_NAME | ${cut} -d '"' -f2)"
        remaining_ram=$(printf "%.2f GiB\n" "$(echo "$(${grep} MemAvailable /proc/meminfo | ${awk} '{print $2}').0 / 1024.0 / 1024.0" | ${bc} -l)")
        kernel="$(${uname} -a | ${cut} -d ' ' -f1,2,3)"

        echo "\
        name=the.terminal;\
        details=$os | $kernel;\
        state=remaning ram $remaining_ram;\
        image=https://raw.githubusercontent.com/crolbar/dots/master/.github/assets/Screenshot-2024-08-28_11%3A20%3A29.png;\
        type=3;\
        started=$(($(${date} +%s%3N) - 49020000))\
        "
      '');
    tick = 10;
    activity = {
      type = 3;
      started = 0;
    };
  };

  home.packages = with pkgs; [
    matm
    tt-rs
    npassm
    gazi
    gql
    salg
    go29
    auvi
    vbz
    stray
    clare
  ];
}

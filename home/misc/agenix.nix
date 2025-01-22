{
  inputs',
  config,
  ...
}: let
  home = config.home.homeDirectory;
in {
  home.packages = [inputs'.agenix.packages.default];

  age.secrets.leet = {
    file = ../../secrets/leet.age;
    path = "${home}/.leetcode/leetcode.toml";
    mode = "644";
  };

  age.secrets.git = {
    file = ../../secrets/git.age;
    path = "${home}/.git-credentials";
    mode = "644";
  };
}

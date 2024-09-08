{
  inputs',
  agenix,
  config,
  ...
}: 
let 
home = config.home.homeDirectory;
in{
  imports = [agenix.homeManagerModules.default];
  home.packages = [inputs'.agenix.packages.default];

  age.secrets.leet = {
    file = ../../secrets/leet.age;
    path = "${home}/.leetcode/leetcode.toml";
    mode = "644";
  };
}

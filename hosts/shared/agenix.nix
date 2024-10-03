{
  inputs',
  agenix,
  username,
  ...
}: {
  imports = [agenix.nixosModules.default];
  environment.defaultPackages = [inputs'.agenix.packages.default];

  age.identityPaths = ["/home/${username}/.ssh/id_rsa"];

  age.secrets.freshRSSpass = {
    file = ../../secrets/freshRSSpass.age;
    mode = "644";
  };
}

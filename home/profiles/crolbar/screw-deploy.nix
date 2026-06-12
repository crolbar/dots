{pkgs, ...}: let
  remote = "192.168.1.11";
in {
  home.packages = [
    (pkgs.writers.writeBashBin "screw-deploy" ''
      nixos-rebuild --flake .#screw build

      if [ $? -ne 0 ]; then
        echo "system build falied"
        exit
      fi

      nix-copy-closure --to screw@${remote} ./result

      if [ $? -ne 0 ]; then
        echo "system copy falied"
        exit
      fi

      system=$(readlink ./result)

      ssh screw@${remote} " \
      sudo nix-env --profile /nix/var/nix/profiles/system --set $system && \
      sudo /nix/var/nix/profiles/system/bin/switch-to-configuration switch"
    '')
  ];
}

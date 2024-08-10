{...}: {
  imports = [
    ./shell_aliases.nix
  ];

  home.stateVersion = "23.11";
  home.username = "screw";
  home.homeDirectory = "/home/screw";
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  programs.zsh.initExtra = ''
    function yy() {
    	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    	yazi "$@" --cwd-file="$tmp"
    	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    		cd -- "$cwd"
    	fi
    	rm -f -- "$tmp"
    }
  '';
}

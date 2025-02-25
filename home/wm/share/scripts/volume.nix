{
  pkgs,
  clib,
  ...
} @ args: {
  home.file."scripts/volume".source = (clib.writers pkgs).writeGo "volume" ''
    package main

    import (
    	"net"
    	"os"
    )

    func main() {
    	conn, err := net.Dial("unix", "/tmp/volSock")
    	if err != nil {
    		panic("Error connecting to socket:" + err.Error())
    	}
    	defer conn.Close()

    	conn.Write([]byte(os.Args[1]))
    }
  '';

  systemd.user.services = let
    volSockBin = (clib.writers pkgs).writeGo "volSock" (import ./volSock.nix args);
  in {
    volSock = {
      Unit = {
        Description = "volSock";
        Wants = ["default.target"];
      };

      Service = {
        ExecStart = toString volSockBin;
        Restart = "always";
      };
    };
  };
}

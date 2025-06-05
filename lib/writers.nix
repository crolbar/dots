{
  writers = pkgs: rec {
    test = pkgs.writers.writeRustBin "rb" {} ''
      fn main() {
          println!("hi test works");
      }
    '';

    writeC = name: contents:
      pkgs.writers.makeBinWriter {
        compileScript = ''
          cp "$contentPath" tmp.c
          ${pkgs.gcc}/bin/gcc -o $out tmp.c
        '';
      }
      name
      contents;

    writeCBin = name: writeC "/bin/${name}";

    writeGo = name: contents:
      pkgs.writers.makeBinWriter {
        compileScript = ''
          export GOCACHE=$TMPDIR/go-build
          export CGO_ENABLED=1
          export CC=${pkgs.gcc}/bin/gcc
          cp "$contentPath" tmp.go
          ${pkgs.go}/bin/go build -o $out tmp.go
        '';
      }
      name
      contents;

    writeGoBin = name: writeGo "/bin/${name}";
  };
}

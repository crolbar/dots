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
  };
}

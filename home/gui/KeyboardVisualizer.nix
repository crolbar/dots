{pkgs, ...}: {
  home.packages = [
    (pkgs.callPackage ../../drvs/KeyboardVisualizer.nix {})
  ];

  home.file."settings.txt".text = ''
    amplitude=400
    bkgd_bright=100
    avg_size=8
    decay=80
    delay=5
    nrml_ofst=0.040000
    nrml_scl=0.500000
    fltr_const=1.000000
    window_mode=0
    bkgd_mode=15
    frgd_mode=16
    single_color_mode=11
    avg_mode=1
    anim_speed=100.000000
    reactive_bkgd=1
    silent_bkgd=0
    background_timeout=120
    audio_device_idx=1
  '';
}

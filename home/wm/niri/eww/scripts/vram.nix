{pkgs, ...}: {
  xdg.configFile."niri/eww/scripts/vram".source = pkgs.writers.writeBash "vram" ''
    while true; do
      read used total < <(nvidia-smi --query-gpu=memory.used,memory.total --format=csv,noheader,nounits | tr -d ',')
      percent=$(( 100 * used / total ))
      echo "{\"perc\":$percent,\"used\":$used,\"total\":$total}"
      sleep 3
    done
  '';
}

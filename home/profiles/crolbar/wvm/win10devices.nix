{pkgs, ...}: let
  gpuDev = devBus: func: bus: ''
    <hostdev mode="subsystem" type="pci" managed="yes">
      <source>
        <address domain="0x0000" bus="${devBus}" slot="0x00" function="${func}"/>
      </source>
      <address type="pci" domain="0x0000" bus="${bus}" slot="0x00" function="0x0"/>
    </hostdev>
  '';
in {
  amd = {
    video = pkgs.writeText "amd-video" (gpuDev "0x0f" "0x0" "0x05");
    audio = pkgs.writeText "amd-audio" (gpuDev "0x0f" "0x1" "0x06");
  };
  nvidia = {
    video = pkgs.writeText "amd-video" (gpuDev "0x0b" "0x0" "0x05");
    audio = pkgs.writeText "amd-audio" (gpuDev "0x0b" "0x1" "0x06");
  };
  usb = {
    template = bus: device: vendor: product: port: ''
      <hostdev mode="subsystem" type="usb" managed="yes">
        <source>
          <vendor id="0x${vendor}"/>
          <product id="0x${product}"/>
          <address bus="${bus}" device="${device}"/>
        </source>
        <address type="usb" bus="0" port="${port}"/>
      </hostdev>'';
  };
}

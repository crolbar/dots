{pkgs, ...}: let
  s = ''
    if [[ "$1" == "toggle-gpu" || "$1" == "tg" ]]; then
      if grep -Fxq "gpu_idx=0" "/var/lib/libvirt/win10/conf"; then
        sed -i "s/gpu_idx=0/gpu_idx=1/g" /var/lib/libvirt/win10/conf

        sudo sed -i "s/        <address domain='0x0000' bus='0x0f' slot='0x00' function='0x0'\/>/        <address domain='0x0000' bus='0x0b' slot='0x00' function='0x0'\/>/g" /var/lib/libvirt/qemu/win10.xml
        sudo sed -i "s/        <address domain='0x0000' bus='0x0f' slot='0x00' function='0x1'\/>/        <address domain='0x0000' bus='0x0b' slot='0x00' function='0x1'\/>/g" /var/lib/libvirt/qemu/win10.xml
        sudo virsh define /var/lib/libvirt/qemu/win10.xml

        dunstify "SWITCHING TO NVIDIA"
      else
        sed -i "s/gpu_idx=1/gpu_idx=0/g" /var/lib/libvirt/win10/conf

        sudo sed -i "s/        <address domain='0x0000' bus='0x0b' slot='0x00' function='0x0'\/>/        <address domain='0x0000' bus='0x0f' slot='0x00' function='0x0'\/>/g" /var/lib/libvirt/qemu/win10.xml
        sudo sed -i "s/        <address domain='0x0000' bus='0x0b' slot='0x00' function='0x1'\/>/        <address domain='0x0000' bus='0x0f' slot='0x00' function='0x1'\/>/g" /var/lib/libvirt/qemu/win10.xml
        sudo virsh define /var/lib/libvirt/qemu/win10.xml

        dunstify "SWITCHING TO AMD"
      fi
      exit
    fi

    if [[ "$1" == "conf" ]]; then
      cat /var/lib/libvirt/win10/conf
    fi

    if [[ "$1" == "xconf" ]]; then
      sudo cat /var/lib/libvirt/qemu/win10.xml
    fi

    if [[ "$1" == "toggle-vm" || "$1" == "tvm" ]]; then
      if [[ "$(sudo virsh domstate win10)" == "shut off" ]]; then
        echo "stopped"
        dunstify "TURNING ON VM "

        sleep 0.4
        sudo virsh start win10
      else
        echo "running"
        dunstify "SHUTTING DOWN VM "

        sleep 0.4
        sudo virsh shutdown win10
      fi
    fi


    if [[ "$1" == "help" || "$1" == "-h" ]]; then
      printf "
        toggle-gpu    toggles amd or nvidia
        toggle-vm     toggles on/off the win10 vm
        conf          cats hook config file
        xconf         cats xml vm config file
    \n"
    fi
  '';
in {
  home.file."scripts/wvm".source = pkgs.writers.writeBash "wvm" s;
  home.packages = [(pkgs.writers.writeBashBin "wvm" s)];
}

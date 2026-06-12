{pkgs, ...}: let
  devices = import ./win10devices.nix {inherit pkgs;};

  s =
    #bash
    ''
      if [[ "$1" == "toggle-gpu" || "$1" == "tg" ]]; then
        if grep -Fxq "gpu_idx=0" "/var/lib/libvirt/win10/conf"; then
          sed -i "s/gpu_idx=0/gpu_idx=1/g" /var/lib/libvirt/win10/conf

          sudo virsh detach-device win10 --config ${devices.amd.video}
          sudo virsh detach-device win10 --config ${devices.amd.audio}

          sudo virsh attach-device win10 --config ${devices.nvidia.video}
          sudo virsh attach-device win10 --config ${devices.nvidia.audio}

          sudo virsh define /var/lib/libvirt/qemu/win10.xml

          dunstify "SWITCHING TO NVIDIA"
        else
          sed -i "s/gpu_idx=1/gpu_idx=0/g" /var/lib/libvirt/win10/conf

          sudo virsh detach-device win10 --config ${devices.nvidia.video}
          sudo virsh detach-device win10 --config ${devices.nvidia.audio}

          sudo virsh attach-device win10 --config ${devices.amd.video}
          sudo virsh attach-device win10 --config ${devices.amd.audio}

          sudo virsh define /var/lib/libvirt/qemu/win10.xml

          dunstify "SWITCHING TO AMD"
        fi
        sed -i "s/USE_GPU=0/USE_GPU=1/g" /var/lib/libvirt/win10/conf
        exit
      fi

      if [[ "$1" == "remove-gpu" || "$1" == "rg" ]]; then
        if grep -Fxq "gpu_idx=0" "/var/lib/libvirt/win10/conf"; then
          sudo virsh detach-device win10 --config ${devices.amd.video}
          sudo virsh detach-device win10 --config ${devices.amd.audio}
        else
          sudo virsh detach-device win10 --config ${devices.nvidia.video}
          sudo virsh detach-device win10 --config ${devices.nvidia.audio}
        fi
        sed -i "s/USE_GPU=1/USE_GPU=0/g" /var/lib/libvirt/win10/conf
      fi

      if [[ "$1" == "conf" ]]; then
        cat /var/lib/libvirt/win10/conf
      fi

      if [[ "$1" == "xconf" ]]; then
        sudo cat /var/lib/libvirt/qemu/win10.xml
      fi

      if [[ "$1" == "pass-usb" || "$1" == "pu" ]]; then
        line=$(lsusb | fzf --tac)
        if [[ $? -ne 0 ]];then
          exit
        fi
        read -r _ bus _ dev _ id vendor_product <<< "$line"
        bus=$((10#''${bus}))
        device=$((10#''${dev%:}))
        vendor=''${id%%:*}
        product=''${id##*:}
        port=$((1+$(sudo virsh dumpxml win10 | grep -c "<hostdev mode='subsystem' type='usb'")))

        xml=$(cat <<END
        ${devices.usb.template "$bus" "$device" "$vendor" "$product" "$port"}
      END
        )

        path="/tmp/wvm-$(date +%s)"
        echo "$xml" > $path

        if [[ "$2" == "detach" || "$2" == "d" ]]; then
          sudo virsh detach-device win10 --live $path
        else
          sudo virsh attach-device win10 --live $path
        fi
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
          remove-gpu    removes the gpu device
          toggle-vm     toggles on/off the win10 vm
          pass-usb      passes the selected device
          conf          cats hook config file
          xconf         cats xml vm config file
      \n"
      fi
    '';
in {
  home.file."scripts/wvm".source = pkgs.writers.writeBash "wvm" s;
  home.packages = [(pkgs.writers.writeBashBin "wvm" s)];
}

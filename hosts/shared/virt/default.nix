{pkgs, ...}: let
  bind-hook = ''
    echo "Binding GPU to vfio"

    declare -n gpu=''${gpus[$gpu_idx]}

    systemd-run --machine=crolbar@ --user systemctl --user stop graphical-session.target
    systemctl stop openrgb

    sleep 0.8

    echo "''${gpu[audio_bus]}" | tee /sys/bus/pci/devices/''${gpu[audio_bus]}/driver/unbind

    if [[ $gpu_idx -eq 0 ]]; then
        modprobe -r radeon amdgpu
    else
        modprobe -r nvidia_uvm
        modprobe -r nvidia_drm
        modprobe -r nvidia_modeset
        modprobe -r nvidia
    fi

    modprobe vfio
    modprobe vfio_pci
    modprobe vfio_iommu_type1

    virsh nodedev-detach "pci_$(echo "''${gpu[video_bus]}" | sed "s/[:.]/_/g")"
    virsh nodedev-detach "pci_$(echo "''${gpu[audio_bus]}" | sed "s/[:.]/_/g")"

    echo "''${gpu[audio_id]}" | tee /sys/bus/pci/drivers/vfio-pci/new_id
    echo "''${gpu[video_id]}" | tee /sys/bus/pci/drivers/vfio-pci/new_id

    sleep 0.5

    systemctl start openrgb
  '';

  unbind-hook = ''
    echo "Restoring GPU drivers"

    declare -n gpu=''${gpus[$gpu_idx]}

    systemd-run --machine=crolbar@ --user systemctl --user stop graphical-session.target
    systemctl stop openrgb

    sleep 0.8

    echo "''${gpu[video_bus]}" | tee /sys/bus/pci/drivers/vfio-pci/unbind
    echo "''${gpu[audio_bus]}" | tee /sys/bus/pci/drivers/vfio-pci/unbind

    virsh nodedev-reattach "pci_$(echo "''${gpu[video_bus]}" | sed "s/[:.]/_/g")"
    virsh nodedev-reattach "pci_$(echo "''${gpu[audio_bus]}" | sed "s/[:.]/_/g")"

    modprobe -r vfio_iommu_type1
    modprobe -r vfio_pci
    modprobe -r vfio

    if [[ $gpu_idx -eq 0 ]]; then
        modprobe amdgpu radeon
    else
        modprobe nvidia
        modprobe nvidia_modeset
        modprobe nvidia_drm
        modprobe nvidia_uvm
    fi

    echo "''${gpu[audio_bus]}" | tee /sys/bus/pci/drivers/snd_hda_intel/bind

    sleep 0.5

    systemctl start openrgb
  '';

  global-hook = ''
    exec > >(systemd-cat -t vfio-hook -p info)
    exec 2> >(systemd-cat -t vfio-hook -p err)

    set -x

    VM="$1"
    OP="$2"
    SUBOP="$3"

    if [[ "$VM" == "win10" ]]; then
      source /var/lib/libvirt/win10/conf

      if [[ USE_GPU -ne 1 ]]; then
        exit
      fi

      if [[ "$OP" == "prepare" && "$SUBOP" == "begin" ]]; then
        ${bind-hook}
      fi

      if [[ "$OP" == "release" && "$SUBOP" == "end" ]]; then
        ${unbind-hook}
      fi
    fi
  '';

  conf = pkgs.writeText "win10conf.sh" ''
    declare -A amd=(
        [video_bus]="0000:0f:00.0"
        [audio_bus]="0000:0f:00.1"
        [video_id]="1002 7590"
        [audio_id]="1002 ab40"
    )

    declare -A nvidia=(
        [video_bus]="0000:0b:00.0"
        [audio_bus]="0000:0b:00.1"
        [video_id]="10de 1c02"
        [audio_id]="10de 10f1"
    )

    gpus=(amd nvidia)

    gpu_idx=0
    USE_GPU=1
  '';
in {
  systemd.tmpfiles.rules = [
    "d /var/lib/libvirt/win10 0775 crolbar users - -"
    "C /var/lib/libvirt/win10/conf 0664 crolbar users - ${conf}"
  ];

  virtualisation = {
    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      hooks.qemu."vfio-hook" = pkgs.writeShellScript "vfio-hook" global-hook;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;

        verbatimConfig = ''
          namespaces = []
          cgroup_device_acl = [
            "/dev/null", "/dev/full", "/dev/zero",
            "/dev/random", "/dev/urandom",
            "/dev/ptmx", "/dev/kvm", "/dev/kqemu",
            "/dev/rtc","/dev/hpet", "/dev/vfio/vfio",
            "/dev/kvmfr0"
          ]
        '';
      };
    };

    docker.enable = true;
  };

  programs.virt-manager.enable = true;
}

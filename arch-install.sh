#!/bin/bash
lsblk
echo  
echo "enter drive you want to install arch on:"
echo "example sda"
read  drive
echo "EVERYTHING ON DRIVE $drive WILL BE ERASED ARE YOU SHURE YOU WANT TO CONTINUE? [Y/n]"
read confirmation
echo $confirmation
if [[ $confirmation == y ]] || [[ $confirmation == yes ]]; 
then
    echo 
 elif [[ $confirmation == "" ]];
then
    CONTINUE
 else 
    exit
fi
echo "choose if you want to use efi or bios"
echo "example: efi"
read ef
echo $ef
if [[ $ef == efi ]] || [[ $ef == uefi ]]; 
then
    parted /dev/$drive mklabel gpt
    parted /dev/$drive mkpart ESP fat32 0% 128MiB
    parted /dev/$drive set 1 boot on
    parted /dev/$drive mkpart primary linux-swap 128MiB 8GiB
    parted /dev/$drive mkpart primary ext4 8GiB 100%
    mkfs.fat -F32 /dev/$drive'1'
    mkswap /dev/$drive'2'
    mkfs.ext4 /dev/$drive'3'
    mount /dev/$drive'3' /mnt
    mount -m /dev/$drive'1' /mnt/boot/efi
    pacstrap /mnt base base-devel linux linux-firmware grub nano networkmanager efibootmgr
 elif [[ $ef == bios ]];
then
    parted /dev/$drive mklabel msdos
    parted /dev/$drive mkpart primary ext4 1MiB 129MiB
    parted /dev/$drive set 1 boot on
    parted /dev/$drive mkpart primary linux-swap 128MiB 8GiB
    parted /dev/$drive mkpart primary ext4 8GiB 100%
    mkfs.ext4 /dev/$drive'1'
    mkswap /dev/$drive'2'
    mkfs.ext4 /dev/$drive'3'
    mount /dev/$drive'3' /mnt
    mount -m /dev/$drive'1' /mnt/boot
    pacstrap /mnt base base-devel linux linux-firmware grub nano networkmanager
 else 
    exit
fi
genfstab -U -p /mnt >> /mnt/etc/fstab 
arch-chroot /mnt systemctl enable NetworkManager
arch-chroot /mnt grub-install /dev/$drive
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
arch-chroot /mnt echo en_US.UTF-8 UTF-8 >> /etc/locale.gen
arch-chroot /mnt echo LANG="C.UTF-8" > /etc/locale.conf
arch-chroot /mnt locale-gen
arch-chroot /mnt echo arch > /etc/hostname
arch-chroot /mnt ln -sf /usr/share/zoneinfo/Europe/Sofia /etc/localtime 
arch-chroot /mnt useradd -mg wheel kubo
arch-chroot /mnt echo '%wheel ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers
arch-chroot /mnt passwd
arch-chroot /mnt passwd kubo
umount -R /mnt
echo "you can reboot now"
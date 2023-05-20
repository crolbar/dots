#!/bin/bash
# crolbar
echo ===================================================
lsblk
echo ===================================================
echo "
===============================================================
Chose a drive from the listed above you want to install arch on
example: sda
==============================================================="
read  drive
echo "
===================================================================================
EVERYTHING ON DRIVE $drive WILL BE ERASED ARE YOU SHURE YOU WANT TO CONTINUE? [Y/n]
==================================================================================="
read confirmation
if [[ $confirmation == y ]] || [[ $confirmation == yes ]]; 
then
    echo
 elif [[ $confirmation == "" ]];
then
    echo
 else 
    echo EXITING OUT OF ARCH-INSTALL
    exit
fi
echo "
===================================================
Choose what you want the setup to be for efi or bios
example: efi
==================================================="
read ef
echo "
=============================================
Do you want to create a swap partition? [Y/n]
============================================="
read swap
if [[ $swap == y ]] || [[ $swap == yes ]] || [[ $swap == "" ]]; 
then
echo "
=========================================================
How much space do you want to give the swap partition
example: 8G (in gigabytes) example2: 8192M (in megabytes)
========================================================="
read ss
 else 
    echo
fi
echo "
==================
Chose the hostname.
=================="
read host
echo "
===============================
Chose the name of the root user
==============================="
read user
umount -R /mnt
umount -R /mnt/boot
umount -R /mnt/boot/efi
echo
if  [[ $ef == efi ]] && [[ $swap == y || $swap == yes || $swap == "" ]]; 
then
        parted /dev/$drive mklabel gpt
        parted /dev/$drive mkpart ESP fat32 0% 128MiB
        parted /dev/$drive set 1 boot on
        parted /dev/$drive mkpart primary linux-swap 128MiB $ss'iB'
        parted /dev/$drive mkpart primary ext4 $ss'iB' 100%
        mkfs.fat -F32 /dev/$drive'1'
        mkswap /dev/$drive'2'
        mkfs.ext4 /dev/$drive'3'
        swapon /dev/$drive'2'
        mount /dev/$drive'3' /mnt
        mount -m /dev/$drive'1' /mnt/boot/efi
        pacstrap /mnt base base-devel linux linux-firmware grub nano networkmanager efibootmgr
        echo	"
        =======================================================================================================================
        FORMATED /dev/$drive AND CREATED A $ef BOOT PARTITION WITH AN SWAP PARTITION WITH $ss OF STORAGE AND A ROOT PARTITION
        ======================================================================================================================="
 elif [[ $ef == bios ]] && [[ $swap == y || $swap == yes || $swap == "" ]];
 then
        parted /dev/$drive mklabel msdos
        parted /dev/$drive mkpart primary ext4 0% 128MiB
        parted /dev/$drive set 1 boot on
        parted /dev/$drive mkpart primary linux-swap 128MiB $ss'iB'
        parted /dev/$drive mkpart primary ext4 $ss'iB' 100%
        mkfs.ext4 /dev/$drive'1'
        mkswap /dev/$drive'2'
        mkfs.ext4 /dev/$drive'3'
        swapon /dev/$drive'2'
        mount /dev/$drive'3' /mnt
        mount -m /dev/$drive'1' /mnt/boot
        pacstrap /mnt base base-devel linux linux-firmware grub nano networkmanager
        echo	"
        =======================================================================================================================
        FORMATED /dev/$drive AND CREATED A $ef BOOT PARTITION WITH AN SWAP PARTITION WITH $ss OF STORAGE AND A ROOT PARTITION
        ======================================================================================================================="
 elif [[ $ef == efi ]] && [[ $swap != y || $swap != yes || $swap != "" ]]
 then
        parted /dev/$drive mklabel gpt
        parted /dev/$drive mkpart ESP fat32 0% 128MiB
        parted /dev/$drive set 1 boot on
        parted /dev/$drive mkpart primary ext4 128MiB 100%
        mkfs.fat -F32 /dev/$drive'1'
        mkfs.ext4 /dev/$drive'2'
        mount /dev/$drive'2' /mnt
        mount -m /dev/$drive'1' /mnt/boot/efi
        pacstrap /mnt base base-devel linux linux-firmware grub nano networkmanager efibootmgr
        echo	"
        ==================================================================================================================
                        FORMATED /dev/$drive AND CREATED A $ef BOOT PARTITION WITH AN ROOT PARTITION
        =================================================================================================================="
 elif [[ $ef == bios ]] && [[ $swap != y || $swap != yes || $swap != "" ]];
 then
        parted /dev/$drive mklabel msdos
        parted /dev/$drive mkpart primary ext4 0% 128MiB
        parted /dev/$drive set 1 boot on
        parted /dev/$drive mkpart primary ext4 128MiB 100%
        mkfs.ext4 /dev/$drive'1'
        mkfs.ext4 /dev/$drive'2'
        mount /dev/$drive'2' /mnt
        mount -m /dev/$drive'1' /mnt/boot
        pacstrap /mnt base base-devel linux linux-firmware grub nano networkmanager
        echo	"
        ==================================================================================================================
                        FORMATED /dev/$drive AND CREATED A $ef BOOT PARTITION WITH AN ROOT PARTITION
        =================================================================================================================="
 else 
        echo "
        =================================================
                    EXITING OUT OF ARCH-INSTALL
        ================================================="
        exit
fi
genfstab -U -p /mnt >> /mnt/etc/fstab 
arch-chroot /mnt /bin/bash -c "systemctl enable NetworkManager"
arch-chroot /mnt /bin/bash -c "grub-install /dev/$drive"
arch-chroot /mnt /bin/bash -c "grub-mkconfig -o /boot/grub/grub.cfg"
arch-chroot /mnt /bin/bash -c "echo en_US.UTF-8 UTF-8 >> /etc/locale.gen"
arch-chroot /mnt /bin/bash -c "echo LANG="C.UTF-8" > /etc/locale.conf"
arch-chroot /mnt /bin/bash -c "locale-gen"
arch-chroot /mnt /bin/bash -c "ln -sf /usr/share/zoneinfo/Europe/Sofia /etc/localtime" 
arch-chroot /mnt /bin/bash -c "echo $host > /etc/hostname"
arch-chroot /mnt /bin/bash -c "useradd -mg wheel $user"
arch-chroot /mnt /bin/bash -c "echo '%wheel ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers"
echo "SET THE ROOT PASSWORD"
arch-chroot /mnt passwd
echo "SET THE USER PASSWORD"
arch-chroot /mnt passwd $user
ehco "
=========================================================================================
    ENABLED "NetworkManager" CHOSE EN_US FOR THE LOCALES AND /EU/SA FOR THE LOCALTIME
            CREATED A GRUB BOOT LOADER A HOSTNAME ($host) AND A USER ($user)        
========================================================================================="
echo
echo "
=========================================
do you want to use my bspwm config yes/no
========================================="
read WM
if [[ $WM == y ]] || [[ $WM == yes ]];
then
    arch-chroot -u $user /mnt /bin/bash -c "sudo pacman -Sy git"
    arch-chroot -u $user /mnt /bin/bash -c "sudo chown $user /root"
    arch-chroot -u $user /mnt /bin/bash -c "sudo git clone https://aur.archlinux.org/yay.git /home/$user/yay && cd /home/$user && sudo chown -R $user:users ./yay && cd yay && makepkg -si"
    arch-chroot -u $user /mnt /bin/bash -c "yay -Sy --noconfirm --needed bspwm sxhkd picom dmenu dunst polybar pulseaudio zsh pavucontrol neofetch alacritty lsd ttf-hack ttf-font-awesome ttf-roboto papirus-icon-theme xclip polkit-gnome materia-theme network-manager-applet xfce4-power-manager thunar feh firefox xorg-xrandr xorg-xinput xorg-server xorg-xinit gedit ly mesa physlock"
    arch-chroot -u $user /mnt /bin/bash -c "sudo systemctl enable ly.service"
    arch-chroot -u $user /mnt /bin/bash -c "cd /home/$user && \
    git clone https://github.com/crolbar/dots && \
     cd dots && \
     mkdir /home/$user/.config"
    arch-chroot -u $user /mnt /bin/bash -c "cd /home/$user/dots && \
     cp -a bspwm /home/$user/.config/bspwm && \
     cp -a alacritty /home/$user/.config/ && \
     cp -a neofetch /home/$user/.config/ && \
     cp -a zsh /home/$user/.config/ && \
     cp .zshrc /home/$user/"
elif [[ $WM == no ]];
then
    echo 
else 
    echo 
fi 
umount -R /mnt
echo "
==========================
    YOU CAN REBOOT NOW
=========================="
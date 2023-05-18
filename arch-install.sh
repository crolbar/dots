#!/bin/bash
lsblk
echo  
echo "enter drive you want to install arch on:"
echo "example sda"
read  drive
echo "EVERYTHING ON DRIVE $drive WILL BE ERASED ARE YOU SHURE YOU WANT TO CONTINUE? [Y/n]"
read confirmation
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
echo "Chose the name of the host"
read host
echo "Chose the name of the root user"
read user
umount -R /mnt
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
arch-chroot /mnt /bin/bash -c "systemctl enable NetworkManager"
arch-chroot /mnt /bin/bash -c "grub-install /dev/$drive"
arch-chroot /mnt /bin/bash -c "grub-mkconfig -o /boot/grub/grub.cfg"
arch-chroot /mnt /bin/bash -c "echo en_US.UTF-8 UTF-8 >> /etc/locale.gen"
arch-chroot /mnt /bin/bash -c "echo LANG="C.UTF-8" > /etc/locale.conf"
arch-chroot /mnt /bin/bash -c "locale-gen"
arch-chroot /mnt /bin/bash -c "echo $host > /etc/hostname"
arch-chroot /mnt /bin/bash -c "ln -sf /usr/share/zoneinfo/Europe/Sofia /etc/localtime" 
arch-chroot /mnt /bin/bash -c "useradd -mg wheel $user"
arch-chroot /mnt /bin/bash -c "echo '%wheel ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers"
arch-chroot /mnt passwd
arch-chroot /mnt passwd $user
echo "do you want to use my bspwm config yes/no"
read confirmation2
if [[ $confirmation2 == y ]] || [[ $confirmation2 == yes ]];
then
    arch-chroot -u $user /mnt /bin/bash -c "sudo pacman -Syy git"
    arch-chroot -u $user /mnt /bin/bash -c "sudo git clone https://aur.archlinux.org/yay.git /home/$user/ && cd /home/$user && sudo chown -R $user:users ./yay && cd yay && makepkg -si"
    arch-chroot -u $user /mnt /bin/bash -c "yay -S --needed bspwm sxhkd picom dmenu dunst polybar pulseaudio zsh pavucontrol neofetch alacritty lsd ttf-jetbrains-mono-nerd ttf-font-awesome ttf-roboto papirus-icon-theme xclip polkit-gnome materia-theme lxappearance network-manager-applet xfce4-power-manager nerd-fonts-complete-starship thunar feh firefox xorg-xrandr xorg-xinput xorg-server xorg-xinit gedit ly"
    arch-chroot -u $user /mnt /bin/bash -c "sudo systemctl enable ly.service"
    arch-chroot -u $user /mnt /bin/bash -c "cd /home/$user && \
    git clone https://github.com/crolbar/bspwm && cd bspwm && \
     cp -R bspwm /home/$user/.config/ && \
     cp -R alacritty /home/$user/.config/ && \
     neofetch /home/$user/.config/ && \
     zsh /home/$user/.config/ && \
     .zshrc /home/$user/"
elif [[confirmation2 == no ]];
then
    echo 
else 
    echo 
fi 
umount -R /mnt
echo "you can reboot now"



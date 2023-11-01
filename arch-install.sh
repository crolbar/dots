#!/bin/bash
# crolbar

# determine if the pc is running efi or bios
if [ -d "/sys/firmware/efi" ]; then
    ef=efi
else
    ef=bios
fi
clear
echo && echo

# display the disks to the user
echo "      ====================================================="
lsblk | awk '{print "       " $0}'
echo "      ====================================================="
echo "
    ===============================================================
    Chose a drive from the listed above you want to install arch on
    example: sda
    ==============================================================="
read -p  "    >" drive

# warn the user
echo "
    ===================================================================================
    EVERYTHING ON DRIVE $drive WILL BE ERASED ARE YOU SHURE YOU WANT TO CONTINUE? [Y/n]
    ==================================================================================="
read -p "    >" -n 1 confirmation

if [[ $confirmation == y || $confirmation == "" ]]; then
    echo
else
    echo EXITING OUT OF ARCH-INSTALL
    exit
fi

# swap partition creation
clear
echo "
    =============================================
    Do you want to create a swap partition? [Y/n]
    ============================================="
read -p "    >" -n 1 swapc
if [[ $swapc == y || $swapc == "" ]]; then
echo "
    =========================================================
    How much space do you want to give the swap partition
    example: 8G (in gigabytes) example2: 8192M (in megabytes)
    ========================================================="
    read -p "    >" ss
    swap=true
else
    swap=false
    ss=500M
fi

clear
echo && echo

# set hostname 
echo "
    ==================
    Chose the hostname
    =================="
read -p "    >" host
echo

# set username
echo "
    ================================
    Chose the username for your user
    ================================"
read -p "    >" user
echo

# set user password
echo "
    ================================
    Choose the PASSWORD for your user
    ================================"
prompt="    >"
userpasswd=""
while IFS= read -p "$prompt" -r -s -n 1 char
do
    if [[ $char == $'\0' ]]; then
        break
    elif [[ $char == $'\177' ]]; then
        if [ -n "$userpasswd" ]; then
            prompt=$'\b \b'
            userpasswd=${userpasswd%?}  
        fi
    else
        prompt='*' 
        userpasswd+="$char"
    fi
done
echo 

# set root password
echo "
    ===================================
    Chose the PASSWORD of the root user
    ==================================="
prompt="    >"
rootpasswd=""
while IFS= read -p "$prompt" -r -s -n 1 char
do
    if [[ $char == $'\0' ]]; then
        break
    elif [[ $char == $'\177' ]]; then 
        if [ -n "$rootpasswd" ]; then
            prompt=$'\b \b'  
            rootpasswd=${rootpasswd%?}  
        fi
    else
        prompt='*'  
        rootpasswd+="$char"
    fi
done
echo 

# GUI or no
echo "
    ====================================================
    do you want to use my bspwm or hyprwm config or none
    ====================================================
	[bsp] | [hypr] | [all] | [no]"
read -p "    >" WM
echo 

# GTK theme or no
echo "
    ===================================================================
    do you want to use the material black plum and dracula icons themes
    ===================================================================
	Y/n"
read -p "    >" -n 1 GTK 

# unmount devices if any
umount -r /mnt/boot/efi
umount -r /mnt/boot
umount -r /mnt

echo

#chek if the drive is an nvme and add an p at the end for the partition
if [[ $drive == nvme* ]]; then
    drivetmp="${drive}p"
else 
    drivetmp=$drive
fi

#   create the partitions depending if using swap or not and bios or efi
if [[ $ef == efi ]]; then 
    parted /dev/$drive mklabel gpt
    parted /dev/$drive mkpart ESP fat32 0% 500MiB
    parted /dev/$drive set 1 boot on
    parted /dev/$drive mkpart primary ext4 $ss'iB' 100%
    mkfs.fat -F32 /dev/$drivetmp'1'
    mkfs.ext4 /dev/$drivetmp'2'
    mount /dev/$drivetmp'2' /mnt
    mount -m /dev/$drivetmp'1' /mnt/boot/efi
    pacstrap /mnt base base-devel linux linux-firmware grub networkmanager efibootmgr sudo
elif [[ $ef == bios ]]; then
    parted /dev/$drive mklabel msdos
    parted /dev/$drive mkpart primary ext4 0% 500MiB
    parted /dev/$drive set 1 boot on
    parted /dev/$drive mkpart primary ext4 $ss'iB' 100%
    mkfs.ext4 /dev/$drivetmp'1'
    mkfs.ext4 /dev/$drivetmp'2'
    mount /dev/$drivetmp'2' /mnt
    mount -m /dev/$drivetmp'1' /mnt/boot
    pacstrap /mnt base base-devel linux linux-firmware grub networkmanager sudo
else
    echo "
            =================================================
                    EXITING OUT OF ARCH-INSTALL
            ================================================="
    exit
fi

if [[ $swap == true ]]; then
    parted /dev/$drive mkpart primary linux-swap 500MiB $ss'iB'
    mkswap /dev/$drivetmp'3'   
    swapon /dev/$drivetmp'3'
fi

# configuring the system
genfstab -U -p /mnt >> /mnt/etc/fstab 
arch-chroot /mnt /bin/bash -c "systemctl enable NetworkManager && \
grub-install /dev/$drive && \
grub-mkconfig -o /boot/grub/grub.cfg && \
echo en_US.UTF-8 UTF-8 >> /etc/locale.gen && \
echo LANG="C.UTF-8" > /etc/locale.conf && \
locale-gen && \
ln -sf /usr/share/zoneinfo/Europe/Sofia /etc/localtime && \
echo $host > /etc/hostname && \
useradd -mg wheel $user && \
echo '%wheel ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers && \
echo '$user:$userpasswd' | chpasswd && \
echo 'root:$rootpasswd' | chpasswd"
echo "
        =========================================================================================
            ENABLED "NetworkManager" CHOSE EN_US FOR THE LOCALES AND /EU/SA FOR THE LOCALTIME
                    CREATED A GRUB BOOT LOADER A HOSTNAME ($host) AND A USER ($user)        
        ========================================================================================="
echo 

# GUI setup
export user
if [[ $WM == bsp ]]; then
	arch-chroot /mnt /bin/bash -c "sudo pacman -Sy --noconfirm git && git clone https://github.com/crolbar/dots && /dots/bspwm-install.sh arch-install"
elif [[ $WM == hypr ]]; then
	arch-chroot /mnt /bin/bash -c "sudo pacman -Sy --noconfirm git && git clone https://github.com/crolbar/dots && /dots/hypr-install.sh arch-install"
elif [[ $WM == all ]]; then
	arch-chroot /mnt /bin/bash -c "sudo pacman -Sy --noconfirm git && git clone https://github.com/crolbar/dots && /dots/hypr-install.sh arch-install && /dots/bspwm-install.sh arch-install"
fi

if [[ $GTK == Y || $GTK == y ]]; then
    mkdir -p /mnt/usr/share/themes
    mkdir -p /mnt/usr/share/icons
    cp -r /root/dots/Material-Black-Plum /mnt/usr/share/themes
    git clone https://github.com/m4thewz/dracula-icons /mnt/usr/share/icons/dracula-icons
fi

# umounting 
umount -R /mnt
echo "
        ==========================
            YOU CAN REBOOT NOW
        =========================="

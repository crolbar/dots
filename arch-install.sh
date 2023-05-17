#!/bin/bash
lsblk
echo  
echo "enter drive you want to install arch on:"
echo "example /dev/sda"
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
    parted $drive mklabel gpt
    parted $drive mkpart ESP fat32 1MiB 129MiB
    parted $drive set 1 boot on
    parted $drive mkpart primary linux-swap 129MiB 8.2GiB
    parted $drive mkpart primary ext4 8.2GiB 100%
 elif [[ $ef == bios ]];
then
    parted $drive mklabel msdos
    parted $drive mkpart primary ext4 1MiB 129MiB
    parted $drive set 1 boot on
    parted $drive mkpart primary ext4 129MiB 100%
 else 
    exit
fi



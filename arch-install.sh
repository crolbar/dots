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
 elif [[ $ef == bios ]];
then
    parted /dev/$drive mklabel msdos
    parted /dev/$drive mkpart primary ext4 1MiB 129MiB
    parted /dev/$drive set 1 boot on
    parted /dev/$drive mkpart primary ext4 129MiB 100%
 else 
    exit
fi



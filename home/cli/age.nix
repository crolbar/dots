{
  pkgs,
  lib,
  config,
  ...
}: let
  age = lib.getExe pkgs.age;

  agehIdPath = "${config.home.homeDirectory}/.ssh/id_rsa";
  agehRePath = "${config.home.homeDirectory}/.ssh/id_rsa.pub";

  editor = "$EDITOR";

  ageh = pkgs.writers.writeBashBin "ageh" ''
    if [ "$1" == "-e" ]; then
        if [ -z $2 ]; then
            printf "\e[31mNo path provided.\e[0m\n" && exit
        fi

        if [ -d "$2" ]; then
            printf "\e[31mPath points to a directory.\e[0m\n" && exit
        fi

        if [ ! -f "$2" ]; then
            echo | ${age} -R ${agehRePath} -o "$2"

            if [ $? -ne 0 ]; then
                printf "\e[31mFailed to encrypt an empty file to $2 with ${agehRePath}.\e[0m\n"
                rm -rf $tmpDir
                exit
            fi
        fi

        d=$(date +%s)
        name=$(basename "$2")
        tmpDir=/tmp/ageh-"$d"
        tmpFile=/tmp/ageh-"$d"/"$name"

        mkdir $tmpDir

        ${age} -d -i ${agehIdPath} -o $tmpFile "$2"

        if [ $? -ne 0 ]; then
            printf "\e[31mFailed to decrypt file at: $2.\e[0m\n"
            rm -rf $tmpDir
            exit
        fi

        ${editor} $tmpFile

        if [ $? -ne 0 ]; then
            printf "\e[31mFailed to open file at: $tmpFile.\e[0m\n"
            rm -rf $tmpDir
            exit
        fi

        ${age} -R ${agehRePath} -o "$2" $tmpFile

        if [ $? -ne 0 ]; then
            printf "\e[31mFailed to encrypt file: $tmpFile to $2 with ${agehRePath}.\e[0m\n"
            rm -rf $tmpDir
            exit
        fi

        rm -rf $tmpDir

        exit
    fi

    if [ "$1" == "-d" ]; then
        if [ -z $2 ]; then
            printf "\e[31mNo path provided.\e[0m\n" && exit
        fi

        if [ -d "$2" ]; then
            printf "\e[31mPath points to a directory.\e[0m\n" && exit
        fi

        if [ ! -f "$2" ]; then
            printf "\e[31mNo such file. $2\e[0m\n" && exit
        fi

        ${age} -d -i ${agehIdPath} "$2"

        exit
    fi

    printf "ageh {-e,-d} [PATH] \n\nARGS: \n-d     decrypt the file at the given PATH to STDOUT \n-e     create/edit the file at PATH and encrypt after.\n"
  '';
in {
  home.packages = [pkgs.age ageh];
}

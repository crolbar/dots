{
  pkgs,
  config,
  ...
}: let
  musicDir = "${config.home.homeDirectory}/Music";
in {
  imports = [./rmpc];

  services = {
    mpd-discord-rpc = {
      enable = true;
      settings = {
        id = 1283875986626187304;
      };
    };
    mpd = {
      enable = true;
      musicDirectory = musicDir;
      playlistDirectory = "${musicDir}/playlists";
      # pipewire as output from https://github.com/yavko/Dotfiles
      extraConfig = ''
        audio_output {
          type "pipewire"
          name "PipeWire Sound Server"
        }
        audio_output {
          type "fifo"
          name "pipe"
          path "/tmp/mpd.fifo"
        }
        replaygain "track"
        replaygain_limit "no"
      '';
    };
    mpdris2.enable = true; # fixes playerctl
  };

  home.packages = [
    pkgs.spotdl

    (pkgs.writers.writeBashBin "sync-mpd" ''
      if [[ -z $1 ]]; then
          printf "\e[33mNo args provided.\e[0m\n" && exit
      fi

      if [[ "$1" == s* ]]; then
          printf "\e[32mUpdating shit..\e[0m\n"
          playlist_url="https://open.spotify.com/playlist/4scDNeQvKAsUgx90ZO1klA?si=5fefc2a55cd94b98"
          playlist_dir="$HOME/Music/shit"
      elif [[ "$1" == c* ]]; then
          printf "\e[32mUpdating cringe..\e[0m\n"
          playlist_url="https://open.spotify.com/playlist/0WddaO6UOKmxyx1pVpy9Ds?si=21f6f7286afc41da"
          playlist_dir="$HOME/Music/cringe"
      elif [[ "$1" == d* ]]; then
          printf "\e[32mUpdating depression..\e[0m\n"
          playlist_url="https://open.spotify.com/playlist/0nQBrSpBDGaYNrOzSzetWw?si=e8a2781a7138451e"
          playlist_dir="$HOME/Music/depression"
      else
          echo "Not a valit playlist idiot" && exit
      fi

      cd "$playlist_dir" || exit

      echo "Want to continue? ... (dir: $playlist_dir, url: $playlist_url)"
      read -r

      printf "\e[32mStarting spotdl..\e[0m\n"
      spotdl "$playlist_url"

      printf "\e[32mKilling mpd services..\e[0m\n"
      systemctl stop --user mpd-discord-rpc.service mpdris2.service mpd.service

      printf "\e[31mRemoving ~/.local/share/mpd/tag_cache..\e[0m\n"
      rm ~/.local/share/mpd/tag_cache
      printf "\e[31mRemoving ~/Music/playlists/*..\e[0m\n"
      rm ~/Music/playlists/*

      printf "\e[32mStarting mpd services..\e[0m\n"
      systemctl start --user mpd-discord-rpc.service mpdris2.service mpd.service
    '')
  ];
}

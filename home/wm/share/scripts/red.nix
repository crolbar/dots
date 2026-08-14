{pkgs, ...}: {
  home.file."scripts/red.sh".source = pkgs.writers.writeBash "red" ''
    up() {
        workspaces=$(echo "windows" | socat - UNIX-CONNECT:"$RED_SOCKET")
        echo "{\"workspaces\": $workspaces}"
    }
    up

    (echo "sub"; tail -f /dev/null) | socat - UNIX-CONNECT:"$RED_SOCKET" | while read -r l; do up "$l"; done
  '';
}

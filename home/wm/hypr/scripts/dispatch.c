#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>


const int ZERO_ASCII = 48;
const int NINE_ASCII = 57;

int is_number(char* str) {
    for (int i = 0; i < strlen(str); i++) 
    {
        char c = str[i];
        if (c > NINE_ASCII || c < ZERO_ASCII) {
            return 0;
        }
    }
    return 1;
}

int main(int argc, char** argv) 
{
    const char* HYPRLAND_INSTANCE_SIGNATURE = getenv("HYPRLAND_INSTANCE_SIGNATURE");
    const char* XDG_RUNTIME_DIR = getenv("XDG_RUNTIME_DIR");
    
    if (argc == 3)
    {
        char* wid = argv[1];
        if (is_number(wid))
        {
            int move_win_to = !strcmp(argv[2], "s");

            int client_fd;
            struct sockaddr_un addr;
            client_fd = socket(AF_UNIX, SOCK_STREAM, 0);
            if (client_fd == -1) {
                perror("socket");
                exit(EXIT_FAILURE);
            }
            memset(&addr, 0, sizeof(struct sockaddr_un));
            addr.sun_family = AF_UNIX;

            //$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock
            char* sock_path_fmt = "%s/hypr/%s/.socket.sock";
            size_t sock_path_size = strlen(HYPRLAND_INSTANCE_SIGNATURE) + strlen(XDG_RUNTIME_DIR) + strlen(sock_path_fmt);
            char* sock_path = malloc(sock_path_size);
            sprintf(sock_path, sock_path_fmt, XDG_RUNTIME_DIR, HYPRLAND_INSTANCE_SIGNATURE);

            strncpy(addr.sun_path, sock_path, sizeof(addr.sun_path) - 1);

            if (connect(client_fd, (struct sockaddr *)&addr, sizeof(struct sockaddr_un)) == -1) {
                perror("connect");
                exit(EXIT_FAILURE);
            }

            char* fmt = "/dispatch %s %s";
            char* action = (move_win_to) ? "movetoworkspacesilent" : "workspace";
            size_t size = strlen(fmt) + strlen(action);
            char* cmd = malloc(size);
            sprintf(cmd, fmt, action, wid);

            write(client_fd, cmd, size);

            free(cmd);
            free(sock_path);
        } else {
            printf("workspace id (first arg) is not a number\n"); 
        }
    } else {
        printf("incorect num of arguments\n"); 
    }
    return 0;
}

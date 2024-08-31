#!/usr/bin/env scriptisto

// scriptisto-begin
// script_src: workspace_scroll.c
// build_cmd: gcc workspace_scroll.c -o ./script
// scriptisto-end

#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>


int socket_connect(char* socket_path) 
{
    int socket1;
    struct sockaddr_un socket1_addr;
    {
        socket1 = socket(AF_UNIX, SOCK_STREAM, 0);
        if (socket1 == -1) 
        {
            perror("socket");
            exit(EXIT_FAILURE);
        }
        memset(&socket1_addr, 0, sizeof(struct sockaddr_un));
        socket1_addr.sun_family = AF_UNIX;
    }

    strncpy(socket1_addr.sun_path, socket_path, sizeof(socket1_addr.sun_path) - 1);

    if (connect(socket1, (struct sockaddr *)&socket1_addr, sizeof(struct sockaddr_un)) == -1) 
    {
        perror("connect");
        exit(EXIT_FAILURE);
    }

    return socket1;
}

int get_workspace_id(char* str) 
{
    int num = 0;

    int negative = 0;
    int start = 0;
    for(int i = 0; i < strlen(str); i++) {
        if (str[i] == ',') {
            break;
        } else if (str[i] == ':') {
            start = 1;
        } else if (str[i] == '-') {
            negative = 1;
        } else if (start) {
            num = num * 10 + str[i] - '0';
        }
    }
    if (negative) {
        num *= -1;
    }

    return num;
}

char* trim(char* str) 
{
    if (str == NULL) 
    {
        return NULL;
    }

    size_t non_whitespace_count = 0;
    char *read = str;
    while (*read) 
    {
        if (*read != ' ' && *read != '\n') 
        {
            non_whitespace_count++;
        }
        read++;
    }

    char* new_str = malloc(non_whitespace_count + 1);
    if (new_str == NULL) 
    {
        return NULL;
    }

    read = str;
    char *write = new_str;
    while (*read) 
    {
        if (*read != ' ' && *read != '\n') 
        {
            *write++ = *read;
        }
        read++;
    }
    *write = '\0';

    free(str);

    return new_str;
}

int* get_workspace_ids(char* str,
        size_t str_len,
        int workspaces_end,
        int* workspace_ids_size)
{
    char* w = malloc(workspaces_end + 1);

    strncpy(w, str, workspaces_end);
    w[workspaces_end] = '\0';
    char* wrk = trim(w);
    size_t wrk_len = strlen(wrk);

    int num_wrksps = 0;
    for (int i = 0; i < wrk_len; i++) {
        if (wrk[i] == '{' )
            num_wrksps += 1;
    }

    size_t wrk_ids_size = 0;
    int* wrk_ids = malloc(num_wrksps * sizeof(int));

    int start = 0;
    int end = 0;
    for (int i = 0; i < wrk_len; i++) {
        if (wrk[i] == '{') {
            start = i;
        } else if (wrk[i] == '}') {
            end = i;

            size_t size = (end + 1) - start;

            char* tmp = malloc(size + 1);
            strncpy(tmp, wrk + start, size);
            tmp[size] = '\0';

            wrk_ids[wrk_ids_size] = get_workspace_id(tmp);

            free(tmp);
            wrk_ids_size += 1;
        }
    }

    free(wrk);

    for (int i = 1; i < wrk_ids_size; i++) {
        int key = wrk_ids[i];
        int j = i - 1;

        while (j >= 0 && wrk_ids[j] > key) {
            wrk_ids[j + 1] = wrk_ids[j];
            j = j - 1;
        }
        wrk_ids[j + 1] = key;
    }
    
    *workspace_ids_size = wrk_ids_size;
    return wrk_ids;
}

int get_activeworkspace_id(char* str,
        size_t str_len,
        int workspaces_end,
        int activeworkspace_end)
{
    size_t activeworkspace_size = (activeworkspace_end - workspaces_end) - 3;
    char* activeworkspace = malloc(activeworkspace_size + 1);
    strncpy(activeworkspace, str + (workspaces_end + 3), activeworkspace_size);
    activeworkspace[activeworkspace_size] = '\0';
     

    char* awid = strstr(activeworkspace, "\"id\": ");
    if (awid == NULL) {
        free(activeworkspace);
        return 0;
    }

    int fw = 0;
    int neg = 0;

    int activeworkspace_id = 0;

    for (int i = 0; i < strlen(awid); i++) {
        if (awid[i] == ' ') {
            fw = 1;
        } else if (awid[i] == ',') {
            break;
        } else if (awid[i] == '-' && fw) {
            neg = 1;
        } else if (fw) {
            activeworkspace_id = activeworkspace_id * 10 + awid[i] - '0';
        }
    }

    if (neg)
        activeworkspace_id *= -1;

    free(activeworkspace);

    return activeworkspace_id;
}


int get_np_workspace_id(int up, char* str) 
{
    size_t str_len = strlen(str);
    int workspaces_end = -1;

    for (int i = 0; i < str_len; i++) {
        if (i < str_len - 1) {
            if (str[i] == '\n' && str[i+1] == '\n' && str[i+2] == '\n') {
                if (workspaces_end == -1) {
                    workspaces_end = i;
                }else {
                    break;
                }
            }
        }
    }

    int workspace_ids_size = 0;
    int* workspace_ids = get_workspace_ids(str, str_len, workspaces_end, &workspace_ids_size);


    int awid = get_activeworkspace_id(str, str_len, workspaces_end, str_len);


    int id = 0;
    int u = (1 * (up) ? -1 : 1);

    for (int i = 0; i < workspace_ids_size; i++) {
        if (i != 0 && up || i != workspace_ids_size - 1 && !up) {
            if (awid == workspace_ids[i]) {
                id = workspace_ids[i + u];
            }
        }
    }

    free(workspace_ids);
    return id;
}

int main(int argc, char** argv) 
{
    setvbuf(stdout, NULL, _IONBF, 0);

    const char* HYPRLAND_INSTANCE_SIGNATURE = getenv("HYPRLAND_INSTANCE_SIGNATURE");
    const char* XDG_RUNTIME_DIR = getenv("XDG_RUNTIME_DIR");

    char* sock_path_fmt = "%s/hypr/%s/.socket.sock";
    size_t sock_path_size = strlen(HYPRLAND_INSTANCE_SIGNATURE) + strlen(XDG_RUNTIME_DIR) + strlen(sock_path_fmt) + 1;
    char* sock_path = malloc(sock_path_size);

    sprintf(sock_path, sock_path_fmt, XDG_RUNTIME_DIR, HYPRLAND_INSTANCE_SIGNATURE);

    if (argc != 2) {
        return 0;
    }
    int up = !strcmp(argv[1], "up");

    char* buffer = malloc(8192);

    int w_id = 0;
    {
        int socket1 = socket_connect(sock_path);
        char *s = "[[BATCH]]j/workspaces ; j/activeworkspace";

        write(socket1, s, strlen(s));


        size_t size_red = read(socket1, buffer, 8192);
        if (size_red > 0) {
            size_t reply_size = size_red + 1;
            char* reply = malloc(reply_size);
            strncpy(reply, buffer, size_red);
            reply[size_red] = '\0';

            while (size_red == 8192) {
                size_red = read(socket1, buffer, 8192);

                size_t new_reply_size = reply_size + size_red;
                char *new_reply = realloc(reply, new_reply_size);

                reply = new_reply;
                strncat(reply, buffer, size_red);
                reply_size = new_reply_size;
            }

            reply[reply_size-1] = '\0';

            w_id = get_np_workspace_id(up, reply);

            free(reply);
        }

        close(socket1);
    }

    if (w_id) {
        int socket1 = socket_connect(sock_path);

        char *s = NULL;
        if (w_id == -1337) {
            s = "/dispatch workspace name:0";
        } else {
            char* s_fmt = "/dispatch workspace %d";
            size_t s_size = strlen(s_fmt)+1;
            s = malloc(s_size);
            sprintf(s, s_fmt, w_id);
        }

        write(socket1, s, strlen(s));

        if (w_id != -1337)
            free(s);
    }


    free(buffer);
    free(sock_path);
    return 0;
}

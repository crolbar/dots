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

char* get_workspaces(char* str,
        size_t str_len,
        int workspaces_end)
{
    size_t workspaces_size = 0;

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

    size_t wrk_arr_size = 0;
    char* wrk_arr[num_wrksps];

    int start = 0;
    int end = 0;
    for (int i = 0; i < wrk_len; i++) {
        if (wrk[i] == '{') {
            start = i;
        } else if (wrk[i] == '}') {
            end = i;

            size_t size = (end + 1) - start;
            workspaces_size += size;

            wrk_arr[wrk_arr_size] = malloc(size + 1);
            strncpy(wrk_arr[wrk_arr_size], wrk + start, size);
            wrk_arr[wrk_arr_size][size] = '\0';

            wrk_arr_size += 1;
        }
    }

    free(wrk);

    for (int i = 1; i < wrk_arr_size; i++) {
        char* w = wrk_arr[i];
        int key = get_workspace_id(w);
        int j = i - 1;

        while (j >= 0 && get_workspace_id(wrk_arr[j]) > key) {
            wrk_arr[j + 1] = wrk_arr[j];
            j = j - 1;
        }
        wrk_arr[j + 1] = w;
    }

    workspaces_size += (num_wrksps - 1) + 2;

    char* workspaces = malloc(workspaces_size + 1);
    strcpy(workspaces, "[");

    for (int i = 0; i < wrk_arr_size; i++) {
        strcat(workspaces, wrk_arr[i]);
        if (i != wrk_arr_size - 1) {
            strcat(workspaces, ",");
        }
        free(wrk_arr[i]);
    }

    workspaces[workspaces_size-1] = ']';
    workspaces[workspaces_size] = '\0';

    return workspaces;
}

char* get_activeworkspace_id(char* str,
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
        return NULL;
    }

    int awid_start = -1;
    int awid_end = -1;

    for (int i = 0; i < strlen(awid); i++) {
        if (awid[i] == ' ') {
            awid_start = i;
        } else if (awid[i] == ',') {
            awid_end = i;
            break;
        }
    }

    size_t activeworkspace_id_size = awid_end - awid_start - 1;
    char* activeworkspace_id = malloc(activeworkspace_id_size + 1);
    strncpy(activeworkspace_id, awid + awid_start+1, activeworkspace_id_size);
    activeworkspace_id[activeworkspace_id_size] = '\0';

    free(activeworkspace);

    return activeworkspace_id;
}

char* get_activewidnow_title(char* str,
        size_t str_len,
        int activewindow_end,
        int activeworkspace_end)
{
    size_t activewindow_size = (activewindow_end - activeworkspace_end) - 3;
    char* activewindow = malloc(activewindow_size + 1);
    strncpy(activewindow, str + (activeworkspace_end + 3), activewindow_size);
    activewindow[activewindow_size] = '\0';

    char* aw = strstr(activewindow, "\"title\": ");

    if (aw == NULL) {
        free(activewindow);
        return NULL;
    }

    int aw_start = -1;
    int aw_end = -1;


    for (int i = 1; i < strlen(aw); i++) {
        if (aw[i-1] == ' ' && aw[i] == '"' && aw_start == -1) {
            aw_start = i;
        } else if (aw[i] == '"' && aw[i+1] == ',') {
            aw_end = i;
            break;
        }
    }


    size_t activewidnow_title_size = (aw_end - aw_start) - 1;
    char* activewidnow_title = malloc(activewidnow_title_size + 1);
    strncpy(activewidnow_title, aw + aw_start + 1, activewidnow_title_size);
    activewidnow_title[activewidnow_title_size] = '\0';

    free(activewindow);
    return activewidnow_title;
}

char* get_keymap(char* str,
        size_t str_len,
        int activewindow_end)
{
    size_t devices_size = str_len - activewindow_end - 3;
    char* devices = malloc(devices_size + 1);
    strncpy(devices, str + activewindow_end + 3, devices_size);
    devices[devices_size] = '\0';

    char* kb = strstr(devices, "\"name\": \"crolbar-yuki\",");
    if (kb == NULL) {
        free(devices);
        return NULL;
    }

    char* km = strstr(kb, "\"active_keymap\": ");

    if (km == NULL) {
        free(devices);
        return NULL;
    }

    int km_start = -1;
    int km_end = -1;


    for (int i = 1; i < strlen(km); i++) {
        if (km[i-1] == ' ' && km[i] == '"' && km_start == -1) {
            km_start = i;
        } else if (km[i] == '"' && km[i+1] == ',') {
            km_end = i;
            break;
        }
    }


    size_t keymap_size = (km_end - km_start) - 1;
    char* keymap = malloc(keymap_size + 1);
    strncpy(keymap, km + km_start + 1, keymap_size);
    keymap[keymap_size] = '\0';

    free(devices);

    return keymap;
}

char* get_obj(char* str) 
{

    size_t str_len = strlen(str);
    int workspaces_end = -1;
    int activeworkspace_end = -1;
    int activewindow_end = -1;

    for (int i = 0; i < str_len; i++) {
        if (i < str_len - 1) {
            if (str[i] == '\n' && str[i+1] == '\n' && str[i+2] == '\n') {
                if (workspaces_end == -1) {
                    workspaces_end = i;
                } else if (activeworkspace_end == -1) {
                    activeworkspace_end = i;
                } else if (activewindow_end == -1) {
                    activewindow_end = i;
                } else {
                    break;
                }
            }
        }
    }

    char* workspaces = get_workspaces(str, str_len, workspaces_end);
    char* activeworkspace_id = get_activeworkspace_id(str, str_len, workspaces_end, activeworkspace_end);
    char* activewidnow_title = get_activewidnow_title(str, str_len, activewindow_end, activeworkspace_end);
    char* keymap = get_keymap(str, str_len, activewindow_end);

    //printf("workspaces: `%s`\n", workspaces);
    //printf("keymap: `%s`\n", keymap);
    //printf("activeworkspace_id: `%s`\n", activewidnow_title);
    //printf("activeworkspace_id: `%s`\n", activeworkspace_id);

    char* empty = "  ";
    if (workspaces == NULL) {
        workspaces = malloc(3);
        strcpy(workspaces, "[]");
        workspaces[2] = '\0';
    }
    if (activeworkspace_id == NULL) {
        activeworkspace_id = malloc(3);
        strcpy(activeworkspace_id, empty);
        activeworkspace_id[2] = '\0';
    }
    if (activewidnow_title == NULL) {
        activewidnow_title = malloc(3);
        strcpy(activewidnow_title, empty);
        activewidnow_title[2] = '\0';
    }
    if (keymap == NULL) {
        keymap = malloc(3);
        strcpy(keymap, empty);
        keymap[2] = '\0';
    }

    char* obj_fmt = "{\"workspaces\": %s, \"active\": \"%s\", \"currwin\": \"%s\", \"kb_layout\": \"%s\"}\n";
    size_t obj_size = strlen(obj_fmt) + strlen(keymap) + strlen(activeworkspace_id) + strlen(activewidnow_title) + strlen(workspaces) + 1;
    char* obj = malloc(obj_size);
    sprintf(obj, obj_fmt, workspaces, activeworkspace_id, activewidnow_title, keymap);

    free(activeworkspace_id);
    free(activewidnow_title);
    free(keymap);
    free(workspaces);

    return obj;
}

void stop(int sig) {exit(0);}

int main(int argc, char** argv) 
{
    signal(SIGINT, stop);
    setvbuf(stdout, NULL, _IONBF, 0);

    const char* HYPRLAND_INSTANCE_SIGNATURE = getenv("HYPRLAND_INSTANCE_SIGNATURE");
    const char* XDG_RUNTIME_DIR = getenv("XDG_RUNTIME_DIR");

    char* sock_path_fmt = "%s/hypr/%s/.socket.sock";
    size_t sock_path_size = strlen(HYPRLAND_INSTANCE_SIGNATURE) + strlen(XDG_RUNTIME_DIR) + strlen(sock_path_fmt) + 1;
    char* sock_path = malloc(sock_path_size);

    {
        char* sock_path_fmt = "%s/hypr/%s/.socket2.sock";
        sprintf(sock_path, sock_path_fmt, XDG_RUNTIME_DIR, HYPRLAND_INSTANCE_SIGNATURE);
    }
    int socket2 = socket_connect(sock_path);

    sprintf(sock_path, sock_path_fmt, XDG_RUNTIME_DIR, HYPRLAND_INSTANCE_SIGNATURE);


    char* buffer = malloc(8192);

    while (read(socket2, buffer, 8192) > 0)
    {
        //printf("%s\n", buffer);
        int socket1 = socket_connect(sock_path);

        {
            char *s = "[[BATCH]]j/workspaces ; j/activeworkspace ; j/activewindow ; j/devices";

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

               char* c = get_obj(reply);
                if (c)
                    printf("%s", c);

                free(reply);
                free(c);
            }
        }

        memset(buffer, 0, 8192);
        close(socket1);
    }

    free(buffer);
    free(sock_path);
    close(socket2);
    return 0;
}

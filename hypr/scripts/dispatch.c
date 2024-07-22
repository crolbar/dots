#include <stdio.h>
#include <stdlib.h>
#include <string.h>
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
    if (argc == 3)
    {
        char* wid = argv[1];
        if (is_number(wid))
        {
            int move_win_to = !strcmp(argv[2], "s");

            char* fmt = "hyprctl dispatch %s %s";
            char* action = (move_win_to) ? "movetoworkspacesilent" : "workspace";
            char* cmd = malloc(strlen(fmt) + strlen(action));
            sprintf(cmd, fmt, action, wid);
            system(cmd);
        } else {
            printf("workspace id (first arg) is not a number\n"); 
        }
    } else {
        printf("incorect num of arguments\n"); 
    }
    return 0;
}

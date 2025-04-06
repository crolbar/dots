#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

void
stop(int sig)
{
    exit(0);
}

int
main()
{
    signal(SIGINT, stop);
    setvbuf(stdout, NULL, _IONBF, 0);

    FILE* p = popen("ristate -vt -t -u", "r");

    char* buffer = malloc(8192);

    while (fgets(buffer, 8192, p)) {
        int ft = -1;
        {
            char* needle = "\"focused_tags\":{\"SamsungDisplayCorp.\":[\"";
            char* str_ft = strstr(buffer, needle);

            if (str_ft) {
                str_ft += strlen(needle);

                int tag = 0;
                while (*str_ft >= '0' && *str_ft <= '9') {
                    tag *= 10;
                    tag += *str_ft - '0';
                    str_ft++;
                }

                ft = tag;
            }
        }

        int ut = -1;
        {
            char* needle = "\"urgency\":{\"SamsungDisplayCorp.\":[\"";
            char* str_ut = strstr(buffer, needle);

            if (str_ut) {
                str_ut += strlen(needle);

                int tag = 0;
                while (*str_ut >= '0' && *str_ut <= '9') {
                    tag *= 10;
                    tag += *str_ut - '0';
                    str_ut++;
                }

                ut = tag;
            }
        }

        int tags[10] = {};
        int tags_num = 0;
        {
            char* needle = "\"view_tags\":{\"SamsungDisplayCorp.\":[";
            char* str_tags = strstr(buffer, needle);
            if (!str_tags)
                continue;

            str_tags += strlen(needle);

            do {
                if (*str_tags > '9' || *str_tags < '0')
                    continue;

                int tag = 0;
                while (*str_tags >= '0' && *str_tags <= '9') {
                    tag *= 10;
                    tag += *str_tags - '0';
                    str_tags++;
                }

                int has = 0;
                for (int i = 0; i < tags_num; i++)
                    if (tags[i] == tag)
                        has = 1;

                if (!has)
                    tags[tags_num++] = tag;
            } while (*str_tags++ != ']');

            int tags_has_ft = 0;

            for (int i = 0; i < tags_num; i++)
                if (tags[i] == ft)
                    tags_has_ft = 1;

            if (!tags_has_ft)
                tags[tags_num++] = ft;

            for (int i = 0; i < tags_num; i++) {
                for (int j = 0; j < tags_num - 1 - i; j++) {
                    if (tags[j] > tags[j + 1]) {
                        int tmp = tags[j];
                        tags[j] = tags[j + 1];
                        tags[j + 1] = tmp;
                    }
                }
            }
        }

        printf("{\"tags\":[");
        for (int i = 0; i < tags_num; i++) {
            printf("%d", tags[i]);
            if (i < tags_num - 1)
                printf(",");
        }
        printf("]");
        printf(",\"urgent\":\"%d\"", ut);
        printf(",\"focused\":\"%d\"", ft);

        printf("}\n");
    }

    pclose(p);
    free(buffer);
    return 0;
}

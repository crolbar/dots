#!/usr/bin/env scriptisto

// scriptisto-begin
// script_src: weather.c
// build_cmd: gcc weather.c -o ./script
// scriptisto-end

#include <stdio.h> 
#include <stdlib.h>
#include <string.h>

char* get_attr(char* set, char* attr) {
    char* start = strstr(set, attr);
    start += strlen(attr) + 2;

    int is_str = 0;
    if (*start == '"') {
        start++;
        is_str = 1;
    }

    char* p = start;
    size_t len = 0;

    while (*p != ',' && *p != '}') {
        len++;
        p++;
    }

    if (is_str) {
        len--;
    }

    char* attr_val = malloc(len + 1);
    strncpy(attr_val, start, len);
    attr_val[len] = '\0';

    return attr_val;
}
  
int main() 
{
    char* key = "aba36eff207740e0a5e234935232607";
    char* city = "Silistra";
    char* cmd_fmt = "curl -s \"https://api.weatherapi.com/v1/current.json?key=%s&q=%s\"";
    size_t cmd_len = strlen(cmd_fmt) + strlen(key) + strlen(city);
    char* cmd = malloc(cmd_len+1);
    sprintf(cmd, cmd_fmt, key, city);

    FILE* p = popen(cmd, "r");

    char* resp = NULL;
    size_t resp_size = 0;
    if (getline(&resp, &resp_size, p) != -1) {
        char* temp = get_attr(resp, "temp_c");
        char* status = get_attr(resp, "text");
        char* icon_code = get_attr(resp, "code");
        char* wind_speed = get_attr(resp, "wind_kph");
        char* is_day = get_attr(resp, "is_day");

        char* icon_color = NULL;
        char* icon = NULL;

        if (!strcmp(icon_code, "1000")) { icon = ""; icon_color = "#ffb78a"; }
        else if (!strcmp(icon_code, "1003")) { icon = ""; icon_color = "#b1e4eb"; }
        else if (!strcmp(icon_code, "1006")) { icon = ""; icon_color = "#b1e4eb"; }
        else if (!strcmp(icon_code, "1009")) { icon = ""; icon_color = "#b1e4eb"; }
        else if (!strcmp(icon_code, "1030")) { icon = ""; icon_color = "#c9c9c9"; }
        else if (!strcmp(icon_code, "1063")) { icon = ""; icon_color = "#83ace2"; }
        else if (!strcmp(icon_code, "1066")) { icon = ""; icon_color = "#cad2db"; }
        else if (!strcmp(icon_code, "1069")) { icon = ""; icon_color = "#83ace2"; }
        else if (!strcmp(icon_code, "1072")) { icon = ""; icon_color = "#83ace2"; }
        else if (!strcmp(icon_code, "1087")) { icon = ""; icon_color = "#eff0b3"; }
        else if (!strcmp(icon_code, "1114")) { icon = ""; icon_color = "#cad2db"; }
        else if (!strcmp(icon_code, "1117")) { icon = ""; icon_color = "#cad2db"; }
        else if (!strcmp(icon_code, "1135")) { icon = ""; icon_color = "#c9c9c9"; }
        else if (!strcmp(icon_code, "1147")) { icon = ""; icon_color = "#c9c9c9"; }
        else if (!strcmp(icon_code, "1150")) { icon = ""; icon_color = "#83ace2"; }
        else if (!strcmp(icon_code, "1168")) { icon = ""; icon_color = "#83ace2"; }
        else if (!strcmp(icon_code, "1171")) { icon = ""; icon_color = "#83ace2"; }
        else if (!strcmp(icon_code, "1180")) { icon = ""; icon_color = "#83ace2"; }
        else if (!strcmp(icon_code, "1183")) { icon = ""; icon_color = "#83ace2"; }
        else if (!strcmp(icon_code, "1189")) { icon = ""; icon_color = "#83ace2"; }
        else if (!strcmp(icon_code, "1192")) { icon = ""; icon_color = "#83ace2"; }
        else if (!strcmp(icon_code, "1195")) { icon = ""; icon_color = "#83ace2"; }
        else if (!strcmp(icon_code, "1198")) { icon = ""; icon_color = "#83ace2"; }
        else if (!strcmp(icon_code, "1201")) { icon = ""; icon_color = "#83ace2"; }
        else if (!strcmp(icon_code, "1204")) { icon = ""; icon_color = "#83ace2"; }
        else if (!strcmp(icon_code, "1207")) { icon = ""; icon_color = "#83ace2"; }
        else if (!strcmp(icon_code, "1210")) { icon = ""; icon_color = "#b1e4eb"; }
        else if (!strcmp(icon_code, "1213")) { icon = ""; icon_color = "#cad2db"; }
        else if (!strcmp(icon_code, "1216")) { icon = ""; icon_color = "#b1e4eb"; }
        else if (!strcmp(icon_code, "1219")) { icon = ""; icon_color = "#cad2db"; }
        else if (!strcmp(icon_code, "1222")) { icon = ""; icon_color = "#cad2db"; }
        else if (!strcmp(icon_code, "1225")) { icon = ""; icon_color = "#cad2db"; }
        else if (!strcmp(icon_code, "1237")) { icon = ""; icon_color = "#cad2db"; }
        else if (!strcmp(icon_code, "1240")) { icon = ""; icon_color = "#83ace2"; }
        else if (!strcmp(icon_code, "1243")) { icon = ""; icon_color = "#83ace2"; }
        else if (!strcmp(icon_code, "1246")) { icon = ""; icon_color = "#83ace2"; }
        else if (!strcmp(icon_code, "1249")) { icon = ""; icon_color = "#83ace2"; }
        else if (!strcmp(icon_code, "1252")) { icon = ""; icon_color = "#83ace2"; }
        else if (!strcmp(icon_code, "1255")) { icon = ""; icon_color = "#cad2db"; }
        else if (!strcmp(icon_code, "1258")) { icon = ""; icon_color = "#cad2db"; }
        else if (!strcmp(icon_code, "1261")) { icon = ""; icon_color = "#cad2db"; }
        else if (!strcmp(icon_code, "1264")) { icon = ""; icon_color = "#cad2db"; }
        else if (!strcmp(icon_code, "1273")) { icon = ""; icon_color = "#eff0b3"; }
        else if (!strcmp(icon_code, "1276")) { icon = ""; icon_color = "#eff0b3"; }
        else if (!strcmp(icon_code, "1279")) { icon = ""; icon_color = "#eff0b3"; }
        else if (!strcmp(icon_code, "1282")) { icon = ""; icon_color = "#eff0b3"; }
        else { icon = ""; icon_color = "#83ace2"; }

        if (!strcmp(is_day, "0")) {
            if (!strcmp(icon, "")) { icon = ""; icon_color = "#83ace2"; }
            else { icon = ""; icon_color = "#b1e4eb"; }
        }

        printf
            (
                "{\"temp\": \"%s\", \"status\": \"%s\", \"icon\": \"%s\", \"icon_color\": \"%s\", \"wind_speed\": \"%s\"}\n",
                    temp,             status,             icon,             icon_color,             wind_speed
            );

        free(temp);
        free(status);
        free(icon_code);
        free(wind_speed);
        free(is_day);
    }

    free(resp);
    free(cmd);
    pclose(p);
    return 0;
}


#include <stdio.h>
#include <stdlib.h>
#include <pulse/pulseaudio.h>
#include <string.h>

static pa_context *context = NULL;
static pa_mainloop *mainloop = NULL;
static int target_index = -1;
static int volume_change_percent = 2;

// Define the callback for getting the current sink input info
static void sink_input_info_callback(pa_context *c, const pa_sink_input_info *info, int eol, void *userdata) {
    if (eol > 0) {
        pa_mainloop_quit(mainloop, 0);
        return;
    }

    pa_cvolume volume = info->volume;
    for (int i = 0; i < volume.channels; i++) {
        int new_val = volume.values[i] + ((volume_change_percent / 100.0) * PA_VOLUME_NORM);

        if (new_val < 0) {
            new_val = PA_VOLUME_MUTED;
        }

        if (new_val > PA_VOLUME_UI_MAX) {
            new_val = PA_VOLUME_UI_MAX;
        }

        volume.values[i] = new_val;
    }

    pa_operation *vol_op = pa_context_set_sink_input_volume(c, info->index, &volume, NULL, NULL);
    if (vol_op) {
        pa_operation_unref(vol_op);
    }
}

static void context_state_callback(pa_context *c, void *userdata) {
    switch (pa_context_get_state(c)) {
        case PA_CONTEXT_READY: {
            pa_operation *o;

            // Request the sink input information
            if (!(o = pa_context_get_sink_input_info(c, target_index, sink_input_info_callback, userdata))) {
                fprintf(stderr, "pa_context_get_sink_input_info() failed\n");
                pa_mainloop_quit(mainloop, 1);
            }
            pa_operation_unref(o);
            break;
        }

        case PA_CONTEXT_FAILED:
        case PA_CONTEXT_TERMINATED:
            pa_mainloop_quit(mainloop, 1);
            break;

        default:
            break;
    }
}

int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <sink_input_index> <volume_change_percent>\n", argv[0]);
        return 1;
    }

    char* cmd = NULL;
    if (!strcmp(argv[1], "browser")) {
        cmd = "pactl list sink-inputs | awk -v m_app=\"Firefox\" '/Sink Input #/{gsub(\"#\",\"\",$NF); m_id=$NF} /application.name/{if ($0~m_app) print m_id}'";
    } else if (!strcmp(argv[1], "music")) {
        cmd = "pactl list sink-inputs | awk -v m_app=\"spotify\" '/Sink Input #/{gsub(\"#\",\"\",$NF); m_id=$NF} /application.name/{if ($0~m_app) print m_id}'";
    } else {
        return 1;
    }

    FILE* p = popen(cmd, "r");

    int ret = 1;

    char *line = NULL;
    size_t len = 0;
    ssize_t read;
    int c = 0;

    while (getline(&line, &len, p) != -1) {
        if (c % 2 == 0) {
            if (!strlen(line)) {
                return 1;
            }

            target_index = atoi(line);
            volume_change_percent = atoi(argv[2]);

            mainloop = pa_mainloop_new();
            context = pa_context_new(
                    pa_mainloop_get_api(mainloop),
                    "vol");

            pa_context_set_state_callback(context, context_state_callback, NULL);
            pa_context_connect(context, NULL, PA_CONTEXT_NOFLAGS, NULL);

            if (pa_mainloop_run(mainloop, &ret) < 0) {
                fprintf(stderr, "pa_mainloop_run() failed.\n");
                ret = 1;
            }
        }

        c++;
    }

    pa_context_disconnect(context);
    pa_context_unref(context);
    pa_mainloop_free(mainloop);
    pclose(p);

    return ret;
}

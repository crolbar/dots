import Quickshell.Io

IpcHandler {
    target: "main"

    function getWindows(): string {
        let result = "";

        for (let key in root.windows) {
            const w = root.windows[key];
            result += key + ": " + w + "\n";
        }

        return result;
    }

    function open(win: string): string {
        if (!(win in root.windows)) {
            var s = "win: " + win + " not defined";
            console.warn("win:", win, "not defined");
            return s;
        }

        root.windows[win].visible = true;
        return "ok";
    }
    function close(win: string): string {
        if (!(win in root.windows)) {
            var s = "win: " + win + " not defined";
            console.warn("win:", win, "not defined");
            return s;
        }

        root.windows[win].visible = false;
        return "ok";
    }
    function toggle(win: string): string {
        if (!(win in root.windows)) {
            var s = "win: " + win + " not defined";
            console.warn("win:", win, "not defined");
            return s;
        }

        root.windows[win].visible = !(root.windows[win].visible);
        return "ok";
    }
}

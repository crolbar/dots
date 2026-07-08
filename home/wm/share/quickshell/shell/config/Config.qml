import QtQuick

QtObject {
    property int selected_tray_item: -1
    onSelected_tray_itemChanged: {
        const tray_open = selected_tray_item != -1;
        if (tray_open) {
            last_selected_tray_item = selected_tray_item;
        }
        if (bar_popout_border_visible_for != "tray" && tray_open)
            bar_popout_border_visible_for = "tray";
    }
    property int last_selected_tray_item: -1
    property int selected_tray_item_center_y: 0
    property bool selected_tray_item_noexit: false
    property bool bar_popout_border_visible: false
    property string bar_popout_border_visible_for: ""
    property bool bar_popout_audio_ctl_open: false
    onBar_popout_audio_ctl_openChanged: {
        if (bar_popout_border_visible_for != "audio" && bar_popout_audio_ctl_open)
            bar_popout_border_visible_for = "audio";
    }
    property int bar_popout_audio_ctl_center_y: 0
    property int bar_height: 0

    property bool media_popout_open: false
    property int media_popout_y: 0

    property bool power_popout_open: false
    property int power_popout_x: 0
}

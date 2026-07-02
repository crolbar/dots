import QtQuick

QtObject {
    property int selected_tray_item: -1
    onSelected_tray_itemChanged: {
        if (selected_tray_item != -1) {
            last_selected_tray_item = selected_tray_item;
        }
    }
    property int last_selected_tray_item: -1
    property int selected_tray_item_center_y: 0
    property bool selected_tray_item_noexit: false
    property bool bar_popout_border_visible: false
    property bool bar_popout_audio_ctl_open: false
    property int bar_popout_audio_ctl_center_y: 0
}

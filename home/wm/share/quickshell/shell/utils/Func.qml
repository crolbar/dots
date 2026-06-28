pragma Singleton
import QtQuick 2.15

QtObject {
    function delay(ms, callback) {
        var timer = Qt.createQmlObject('import QtQuick 2.15; Timer {}', Qt.application, "DelayTimer");
        timer.interval = ms;
        timer.repeat = false;

        timer.triggered.connect(function () {
            if (callback)
                callback();
            timer.destroy();
        });

        timer.start();
    }
}

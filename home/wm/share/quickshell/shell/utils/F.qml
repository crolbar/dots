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
    function isTop(side: int): bool {
        return side == PopoutWindow.Side.Top;
    }
    function isRight(side: int): bool {
        return side == PopoutWindow.Side.Right;
    }
    function isBottom(side: int): bool {
        return side == PopoutWindow.Side.Bottom;
    }
    function isLeft(side: int): bool {
        return side == PopoutWindow.Side.Left;
    }
    function isVert(side: int): bool {
        return side == PopoutWindow.Side.Top || side == PopoutWindow.Side.Bottom;
    }
    function isHori(side: int): bool {
        return side == PopoutWindow.Side.Right || side == PopoutWindow.Side.Left;
    }

    function sendRequest(url, callback) {
        let request = new XMLHttpRequest();

        request.onreadystatechange = function () {
            if (request.readyState === XMLHttpRequest.DONE) {
                let response = {
                    status: request.status,
                    headers: request.getAllResponseHeaders(),
                    contentType: request.responseType,
                    body: request.response
                };

                callback(response);
            }
        };

        request.open("GET", url);
        request.send();
    }
}

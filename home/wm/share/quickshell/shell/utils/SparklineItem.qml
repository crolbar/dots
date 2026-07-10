import QtQuick

Item {
    id: root

    property var line1: []
    property var line2: []

    property color line1Color: "white"
    property color line2Color: "white"
    property real line1FillAlpha: 0.2
    property real line2FillAlpha: 0.2
    property real lineWidth: 2

    property real maxValue: 100
    property int historyLength: 30

    property real slideProgress: 1

    onLine1Changed: canvas.requestPaint()
    onLine2Changed: canvas.requestPaint()
    onSlideProgressChanged: canvas.requestPaint()
    onWidthChanged: canvas.requestPaint()
    onHeightChanged: canvas.requestPaint()
    onMaxValueChanged: canvas.requestPaint()

    Canvas {
        id: canvas
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);
            ctx.lineJoin = "round";
            ctx.lineCap = "round";

            var has1 = root.line1 && root.line1.length >= 2;
            var has2 = root.line2 && root.line2.length >= 2;
            if (!has1 && !has2)
                return;

            if (has1)
                drawLine(ctx, root.line1, root.line1Color, root.line1FillAlpha);
            if (has2)
                drawLine(ctx, root.line2, root.line2Color, root.line2FillAlpha);
        }

        function drawLine(ctx, buffer, color, fillAlpha) {
            if (root.historyLength < 2)
                return;

            ctx.lineWidth = root.lineWidth;
            ctx.strokeStyle = color;

            var w = width;
            var h = height;
            var len = buffer.length;
            var stepX = w / (root.historyLength - 1);

            var startX = w - (len - 1) * stepX - stepX * root.slideProgress + stepX;

            function px(i) {
                return startX + i * stepX;
            }
            function py(v) {
                return h - (v / root.maxValue) * h;
            }

            // stroke the line
            ctx.beginPath();
            ctx.moveTo(px(0), py(buffer[0]));
            for (var i = 1; i < len; i++)
                ctx.lineTo(px(i), py(buffer[i]));
            ctx.stroke();

            // fill under line
            ctx.lineTo(px(len - 1), h);
            ctx.lineTo(px(0), h);
            ctx.closePath();
            ctx.fillStyle = Qt.rgba(color.r, color.g, color.b, fillAlpha);
            ctx.fill();
        }
    }
}

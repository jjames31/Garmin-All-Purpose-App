using Toybox.Graphics;
using Toybox.Activity;
using Toybox.WatchUi;

module heartbeat {

    var hrValues = [];

    const MAX_SAMPLES = 40;

    // Chart range in BPM
    const MIN_HR = 50;
    const MAX_HR = 180;

    // Chart box bounds in Cartesian coordinates.
    const BOX_LEFT_X = -150;
    const BOX_RIGHT_X = 150;
    const BOX_BOTTOM_Y = 40;
    const BOX_TOP_Y = 110;

    // Keep the plotted line slightly inside the border.
    const CHART_PADDING = 4;

    function start() {
        updateHeartRate();
    }

    function stop() {
    }

    function updateHeartRate() {
        var info = Activity.getActivityInfo();

        if (info != null && info.currentHeartRate != null) {
            hrValues.add(info.currentHeartRate);

            if (hrValues.size() > MAX_SAMPLES) {
                hrValues.remove(0);
            }
        }
    }

    function print(dc) {
        draw(dc);
    }

    function draw(dc) {
        updateHeartRate();

        var count = hrValues.size();
        var chartLeftX = BOX_LEFT_X + CHART_PADDING;
        var chartRightX = BOX_RIGHT_X - CHART_PADDING;
        var chartBottomY = BOX_BOTTOM_Y + CHART_PADDING;
        var chartTopY = BOX_TOP_Y - CHART_PADDING;

        // Label
        dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);

        if (count > 0) {
            var currentHr = hrValues[count - 1];

            dc.drawText(
                utils.cTsX(0),
                utils.cTsY(110),
                Graphics.FONT_XTINY,
                currentHr.toString() + " bpm",
                Graphics.TEXT_JUSTIFY_CENTER
            );
        } else {
            dc.drawText(
                utils.cTsX(0),
                utils.cTsY(175),
                Graphics.FONT_XTINY,
                "-- bpm",
                Graphics.TEXT_JUSTIFY_CENTER
            );
        }

        // Chart box
        dc.setColor(Graphics.COLOR_DK_RED, Graphics.COLOR_TRANSPARENT);

        dc.drawRectangle(
            utils.cTsX(BOX_LEFT_X),
            utils.cTsY(BOX_TOP_Y),
            BOX_RIGHT_X - BOX_LEFT_X,
            BOX_TOP_Y - BOX_BOTTOM_Y
        );

        if (count < 2) {
            return;
        }

        // Heartbeat line
        dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);

        for (var i = 0; i < count - 1; i++) {
            var hr1 = clampHr(hrValues[i]);
            var hr2 = clampHr(hrValues[i + 1]);

            var x1 = chartLeftX + ((chartRightX - chartLeftX) * i) / (count - 1);
            var x2 = chartLeftX + ((chartRightX - chartLeftX) * (i + 1)) / (count - 1);

            var y1 = chartBottomY + ((hr1 - MIN_HR) * (chartTopY - chartBottomY)) / (MAX_HR - MIN_HR);
            var y2 = chartBottomY + ((hr2 - MIN_HR) * (chartTopY - chartBottomY)) / (MAX_HR - MIN_HR);

            dc.drawLine(
                utils.cTsX(x1),
                utils.cTsY(y1),
                utils.cTsX(x2),
                utils.cTsY(y2)
            );
        }
    }

    function clampHr(hr) {
        if (hr < MIN_HR) {
            return MIN_HR;
        }

        if (hr > MAX_HR) {
            return MAX_HR;
        }

        return hr;
    }
}

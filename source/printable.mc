import Toybox.Graphics;
import Toybox.WatchUi;
using Toybox.System;
using Toybox.Timer;

module printable {
    const TITLE_CENTER_Y = -140;

    function title(dc) {

        dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
        dc.drawLine(utils.cTsX(-180), utils.cTsY(TITLE_CENTER_Y + 25), utils.cTsX(180), utils.cTsY(TITLE_CENTER_Y + 25));
        dc.drawLine(utils.cTsX(-180), utils.cTsY(TITLE_CENTER_Y + 26), utils.cTsX(180), utils.cTsY(TITLE_CENTER_Y + 26));
        dc.drawLine(utils.cTsX(-180), utils.cTsY(TITLE_CENTER_Y + 27), utils.cTsX(180), utils.cTsY(TITLE_CENTER_Y + 27));

        dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
        dc.drawText(utils.cTsX(0), utils.cTsY(TITLE_CENTER_Y + (25 / 2)), Graphics.FONT_XTINY, "Garmin All Purpose", Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(utils.cTsX(1), utils.cTsY(TITLE_CENTER_Y + (25 / 2)), Graphics.FONT_XTINY, "Garmin All Purpose", Graphics.TEXT_JUSTIFY_CENTER);
       
        dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
        dc.drawText(utils.cTsX(0), utils.cTsY(TITLE_CENTER_Y - (25 / 2)), Graphics.FONT_XTINY, "App", Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(utils.cTsX(1), utils.cTsY(TITLE_CENTER_Y - (25 / 2)), Graphics.FONT_XTINY, "App", Graphics.TEXT_JUSTIFY_CENTER);
    }

    function time(dc) {
        dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);

        var t = System.getClockTime();
        var timeText = t.hour.format("%02d") + ":" + t.min.format("%02d") + ":" + t.sec.format("%02d");

        dc.drawText(utils.cTsX(0), utils.cTsY(25), Graphics.FONT_SMALL, timeText, Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(utils.cTsX(1), utils.cTsY(25), Graphics.FONT_SMALL, timeText, Graphics.TEXT_JUSTIFY_CENTER);
       
        dc.drawLine(utils.cTsX(-100), utils.cTsY(-30), utils.cTsX(100), utils.cTsY(-30));

        dc.drawLine(utils.cTsX(-100), utils.cTsY(30), utils.cTsX(100), utils.cTsY(30));

    }
}

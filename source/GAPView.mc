import Toybox.Graphics;
import Toybox.WatchUi;
using Toybox.System;
using Toybox.Timer;

class GAPView extends WatchUi.View {
    private var clockTimer;

    function initialize() {
        View.initialize();
        clockTimer = new Timer.Timer();
    }

    function onShow() {
        if (clockTimer != null) {
            clockTimer.start(method(:onSecond), 1000, true);
        }
    }

    function onSecond() {
        WatchUi.requestUpdate();
    }

    function onUpdate(dc) {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();

        printable.title(dc);
        printable.time(dc);
        heartbeat.print(dc);
        
    }


    function onHide() {
        if (clockTimer != null) {
            clockTimer.stop();
        }
    }
}

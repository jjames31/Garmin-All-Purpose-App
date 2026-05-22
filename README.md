# GAP

`GAP` is a Garmin Connect IQ watch app for the `fr165m` that renders a simple red-on-black dashboard with:

- a title banner
- a live clock
- a heart rate chart

## Project Layout

- `source/GAPApp.mc`: app entry point
- `source/GAPView.mc`: main view update loop
- `source/printable.mc`: title and time drawing
- `source/heartbeat.mc`: heart rate sampling and chart rendering
- `source/utils.mc`: Cartesian-to-screen coordinate helpers
- `resources/strings.xml`: app name
- `resources/images/icon.png`: launcher icon

## Heart Rate Chart

The heart rate module reads `Activity.getActivityInfo().currentHeartRate`, stores up to `40` samples, and draws the trend inside a boxed chart area.

Current chart settings in [`source/heartbeat.mc`](/home/jaco/Main/Garmin/GAP/source/heartbeat.mc):

- BPM range: `50` to `180`
- Box bounds: `x = -150..150`, `y = 40..110`
- Inner plot padding: `4`

The plotted line is inset from the border so the graph stays visually inside the box.

## Build Notes

- `manifest.xml` is configured as a `watch-app`
- target product: `fr165m`
- minimum API level: `3.0.0`

The manifest still uses the placeholder app UUID:

`00000000-0000-0000-0000-000000000000`

Replace that before publishing or distributing the app.

## Important Note

DO not use the run_simultor.sh to build and test the app without update the directories and comand to work for your system.

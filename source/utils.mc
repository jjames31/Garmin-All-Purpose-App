module utils {

    const FR165_SCREEN_WIDTH = 390;
    const FR165_SCREEN_HEIGHT = 390;
    const FR165_CENTER_X = FR165_SCREEN_WIDTH / 2;
    const FR165_CENTER_Y = FR165_SCREEN_HEIGHT / 2;

    function cartesianToScreen(x, y) {
        return [
            FR165_CENTER_X + x,
            FR165_CENTER_Y - y
        ];
    }

    function cTsX(x) {
        return FR165_CENTER_X + x;
    }

    function cTsY(y) {
        return FR165_CENTER_Y - y;
    }
}

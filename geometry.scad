module trapezoid(x1 = 10, x2 = 20, h = 15, r = 0, center = 0, $fn = 16)
{
    x_big = max(x1, x2);
    x_small = min(x1, x2);
    x_diff = x_big - x_small;

    p_y0 = 0;
    p_y1 = h;
    p_y2 = h;
    p_y3 = 0;

    p_x0 = 0;
    p_x1 = x_diff / 2;
    p_x2 = x_diff / 2 + x_small;
    p_x3 = x_big;

    center_x = center ? -(x_big / 2) : 0;
    center_y = center ? -(h / 2) : 0;

    scale([ 1 / $fn, 1 / $fn, 1 ]) offset(r * $fn) offset(-r * $fn) scale([ $fn, $fn, 1 ])
        translate([ center_x, center_y ]) if (x1 > x2)
    {
        polygon(points = [[p_x0, p_y0], [p_x1, p_y1], [p_x2, p_y2], [p_x3, p_y3]]);
    }
    else
    {
        translate([ 0, h, 0 ]) mirror([ 0, 1, 0 ])
            polygon(points = [[p_x0, p_y0], [p_x1, p_y1], [p_x2, p_y2], [p_x3, p_y3]]);
    }
}
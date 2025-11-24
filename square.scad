
/*
|\                  /| y4
| \                / |
|  \______________/  | y3
|                    |
|                    |
|   ______________   | y2
|  /              \  |
| /                \ |
|/                  \| y1
x1 x2             x3 x4


*/

square_different_y(y_different=12, do_left=false);

module square_different_y(size = [10, 10], y_different = 12, y_off = 2, center = false, do_left = true, do_right = true) {
  x = size[0];
  y = size[1];

  y_different = (!do_right && !do_left) ? y : y_different;

  y_max = max(y, y_different);
  y_diff = (y_different - y) / 2;

  assert(y_different >= 0);
  assert(y_off * 2 <= x);

  x1 = 0;
  x2 = y_off;
  x3 = x - y_off;
  x4 = x;

  y1 = 0;
  y2 = y_diff;
  y3 = y_diff + y;
  y4 = y_diff + y + y_diff;

  center_y = center ? -y_max / 2 : 0;
  center_x = center ? -x / 2 : 0;

  trans_cor_y = (y_diff < 0) ? -y_diff : 0;
  translate([center_x, center_y, 0])
    translate([0, trans_cor_y, 0])

      polygon(
        points=[
          // LEFT
          [x2, y2],
          [x1, do_left ? y1 : y2],
          [x1, do_left ? y4 : y3],
          [x2, y3],

          // RIGHT
          [x3, y3],
          [x4, do_right ? y4 : y3],
          [x4, do_right ? y1 : y2],
          [x3, y2],
        ]
      );
}

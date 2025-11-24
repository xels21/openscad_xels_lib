


// square_different_y();
// square_different_y(center=true);
// square_different_y(center=false, y_different=3, y_off=2);

module square_different_y(size = [10, 10], y_different = 12, y_off = 2, center = true) {
  x = size[0];
  y = size[1];
  y_max = max(y, y_different);
  translate_x = center ? -x / 2 : 0;
  translate_y = center ? -y_max / 2 : 0;
  translate([translate_x, translate_y, 0])
    union() {
      square_different_y_one_side([x / 2, y], y_different, y_off, is_left=true, center=false);
      translate([x / 2, 0, 0])
        square_different_y_one_side([x / 2, y], y_different, y_off, is_left=false, center=false);
    }
}

module square_different_y_one_side(size = [10, 10], y_different = 12, y_off = 2, is_left = true, center = false) {
  assert(y_different >= 0);
  x = size[0];
  y = size[1];
  assert(x >= y_off);
  y_max = max(y, y_different);
  y_diff = (y_different - y) / 2;
  // if(center){
  //   translate([-x, -y_max/2, 0])
  // }
  center_x = center ? -x / 2 : 0;
  center_y = center ? -y_max / 2 : 0;

  translate_x = is_left ? x : 0;
  mirror_x = is_left ? 1 : 0;
  translate([center_x, center_y, 0])
    translate([translate_x, 0, 0])
      mirror(v=[mirror_x, 0, 0])
        _square_different_y_right_side(x=x, y=y, y_diff=y_diff, y_off=y_off);
}

module _square_different_y_right_side(x, y, y_diff, y_off) {
  translate_y = y_diff > 0 ? y_diff : 0;
  translate([0, translate_y])
    polygon(
      [
        [0, 0],
        [0, y],
        [x - y_off, y],
        [x, y + y_diff],
        [x, -y_diff],
        [x - y_off, 0],
        [0, 0],
      ]
    );
}

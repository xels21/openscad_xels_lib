// Customize these parameters in OpenSCAD:
// n: number of segments for the base polygon (and rotational symmetry). Use 6 for classic hexafoil.
_n = 6;// [1:1:16]
// rows: number of hexafoil rows in the grid (vertical count).
_rows = 4;// [1:1:32]
// column: number of hexafoil columns in the grid (horizontal count). Uses staggered layout; even numbers recommended.
_column = 4;// [1:1:32]
// gap: radial gap subtracted from each circle to thin petals/outlines (increase to get thinner lines).
_gap = 5;// [-32:1:32]
// off_deg: rotation offset in degrees to rotate each layer; tweak to align or stylize petals.
_off_deg = 0;// [-180:1:180]
// r: base radius of the circles forming the hexafoil (overall size).
_r = 10;// [0:1:32]
// t: ring thickness for outlines; set to 0 for solid fill, >0 for ring/contour.
_t = .5;// [0:0.1:32]
// fn: polygon/circle resolution. `$fn` is the global resolution; increase for smoother curves.
_fn = 6;// [3:1:256]

// Call with your custom parameters (prefixed with `_` when using OpenSCAD customizer):
// - n: symmetry/segments (6 = hexafoil)
// - rows, column: grid size (staggered hex layout)
// - gap: petal thinning (higher = thinner)
// - off_deg: rotation offset for visual variation
// - r: base radius (size)
// - t: thickness (0 = solid, >0 = outline)
// - fn: resolution (higher = smoother)
hexafoil(
  n=_n,
  rows=_rows,
  column=_column,
  gap=_gap,
  off_deg=_off_deg,
  r=_r,
  t=_t,
  fn=_fn
);

module hexafoil_single(n = 6, r = 10, gap = 5, t = .5, fn = $fn, off_deg = 0) {
  intersection() {
    my_circle(r=r, $fn=n);
    rotate([0, 0, 1 / (2 * n) * 360])
      circles(n=n, level=3, r=r, gap=gap, t=t, fn=fn, off_deg=off_deg);
  }
}
module hexafoil(n = 6, rows = 4, column = 4, gap = 5, off_deg = 0, r = 10, t = .5, fn = $fn) {
  col = max(1, column / 2);
  for (co = [0:col - 1]) {
    for (ro = [0:(rows - 1) * 2]) {
      y_raw = co * r * 3;
      y = ro % 2 == 0 ? y_raw : y_raw + r * 1.5;
      x = ro * r * .86; //2* cos(1/n*360);
      translate([x, y, 0])
        hexafoil_single(n=n, r=r, t=t, gap=gap, fn=fn, off_deg=off_deg);
    }
  }
}
module circles(n = 6, level = 2, r = 10, t = 1, only_last = false, gap = 0, off_deg = 0, fn = $fn) {
  start_level = only_last ? level - 1 : 0;
  for (l = [start_level:level - 1]) {
    // rotate([0,0,level%2==0?0:360/(n*2)])
    rot = l % 2 == 0 ? off_deg : 360 / (n * 2) + off_deg;
    rotate([0, 0, rot])for (j = [0:(l == 0 ? 1 : n - 1)]) {
      fac = l ^ -.2;
      deg = j / n * 360;
      translate([sin(deg) * r * l * fac, cos(deg) * r * l * fac, 0])
        // rotate([0, 0, 1 / (2 * n) * 360])
        circle_contur(r=r - gap, t=t, outer_center_inner=1, $fn=fn);
    }
  }
}

// 
module circle_contur(r = 10, t = 1, outer_center_inner = 1) {
  assert(outer_center_inner >= 0 && outer_center_inner <= 2, "outer_center_inner must be 0,1,2");
  difference() {
    if (outer_center_inner == 0)
      my_circle(r=r + t);
    else if (outer_center_inner == 1)
      my_circle(r=r + t / 2);
    else if (outer_center_inner == 2)
      my_circle(r=r);

    if (outer_center_inner == 0)
      my_circle(r=r);
    else if (outer_center_inner == 1)
      my_circle(r=r - t / 2);
    else if (outer_center_inner == 2)
      my_circle(r=r - t);
  }
}

module my_circle(r = 10) {
  polygon(
    points=[
      for (i = [0:$fn - 1]) [sin(i / $fn * 360) * r, cos(i / $fn * 360) * r],
    ]
  );
}

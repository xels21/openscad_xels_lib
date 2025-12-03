// use <../dotSCAD/src/polyhedron_hull.scad>;

// star_2d(n=5, r=10, r2=5);
// star_2d();
// star_segment_2d();
// star_single_segment_3d_z();
// star_single_segment_3d();
// star_segment_3d();
// star_3d(single_segment_cut_distance=-.5);
// star_3d(segment_cut_distance=-.5);
// 
// difference() {
// star_3d(hollow_fac=.9);
// cube([100, 100, 100]);
// }

// christmas_star(r2 = 40, tree_fn=64, single_segment_cut_distance=-2, width_diff_fac=.7);
// christmas_star();

// difference() {
  // christmas_star();
  // translate([-500, 0, -500])
    // cube([1000, 1000, 1000]);
// }
// star_simple_3d();

module christmas_star(r = 100, r2 = 50, width = 30, tree_d = 20, n = 5, tree_fn = 6, single_segment_cut_distance = -3, width_diff_fac = .7) {
  tree_fac = .82;
  difference() {
    // POSITIVE
    union() {
      // inner solid
      star_3d(n=n, r=r * 1.0, r2=r2 * 1.0, width=width * width_diff_fac);
      // outer "contur"
      star_3d(n=n, r=r, r2=r2, width=width, single_segment_cut_distance=single_segment_cut_distance);

      rotate([90, 30, 0])
        cylinder(h=r * tree_fac, d=tree_d + 6, $fn=tree_fn);
    }
    // NEGATIVE
    union() {
      #scale(0.9)
        star_simple_3d(n=n, r=r, r2=r2, width=width * width_diff_fac);

      rotate([90, 30, 0])
        cylinder(h=r * tree_fac, d=tree_d + 0, $fn=tree_fn);
    }
  }
}

// needed for diff (no segment "walls")
module star_simple_3d(n = 5, r = 10, r2 = 5, width = 3) {
  edges = n * 2;
  top_e = edges;
  bottom_e = edges + 1;
  polyhedron(
    points=concat(
      star_2d_points_for_3d(n=n, r=r, r2=r2),
      [
        [0, 0, width],
        [0, 0, -width],
      ],
    ), faces=[
      for (i = [0:edges - 1]) [top_e, i, (i + 1) % (edges)],
      for (i = [0:edges - 1]) [bottom_e, i, (i + 1) % (edges)],
    ]
  );
}

module star_3d(n = 5, r = 10, r2 = 5, width = 3, single_segment_cut_distance = 0, segment_cut_distance = 0, hollow_fac = 0) {
  difference() {
    star_3d_raw(n=n, r=r, r2=r2, width=width, single_segment_cut_distance=single_segment_cut_distance, segment_cut_distance=segment_cut_distance);
    if (hollow_fac != 0) {
      assert(hollow_fac > 0 && hollow_fac < 1, "hollow_fac must be between 0 and 1");
      scale(hollow_fac)
        star_3d_raw(n=n, r=r, r2=r2, width=width);
    }
  }
}

module star_3d_raw(n = 5, r = 10, r2 = 5, width = 3, single_segment_cut_distance = 0, segment_cut_distance = 0) {
  for (i = [0:n - 1]) {
    rotate((360 / n) * i)
      star_segment_3d(n=n, r=r, r2=r2, width=width, single_segment_cut_distance=single_segment_cut_distance, segment_cut_distance=segment_cut_distance);
  }
}

module star_segment_3d(n = 5, r = 10, r2 = 6, width = 3, single_segment_cut_distance = 0, segment_cut_distance = 0) {
  difference() {
    star_segment_3d_raw(n=n, r=r, r2=r2, width=width, single_segment_cut_distance=single_segment_cut_distance, segment_cut_distance=segment_cut_distance);

    if (segment_cut_distance != 0) {
      assert(!(segment_cut_distance != 0 && single_segment_cut_distance != 0), "Only one of segment_cut_distance or single_segment_cut_distance can be non-zero");
      translate([0, 0, -width])
        linear_extrude(height=2 * width)
          offset(segment_cut_distance)
            star_segment_2d(n=n, r=r, r2=r2);
    }
  }
}

module star_segment_3d_raw(n = 5, r = 10, r2 = 6, width = 3, single_segment_cut_distance = 0, segment_cut_distance = 0) {
  star_single_segment_3d(n=n, r=r, r2=r2, width=width, single_segment_cut_distance=single_segment_cut_distance);
  mirror([1, 0, 0])
    star_single_segment_3d(n=n, r=r, r2=r2, width=width, single_segment_cut_distance=single_segment_cut_distance);
}

module star_single_segment_3d(n = 5, r = 10, r2 = 6, width = 3, single_segment_cut_distance = 0) {
  difference() {
    star_single_segment_3d_raw(n=n, r=r, r2=r2, width=width);
    if (single_segment_cut_distance != 0) {
      assert(single_segment_cut_distance <= 0, "single_segment_cut_distance must be less than or equal to 0");
      translate([0, 0, -width])
        linear_extrude(height=2 * width)
          offset(single_segment_cut_distance)
            star_single_segment_2d(n=n, r=r, r2=r2);
    }
  }
}

module star_single_segment_3d_raw(n = 5, r = 10, r2 = 6, width = 3, single_segment_cut_distance = 0) {
  star_single_segment_3d_z(n=n, r=r, r2=r2, width=width);
  mirror([0, 0, 1])
    star_single_segment_3d_z(n=n, r=r, r2=r2, width=width);
}

module star_single_segment_3d_z(n = 5, r = 10, r2 = 6, width = 3) {
  // polyhedron_hull(points=concat(star_single_segment_2d_points(n=n, r=r, r2=r2), [[0, 0, width]]));
  polyhedron(
    points=concat(star_single_segment_2d_points(n=n, r=r, r2=r2), [[0, 0, width]]),
    faces=[
      [0, 1, 2],
      [0, 1, 3],
      [0, 2, 3],
      [1, 2, 3],
    ]
  );
}

module star_2d(n = 5, r = 10, r2 = 6) {
  polygon(
    points=star_2d_points(n=n, r=r, r2=r2)
  );

  // for (i = [0:n - 1]) {
  // rotate((360 / n) * i)
  // star_segment_2d(n=n, r=r, r2=r2);
  // }
}

function star_2d_points(n = 5, r = 10, r2 = 6) =
  // m = n * 2; //for "alternate" r
  [
    for (i = [0:n * 2 - 1]) i % 2 == 1 ? [r * cos((360 / (n * 2)) * i), r * sin((360 / (n * 2)) * i)]
    : [r2 * cos((360 / (n * 2)) * i), r2 * sin((360 / (n * 2)) * i)],
  ];

function star_2d_points_for_3d(n = 5, r = 10, r2 = 6) =
  // m = n * 2; //for "alternate" r
  [
    for (i = [0:n * 2 - 1]) i % 2 == 0 
    ? [r * sin((360 / (n * 2)) * i), r * cos((360 / (n * 2)) * i), 0]
    : [r2 * sin((360 / (n * 2)) * i), r2 * cos((360 / (n * 2)) * i), 0],
  ];

module star_segment_2d(n = 5, r = 10, r2 = 6) {
  star_single_segment_2d(n=n, r=r, r2=r2);
  mirror([1, 0, 0])
    star_single_segment_2d(n=n, r=r, r2=r2);
}

module star_single_segment_2d(n = 5, r = 10, r2 = 6) {
  assert(n > 1, "n must be greater than 1");
  polygon(
    points=star_single_segment_2d_points(n=n, r=r, r2=r2)
  );
}

function star_single_segment_2d_points(n = 5, r = 10, r2 = 6) =
  [
    [0, 0],
    [0, r],
    [
      r2 * sin((360 / (n * 2)) * 1),
      r2 * cos((360 / (n * 2)) * 1),
    ],
  ];

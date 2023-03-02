module twisted_circle(start_r=10, end_r=100, h=100, layers=10, fn=6, deg=45){
  t=h/layers;
  delta_r=end_r-start_r;
  for (i=[1:layers]) {
    rotate([0,0,deg*(i/layers)])
    translate([0,0,(i-1)*t])
    cylinder(r = start_r+delta_r*i/layers,h=t, $fn=fn);
  }
}
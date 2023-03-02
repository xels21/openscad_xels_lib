module twisted_cylinder(r1=10, r2=100, h=100, layers=10, fn=6, deg=45){
  t=h/layers;
  delta_r=r2-r1;
  for (i=[1:layers]) {
    rotate([0,0,deg*(i/layers)])
    translate([0,0,(i-1)*t])
    cylinder(r = r1+delta_r*i/layers,h=t, $fn=fn);
  }
}
module screw(upper_d=8,lower_d=4,upper_h=3,max_h=20, fn=32){

  translate([0,0,-upper_h])
  cylinder(d1=lower_d,d2=upper_d,h=upper_h,$fn=fn);

  translate([0,0,-max_h])
  cylinder(d=lower_d,h=max_h,$fn=fn);

}
res=64;


//Stamp for single led
module led_single_pixel_stamp(){
  cylinder(d2=10.5,d1=12,h=4,$fn=res);
  translate([-2.8,-2.8,0])cube([5.6,5.6,6]);
  translate([-4.5,-1.2,0])cube([9,2.4,5]);
}


//Stamp for big single led
module led_single_big_inner(){
  translate([0,0,30-8/2]) sphere(d=8, $fn=res);
  
  translate([0,0,10]) cube([20,3,20],center=true);
  rotate([0,0,90])translate([0,0,10]) cube([20,3,20],center=true);
  
  rotate_extrude($fn=res) 
  polygon( points=[
  [0,0],
  [0,30],
  [8/2,30-(8/2)],
  [13/2,30-12],
  [12/2,30-13],
  [13/2,30-14],
  [12/2,30-18],
  [12/2,0],
  ]);
}

module led_single_big_sceleton(){
  difference(){
  translate([0,0,11])cylinder(d=15,h=21, $fn=res);
  led_big_inner();
  }
}
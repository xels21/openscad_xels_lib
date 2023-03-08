use <helper.scad>

module twisted_cylinder(r1=10, r2=100, h=100, layers=10, fn=6, deg=45){
  t=h/layers;
  delta_r=r2-r1;
  for (i=[1:layers]) {
    rotate([0,0,deg*(i/layers)])
    translate([0,0,(i-1)*t])
    cylinder(r = r1+delta_r*i/layers,h=t, $fn=fn);
  }
}



module bricked_brick(size=[20,10,30], brick_z_count=3, brick_gap=1, brick_x_count=3){
//ATTENTION: NOT FINISHED
//NOTE: size x and y needs to be in relation
/*
 _______________
|    |    |    |
|  |    |    |  |
|    |    |    |
|  |    |    |  
|    |    |    |
*/
  x=size[0];y=size[1];z=size[2];

  brick_x_size_raw = x/brick_x_count;
  brick_y_size_raw = brick_x_size_raw/2;
  brick_z_size_raw = z/brick_z_count;

  brick_z_size = (z-((brick_z_count-1)*brick_gap))/brick_z_count;


  assert(is_int(y/brick_y_size_raw));
  assert((brick_z_size*brick_z_count + brick_gap*(brick_z_count-1))==z);

  for (i = [0:brick_z_count]) {
    
  }

  cube([x,y,z]);
}
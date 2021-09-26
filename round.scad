module rounded_cube_x(size, r=2, center=false, fn=20){
  x=size[0];y=size[1];z=size[2];
  if(center){
    translate([-x/2,-y/2,-z/2])
    rounded_cube_x_raw([x,y,z],r,fn);
  }else{
    rounded_cube_x_raw([x,y,z],r,fn);
  }
}

module rounded_cube_x_raw(size, r, fn){
  x=size[0];y=size[1];z=size[2];
  translate([x,0,z])
  rotate([0,90,90])
  rounded_cube_z_raw([z,x,y],r,fn);
}


module rounded_cube_y(size, r=2, center=false, fn=20){
  x=size[0];y=size[1];z=size[2];
  if(center){
    translate([0,0,-z/2])
    rounded_cube_y_raw([x,y,z],r,fn);
  }else{
    translate([x/2,y/2,0])
    rounded_cube_y_raw([x,y,z],r,fn);
  }
}


module rounded_cube_y_raw(size, r, fn){
  x=size[0];y=size[1];z=size[2];
  translate([0,0,z/2])
  rotate([0,90,0])
  rounded_cube_z([z, y, x], r, fn);
}


module rounded_cube_z(size, r=2, center=false, fn=20){
  x=size[0];y=size[1];z=size[2];
  if(center){
    translate([-x/2,-y/2,-z/2])
    rounded_cube_z_raw([x,y,z],r,fn);
  }else{
    rounded_cube_z_raw([x,y,z],r,fn);
  }
}

module rounded_cube_z_raw(size, r=2, fn=20){
  x=size[0];y=size[1];z=size[2];
  linear_extrude(z)
  rounded_sqare(x=x, y=y, r=r, fn=fn);
}

module rounded_sqare(x=10, y=10, r=1, fn=10){
  scale(1/fn)
  offset(r*fn)
  offset(-r*fn)
  square(size=[x*fn, y*fn], center=false);
}

module rounded_cube(size, r, center=false, fn=20){
  rounded_cube_z(size, r, center=center, fn=fn);
}

module rounded_cylinder(r, h, n, fn=64) {
  rotate_extrude(convexity=1, $fn=fn) {
    offset(r=n) offset(delta=-n) square([r,h]);
    square([n,h]);
  }
}
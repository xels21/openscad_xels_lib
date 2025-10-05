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
    translate([-x/2,-y/2,0])
    rounded_cube_y_raw([x,y,z],r,fn);
  }else{
    translate([0,0,z/2])
    rounded_cube_y_raw([x,y,z],r,fn);
  }
}


module rounded_cube_y_raw(size, r, fn){
  x=size[0];y=size[1];z=size[2];
  translate([0,0,z/2])
  rotate([0,90,0])
  rounded_cube_z_raw([z, y, x], r, fn);
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
module rounded_cube_xy(size, r=2, center=false, fn=20){
  x=size[0];y=size[1];z=size[2];
  intersection(){
    rounded_cube_x([x,y,z],r=r,center=center,fn=fn);
    rounded_cube_y([x,y,z],r=r,center=center,fn=fn);
  }
}
module rounded_cube_yz(size, r=2, center=false, fn=20){
  x=size[0];y=size[1];z=size[2];
  intersection(){
    rounded_cube_y([x,y,z],r=r,center=center,fn=fn);
    rounded_cube_z([x,y,z],r=r,center=center,fn=fn);
  }
}
module rounded_cube_zx(size, r=2, center=false, fn=20){
  x=size[0];y=size[1];z=size[2];
  intersection(){
    rounded_cube_x([x,y,z],r=r,center=center,fn=fn);
    rounded_cube_z([x,y,z],r=r,center=center,fn=fn);
  }
}
module rounded_cube_xyz(size, r=2, center=false, fn=20){
  x=size[0];y=size[1];z=size[2];
  intersection(){
    rounded_cube_x([x,y,z],r=r,center=center,fn=fn);
    rounded_cube_y([x,y,z],r=r,center=center,fn=fn);
    rounded_cube_z([x,y,z],r=r,center=center,fn=fn);
  }
}

module rounded_cube_z_raw(size, r=2, fn=20){
  x=size[0];y=size[1];z=size[2];
  linear_extrude(z)
  rounded_sqare(x=x, y=y, r=r, fn=fn);
}
// typo
module rounded_sqare(size, x=10, y=10, r=1, fn=10, center=false){
  rounded_square(size=size, x=x, y=y, r=r, fn=fn, center=center);
}

module rounded_square(size, x=10, y=10, r=1, fn=10, center=false){
  x_int=(len(size) == 2) ? size[0] : x;
  y_int=(len(size) == 2) ? size[1] : y;

  scale([1/fn,1/fn,1])
  offset(r*fn)
  offset(-r*fn)
  scale([fn,fn,1])
  square(size=[x_int, y_int], center=center);
}

module rounded_cube(size, r, center=false, fn=10){
// module rounded_cube(size, r, center=false, fn=20){
  // rounded_cube_z(size, r, center=center, fn=fn);
  x=size[0];y=size[1];z=size[2];
  if(center){
    translate([-x/2,-y/2,-z/2])
    rounded_cube_internal([x,y,z],r,fn);
  }else{
    rounded_cube_internal([x,y,z],r,fn);
  }
}
module rounded_cube_internal(size, r, fn){
  //copied from: https://www.reddit.com/r/openscad/comments/37fx6n/comment/crmeyas/?utm_source=share&utm_medium=web2x&context=3
  x=size[0];y=size[1];z=size[2];
  hull() 
  for(p=[[r,r,r],
         [r,r,z-r],
         [r,y-r,r],
         [r,y-r,z-r],
         [x-r,r,r],
         [x-r,y-r,r],
         [x-r,r,z-r],
         [x-r,y-r,z-r]
        ])
  translate(p)
  sphere(r, $fn=fn);
}

module rounded_cylinder(r, h, n, fn=64) {
  rotate_extrude(convexity=1, $fn=fn) {
    offset(r=n) offset(delta=-n) square([r,h]);
    square([n,h]);
  }
}

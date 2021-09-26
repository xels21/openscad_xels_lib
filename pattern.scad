// pattern_hexagon();

module pattern_hexagon(x_size = 10,y_size = 10,hex_size=1,gap=.2, height=1){
  ix_count=x_size/(hex_size+gap*2);
  iy_count=y_size/(hex_size/2+gap);
  

  intersection(){
    cube([x_size,y_size,height]);
    union(){
      for (iy =[0:iy_count]){
        for (ix =[0:ix_count]){
          translate([ix*(hex_size*1.5)+ix*gap*2,iy*hex_size*.86+iy*gap,0])
          cylinder(d=hex_size, h=height, $fn=6);

          translate([ix*(hex_size*1.5)+hex_size*0.75+ix*gap*2+gap,hex_size*0.54+iy*hex_size*.86+iy*gap,0])
          cylinder(d=hex_size, h=height, $fn=6);
        }
      }
    }
  }
}



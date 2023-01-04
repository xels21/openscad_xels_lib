// pattern_hexagon();

module pattern_hexagon_2d(x_size = 10,y_size = 10,hex_size=1,gap=.2){
  ix_count=x_size/(hex_size+gap*2);
  iy_count=y_size/(hex_size/2+gap);
  

  intersection(){
    square([x_size,y_size]);
    union(){
      for (iy =[0:iy_count]){
        for (ix =[0:ix_count]){
          translate([ix*(hex_size*1.5)+ix*gap*2,iy*hex_size*.86+iy*gap,0])
          circle(d=hex_size, $fn=6);

          translate([ix*(hex_size*1.5)+hex_size*0.75+ix*gap*2+gap,hex_size*0.54+iy*hex_size*.86+iy*gap,0])
          circle(d=hex_size, $fn=6);
        }
      }
    }
  }
}


module pattern_hexagon_negative_2d(x_size = 10,y_size = 10,hex_size=1,gap=.2){
  difference(){
    square([x_size,y_size]);
    pattern_hexagon_2d(x_size=x_size, y_size=y_size, hex_size=hex_size, gap=gap);
  }
}


module pattern_hexagon_negative(x_size = 10,y_size = 10,hex_size=1,gap=.2, height=1){
  linear_extrude(100)
  pattern_hexagon_negativ_2d(x_size=x_size, y_size=y_size, hex_size=hex_size, gap=gap);
}

module pattern_hexagon(x_size = 10,y_size = 10,hex_size=1,gap=.2, height=1){
  linear_extrude(100)
  pattern_hexagon_2d(x_size=x_size, y_size=y_size, hex_size=hex_size, gap=gap);
}
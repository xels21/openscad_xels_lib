module ellipse_sphere(x=20, y=10, sphere_d=1, acc=15, fn=30){
  for (deg =[0:(360/acc)-1]){
    hull(){
      translate([sin(deg*acc)*x/2,cos(deg*acc)*y/2,0]){
        sphere(d=sphere_d,$fn=fn);
      }
      translate([sin((deg+1)*acc)*x/2,cos((deg+1)*acc)*y/2,0]){
        sphere(d=sphere_d,$fn=fn);
      }
    }
  }
}

module twenty_one(){
  points21 = [[0.311,0],
              [0.574,0.263],
              [0.311,0.526],
              [0.473,0.526],
              [0.653,0.345],
              [0.653,0.871],
              [0.524,1],
              [0.524,0.655],
              [0,0.655 ],
              [0.392 ,0.263],
              [0.311,0.182],
              [0.182,0.311],
              [0,0.311],
              [0.311,0]];
  translate([0,1,0])
  rotate([180,0,0])
  polygon(points21);
}

function is_int(number) = floor(number) == number;
function is_even(number) = number%2 == 0;
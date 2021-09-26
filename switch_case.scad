switch_width=13;
switch_length = 19;
switch_stablizier_length =1.2;
switch_stablizier_width =6;

switch_h=20;


// switch body
module switch_body(h){
    translate([0,0,switch_stablizier_length]) cube([switch_width,h,switch_length]);
}
    
// switch stabilizer
module switch_stabilizer(h){
    translate([((switch_width-switch_stablizier_width)/2),0,0]) cube([switch_stablizier_width,h,switch_length+switch_stablizier_length*2]);
}


// switch complete
module switch_complete(h){
    union(){
        switch_body(h);
        switch_stabilizer(h);
    }
}
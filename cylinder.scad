// cylinder_xels(d1=10,d2=5,d2_fac=.7,fn1=4, fn2=64);

module cylinder_xels(h=10, d=10, d1=-1, d2=-2, fn1=-1, fn2=-1, d1_fac=1, d2_fac=1){
  _d1 = d1<0 ? d : d1;
  _d2 = d2<0 ? d : d2;
  // rotate([0,0,(1/fn1)*180])
  intersection(){
    cylinder(h=h, d1=_d1, d2=_d2, $fn=fn1);
    cylinder(h=h, d1=_d1*d1_fac, d2=_d2*d2_fac, $fn=fn2);
  }
}
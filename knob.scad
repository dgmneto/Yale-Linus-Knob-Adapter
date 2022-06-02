$fn = 180;

render() knob();

// As measured in the comments

module knob(
        d=14.40, // 14.7 mm
        baseH = 12, // 14 mm (upper bound)
        inD=9.8, // 9.5 mm
        inH=7, // 6.38 mm (lower bound)
        handleW=6.75, // 6.9 mm
        handleH=10, // 30 mm (upper bound)
        pinD=3.5, // 3.8 mm
        pinH=3.2 // 6 mm - 2.5 mm (knob wall)
    ) {
    assert(
        baseH + handleH > 14, 
        "The know is too short to be turned"
    );
    translate([-d, 0, 0]) 
        oneHalf(d, baseH, inD, inH, handleW, handleH);
    translate([d, 0, 0]) union() {
        oneHalf(d, baseH, inD, inH, handleW, handleH);
        translate([0, inD / 2, pinD / 2])
            rotate([90, 0, 0])
                cylinder(h = pinH, d = pinD);
    }
}

module oneHalf(d, baseH, inD, inH, handleW, handleH) {
    intersection() {
        translate([-d / 2, 0, 0]) cube([d, d / 2, baseH + handleH]);
        union() {
            translate([0, 0, baseH]) {
                intersection() {
                    cylinder(handleH, d = d);
                    translate([-d / 2, -handleW / 2, 0]) 
                        cube([d, handleW, handleH]);
                }
            }
            difference() {
                cylinder(h = baseH, d = d);
                cylinder(h = inH, d = inD); 
            }
        }
    }
}
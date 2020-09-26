//------------------------------------------------
// 1 - Ikea Kitchen Knob
//
// author: Alessandro Paganelli 
// e-mail: alessandro.paganelli@gmail.com
// github: https://github.com/allep
// license: GPL-3.0-or-later
// 
// Description
// This is a replacement knob for an Ikea kitchen.
//
// All sizes are expressed in mm.
//------------------------------------------------

// Set face number to a sufficiently high number.
$fn = 40;

TOLERANCES = 0.1;
RELEASE_MODE = true;

//------------------------------------------------
// data
OUTER_WALL = 2.2;
KNOB_INNER_RADIUS = 15.25;
KNOB_HEIGHT = 25.5;
KNOB_INNER_HEIGHT = 22.5;

JOINT_INNER_RADIUS = 3.05;
JOINT_HEIGHT = 14;
JOINT_PEG_HEIGHT = 7.3;

JOINT_DISTANCE = 2.1;
VINCULUM_THICKNESS = 2;

// Text
TEXT = "3 2 1 0";
TEXT_DEPTH = OUTER_WALL / 2;
TEXT_HEIGHT = 7.5;
TEXT_POSITION_Z_OFFSET = KNOB_HEIGHT / 4;

//------------------------------------------------
// Circular text computations
// Reference:
// http://forum.openscad.org/It-seems-no-way-to-put-text-on-the-curved-surface-td20182.html

// slices: text should be mapped on 45 degrees only
slices = 20;
circumference = 2* 3.14159 * KNOB_INNER_RADIUS;
slice_width = circumference / slices;

//------------------------------------------------
// Modules

// labels
module labels(letter_size) {
    union () {
        for (i = [0 : 1 : slices]) {
           
            rotate ([0, 0, i * (360 / slices)]) translate ([0, - KNOB_INNER_RADIUS - OUTER_WALL + TEXT_DEPTH -0.5, 0])
            intersection () {
               
                translate ([-slice_width / 2 - (i * slice_width) , 0, 0]) rotate ([90, 0, 0])
                linear_extrude(TEXT_DEPTH, center = true, convexity = 10)
                text(TEXT, size = letter_size);
               
                cube ([slice_width + 1.2, TEXT_DEPTH + 1, KNOB_HEIGHT], true);
            }
        }
    }
}

// hole
module hole() {
    rotate([0, 0, 180])
    difference() {
        cylinder(h = JOINT_HEIGHT, r = JOINT_INNER_RADIUS);
        translate([-JOINT_INNER_RADIUS, JOINT_DISTANCE, 0])
        cube([2*JOINT_INNER_RADIUS, VINCULUM_THICKNESS, JOINT_HEIGHT]);
    }
}

// peg
module peg(height) {
    cylinder(h = height, r = JOINT_INNER_RADIUS + OUTER_WALL);
}


//------------------------------------------------
// Actual script

if (RELEASE_MODE == true) {
    difference() {
        union() {
            difference() {
                cylinder(h = KNOB_HEIGHT, r = KNOB_INNER_RADIUS + OUTER_WALL);
                translate([0, 0, KNOB_HEIGHT - KNOB_INNER_HEIGHT + JOINT_HEIGHT - JOINT_PEG_HEIGHT])
                cylinder(h = KNOB_INNER_HEIGHT - JOINT_HEIGHT + JOINT_PEG_HEIGHT, r = KNOB_INNER_RADIUS);
            }
            
            // the peg
            translate([0, 0, KNOB_HEIGHT - KNOB_INNER_HEIGHT])
            peg(JOINT_HEIGHT);
            
        }
        translate([0, 0, KNOB_HEIGHT - KNOB_INNER_HEIGHT])
        hole();
        
        translate([0, 0, TEXT_POSITION_Z_OFFSET])
        labels(TEXT_HEIGHT);
    }
}
else {
    // small scale 3d printing tests
    difference() {
        peg(KNOB_HEIGHT - KNOB_INNER_HEIGHT + JOINT_HEIGHT);
        translate([0, 0, KNOB_HEIGHT - KNOB_INNER_HEIGHT])
        hole();
    }

}
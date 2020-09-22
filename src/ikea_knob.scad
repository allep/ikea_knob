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
$fn = 30;

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

JOINT_DISTANCE = 2.1;
VINCULUM_THICKNESS = 2;

// test mode sizes
KNOB_HEIGHT_SMALL_TEST = JOINT_HEIGHT;
KNOB_INNER_HEIGHT_SMALL_TEST = JOINT_HEIGHT;
KNOB_INNER_RADIUS_SMALL_TEST = JOINT_INNER_RADIUS + 2*OUTER_WALL;

//------------------------------------------------
// actual script

if (RELEASE_MODE == true) {
    union() {
        difference() {
            cylinder(h = KNOB_HEIGHT, r = KNOB_INNER_RADIUS + OUTER_WALL);
            translate([0, 0, JOINT_HEIGHT + KNOB_HEIGHT - KNOB_INNER_HEIGHT])
            cylinder(h = KNOB_INNER_HEIGHT - JOINT_HEIGHT, r = KNOB_INNER_RADIUS);
            translate([0, 0, KNOB_HEIGHT - KNOB_INNER_HEIGHT])
            cylinder(h = JOINT_HEIGHT, r = JOINT_INNER_RADIUS);
        }

        // now sum the vinculum
        translate([-JOINT_INNER_RADIUS, JOINT_DISTANCE, KNOB_HEIGHT - KNOB_INNER_HEIGHT])
        cube([2*JOINT_INNER_RADIUS, VINCULUM_THICKNESS, JOINT_HEIGHT]);
    }
}
else {
    // small scale 3d printing tests
    union() {
        difference() {
            cylinder(h = KNOB_HEIGHT - KNOB_INNER_HEIGHT + JOINT_HEIGHT, r = JOINT_INNER_RADIUS + OUTER_WALL);
            translate([0, 0, KNOB_HEIGHT - KNOB_INNER_HEIGHT])
            cylinder(h = JOINT_HEIGHT, r = JOINT_INNER_RADIUS);
        }

        // now sum the vinculum
        translate([-JOINT_INNER_RADIUS, JOINT_DISTANCE, KNOB_HEIGHT - KNOB_INNER_HEIGHT])
        cube([2*JOINT_INNER_RADIUS, VINCULUM_THICKNESS, JOINT_HEIGHT]);
    }
}
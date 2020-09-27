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

// Labels
LABEL_0_TEXT = "0";
LABEL_1_TEXT = "1";
LABEL_2_TEXT = "2";
LABEL_3_TEXT = "3";

TEXT_DEPTH = OUTER_WALL / 2;
TEXT_HEIGHT = 7;
TEXT_POSITION_Z_OFFSET = KNOB_HEIGHT / 4;

//------------------------------------------------
// Modules

// labels
module single_label(letter, size, rotation) {
    rotate([0, 0, rotation])
    translate([0, -KNOB_INNER_RADIUS - OUTER_WALL, 0])
    rotate([90, 0, 0])
    linear_extrude(TEXT_DEPTH, center = true)
    text(letter, size = size, halign = "center", valign = "center");    
}

module labels() {
    union () {
        single_label(LABEL_0_TEXT, TEXT_HEIGHT, 90.0);
        single_label(LABEL_1_TEXT, TEXT_HEIGHT, 60.0);
        single_label(LABEL_2_TEXT, TEXT_HEIGHT, 30.0);
        single_label(LABEL_3_TEXT, TEXT_HEIGHT, 0.0);
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
        labels();
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
use <lib/gear_lib.scad>
use <lib/bevel_gear_lib.scad>

/*************************************************
Gear ratios - 1:2 and 1:5. The smaller of the 1:5
ratio gears doesn't need to be the same number of
teeth as the smaller of the 1:2
*************************************************/
teeth_1_to_2_small = 9;
teeth_1_to_2_large = 18;

bevel_teeth_1_to_2_small = 8;
bevel_teeth_1_to_2_large = 16;

teeth_1_to_5_small = 7;
teeth_1_to_5_large = 35;

mm_per_tooth = 5;
gear_thickness = 4;

/*************************************************
Shaft variables. Designed around a 3/16" steel rod
*************************************************/
gear_shaft_diameter = (3/16) * 25.4;
free_shaft_diameter = (3/16) * 25.4 * 1.1;

/*************************************************
Frame variables
*************************************************/
frame_width = 85;
frame_height = 55;
wall_thickness = 3;
corner_radius = 3;
gear_wall_clearance = 0.75;
camera_mount_retainer_thickness = 2;

/*************************************************
Stepper motor dimensions. Designed around a NEMA14
stepper motor.
*************************************************/
stepper_height = 34;
stepper_shaft_height = 24;
stepper_shaft_diameter = 5;
stepper_width = 42.3;
stepper_y_offset = 25 - frame_height;

/*************************************************
Modeling control. Setting model_full_assembly to
true will ignore the rest of the individual model
variables. The individually modeled pieces are all
centered at [0,0,0] so it's probably best to
render them one at a time, export the model, then
go on to the next one.
*************************************************/
model_full_assembly         = false;
model_compound_1_to_2_gear  = false;
model_compound_1_to_5_gear  = false;
model_compound_bevel_gear   = false;
model_compound_1_2_gear_ext = false;
model_compound_1_5_gear_ext = false;
model_camera_mount_gear     = false;
model_driver_gear           = true;
model_frame                 = false;

/*************************************************
END CONTROL VARIABLES
*************************************************/

cylinder_resolution = 100;

if (model_full_assembly)
{
    full_assembly();
}
else
{
    if (model_compound_1_to_2_gear)
    {
        gear_1_to_2_large();
        translate([0, 0, gear_thickness])
        {
            gear_1_to_2_small();
        }
    }
    if (model_compound_1_to_5_gear)
    {
        gear_1_to_5_large();
        translate([0, 0, gear_thickness])
        {
            gear_1_to_5_small();
        }
    }
    if (model_compound_bevel_gear)
    {
        compound_bevel_gear();
    }
    if (model_compound_1_2_gear_ext)
    {
        rotate([180, 0, 0])
        {
            compound_1_2_gear_ext();
        }
    }
    if (model_compound_1_5_gear_ext)
    {
        rotate([180, 0, 0])
        {
            compound_1_5_gear_ext();
        }
    }
    if (model_camera_mount_gear)
    {
        camera_mount_gear();
    }
    if (model_frame)
    {
        rotate([90, 0, 0])
        {
            frame();
        }
    }
    if (model_driver_gear)
    {
        driver_gear();
    }
}

module driver_gear()
{
    bevel_gear(
        number_of_teeth = bevel_teeth_1_to_2_small,
        pressure_angle=30,
        cone_distance=25,
        outside_circular_pitch=360,
        bore_diameter = 5.5,
        face_width = 5,
        finish = 0);
}

module compound_bevel_gear()
{
    bevel_gear(
        number_of_teeth = bevel_teeth_1_to_2_large,
        pressure_angle = 30,
        cone_distance = 25,
        outside_circular_pitch = 360,
        bore_diameter = free_shaft_diameter,
        face_width = 5,
        finish = 0);

    translate([0, 0, -2])
    {
        gear_1_to_2_small();
    }
}

module compound_1_2_gear_ext()
{
    gear_1_to_2_large();
    translate([0, 0, -gear_thickness])
    {
        gear_1_to_5_small(gear_thickness);
    }
}

module compound_1_5_gear_ext()
{
    difference()
    {
        union()
        {
            gear_1_to_5_large();
            translate([0, 0, -gear_thickness])
            {
                gear_1_to_5_small(gear_thickness);
            }
        }
        // Smooth out the interior
        translate([0, 0, -20])
        {
            cylinder(r=free_shaft_diameter/2, h=30, $fn=cylinder_resolution);
        }
    }
}

module gear_1_to_2_small()
{
    gear(mm_per_tooth, teeth_1_to_2_small, gear_thickness, free_shaft_diameter);
}

function gear_shaft_radius() = pitch_radius(mm_per_tooth, teeth_1_to_5_small) + mm_per_tooth / 2;

module gear_1_to_5_small(additional_shaft_length = 0)
{
    translate([0, 0, -(additional_shaft_length / 2)])
    {
        difference()
        {
            cylinder(r=gear_shaft_radius(), h=additional_shaft_length, $fn=cylinder_resolution);
            translate([0, 0, -0.5])
            {
                cylinder(r=free_shaft_diameter/2,
                         h=additional_shaft_length + 1, $fn=cylinder_resolution);
            }
        }
    }
    translate([0, 0, -additional_shaft_length])
    {
        gear(mm_per_tooth, teeth_1_to_5_small, gear_thickness, free_shaft_diameter);
    }
}

module gear_1_to_2_large()
{
    // This isn't really necessary but it makes the render look nice
    rotate([0, 0, 5])
    {
        gear(mm_per_tooth, teeth_1_to_2_large, gear_thickness, free_shaft_diameter);
    }
}

module gear_1_to_5_large()
{
    rotate([0, 0, 5])
    {
        gear(mm_per_tooth, teeth_1_to_5_large, gear_thickness, free_shaft_diameter);
    }
}

module compound_gear_1_2()
{
    gear_1_to_2_large();
    translate([0, 0, -gear_thickness])
    {
        gear_1_to_2_small();
    }
}

module compound_gear_1_5()
{
    gear_1_to_5_large();
    translate([0, 0, -gear_thickness])
    {
        gear_1_to_5_small();
    }
}

module camera_mount_gear()
{
    small_screw_hole_diameter = 4.4;
    small_screw_hole_spacing = 14.2;

    $fn = cylinder_resolution;

    difference()
    {
        union()
        {
            gear_1_to_5_large();
            translate([0, 0, -gear_thickness/2 - camera_mount_retainer_thickness])
            {
                cylinder(r=compound_gear_1_5_dist() - 1, h=camera_mount_retainer_thickness);
            }
        }

        through_hole_height = camera_mount_retainer_thickness + gear_thickness + 1;
        translate([0, 0, -gear_thickness - 0.5])
        {
            translate([small_screw_hole_spacing / -2, 0, 0])
            {
                cylinder(r=small_screw_hole_diameter / 2, h=through_hole_height);
            }
            translate([0, 0, 0])
            {
                cylinder(r=free_shaft_diameter / 2, h=through_hole_height);
            }
            translate([small_screw_hole_spacing / 2, 0, 0])
            {
                cylinder(r=small_screw_hole_diameter / 2, h=through_hole_height);
            }
        }

        // M4 cap screw countersinks
        // This won't countersink the entire screw head, but there needs to be
        // enough plastic to not crush between the screw and the ball joint
        translate([0, 0, gear_thickness / 2 - 3])
        {
            translate([small_screw_hole_spacing / -2, 0, 0])
            {
                cylinder(r=7/2, h=through_hole_height);
            }
            translate([small_screw_hole_spacing / 2, 0, 0])
            {
                cylinder(r=7/2, h=through_hole_height);
            }
        }
    }
}

function compound_gear_1_2_dist() =
    pitch_radius(mm_per_tooth, teeth_1_to_2_large) +
    pitch_radius(mm_per_tooth, teeth_1_to_2_small);

function compound_gear_1_5_dist() =
    pitch_radius(mm_per_tooth, teeth_1_to_5_large) +
    pitch_radius(mm_per_tooth, teeth_1_to_5_small);

module full_assembly()
{
    // Driver gear
    rotate([-90, 0, 0])
    translate([0, -9, -16])
    {
        color("lightgray") driver_gear();

    }

    // Stepper motor - for rendering purposes only
    translate([-stepper_width / 2, stepper_y_offset - stepper_height, -9 - stepper_shaft_diameter / 2])
    {
        color("white") import("lib/9238.stl");
    }

    // First compound gear
    color("red") compound_bevel_gear();

    translate([ -1 * compound_gear_1_2_dist(), 0, -2])
    {
        // Second compound gear
        color("green") compound_gear_1_2();
    }

    translate([0, 0, -6])
    {
        // Third compound gear
        color("blue") compound_gear_1_2();

        // Last gear in this train is a compound of 1 : 2 and 1 : 5,
        // specifically thicker to make room for supporting the shaft
        // through compound gears 1 and 3
        translate([-1 * compound_gear_1_2_dist(), 0, -(gear_thickness)])
        {
            color("orange") compound_1_2_gear_ext();
        }
    }

    // Next train: 1 : 5 reducers

    // Line it up with the end of the 1 : 2 reducer train
    x_offset = -1 * compound_gear_1_2_dist();
    z_offset = -1 * (gear_thickness * 4 + gear_wall_clearance + wall_thickness);
    translate([x_offset, 0, z_offset])
    {
        // First compound gear
        translate([compound_gear_1_5_dist(), 0, 0])
        {
            color("purple") compound_gear_1_5();
        }

        // Second compound gear
        translate([0, 0, -gear_thickness])
        {
            color("salmon") compound_gear_1_5();
        }

        // Third compound gear
        translate([compound_gear_1_5_dist(), 0, -gear_thickness * 2])
        {
            color("aqua") compound_1_5_gear_ext();
        }

        translate([0, 0, -(gear_thickness * 4 + gear_wall_clearance)])
        {
            color("yellow") camera_mount_gear();
        }
    }

    // Drive shafts
    color("gray")
    {
        translate([-compound_gear_1_2_dist(), 0, -45])
        {
            cylinder(r=(gear_shaft_diameter / 2), h=55, $fn=cylinder_resolution);
        }

        translate([0, 0, -15])
        {
            cylinder(r=(gear_shaft_diameter / 2), h=23, $fn=cylinder_resolution);
        }

        translate([-compound_gear_1_2_dist() + compound_gear_1_5_dist(), 0, -36])
        {
            cylinder(r=(gear_shaft_diameter / 2), h=23, $fn=cylinder_resolution);
        }
    }

    frame();
}

module stepper_motor_mount()
{
    // A little extra on the cube cutouts so the motor
    // can actually fit into the space
    extra = 0.2;

    module stepper_motor_cube()
    {
        w = stepper_width + extra;
        cube([w, w, stepper_height]);
    }

    module stepper_motor_hole_pattern()
    {
        $fn = cylinder_resolution;
        offset = (42.3 - 31) / 2;
        screw_diameter = 3.2;   // M3s
        hole_height = 20;
        translate([extra / 2, extra / 2, -5])
        {
            for(x = [offset, stepper_width - offset])
            for(y = [offset, stepper_width - offset])
            {
                translate([x, y, 0])
                {
                    cylinder(r=screw_diameter / 2, h=hole_height);
                }
            }
            translate([stepper_width / 2, stepper_width / 2, -hole_height + 1])
            {
                cylinder(r=11.5, h=hole_height * 2);
            }
        }
    }

    stepper_motor_cube();
    stepper_motor_hole_pattern();
}

module frame()
{
    frame_x_offset = 30 - frame_width;
    frame_y_offset = 20 - frame_height;

    module rounded_wall(x, y, z)
    {
        hull()
        {
            translate([corner_radius, y - corner_radius, 0])
            {
                cylinder(r=corner_radius, h=z, $fn=cylinder_resolution);
            }
            translate([x - corner_radius, y - corner_radius, 0])
            {
                cylinder(r=corner_radius, h=z, $fn=cylinder_resolution);
            }
            cube([x, y / 2, z]);
        }
    }

    module free_shaft_cutout()
    {
        translate([0, 0, -0.5])
        {
            cylinder(r=free_shaft_diameter / 2, h=wall_thickness + 1, $fn=cylinder_resolution);
        }
    }

    module gear_shaft_cutout()
    {
        translate([0, 0, -0.5])
        {
            // Add 0.15 to the radius for a little bit of slack. It's really
            // hard to ream out the gear shaft cutout in the center wall!
            shaft_radius = gear_shaft_radius() + 0.15;
            cylinder(r=shaft_radius + gear_wall_clearance / 2,
                     h=wall_thickness + 1, $fn=cylinder_resolution);
        }
    }

    // First shaft support wall
    module first_shaft_support_wall()
    {
        first_wall_z_offset = gear_thickness;
        translate([0, 0, first_wall_z_offset + gear_wall_clearance])
        {
            difference()
            {
                translate([frame_x_offset, frame_y_offset, 0])
                {
                    rounded_wall(frame_width, frame_height, wall_thickness);
                }

                // Shaft cutouts
                free_shaft_cutout();
                translate([-compound_gear_1_2_dist(), 0, 0])
                {
                    free_shaft_cutout();
                }
            }
        }
    }

    // Middle shaft support wall
    middle_wall_z_offset = (gear_thickness * 4) + gear_wall_clearance * 2;
    module middle_shaft_support_wall()
    {
        translate([0, 0, -middle_wall_z_offset + (wall_thickness / 2)])
        {
            difference()
            {
                translate([frame_x_offset, frame_y_offset, 0])
                {
                    rounded_wall(frame_width, frame_height, wall_thickness);
                }

                // Shaft cutouts
                free_shaft_cutout();
                translate([-compound_gear_1_2_dist() + compound_gear_1_5_dist(), 0, 0])
                {
                    free_shaft_cutout();
                }
                translate([-compound_gear_1_2_dist(), 0, 0])
                {
                    gear_shaft_cutout();
                }
            }
        }
    }

    last_wall_z_offset = (gear_thickness * 8) + gear_wall_clearance * 3;

    module last_shaft_support_wall()
    {
        translate([0, 0, -last_wall_z_offset + (wall_thickness / 2)])
        {
            difference()
            {
                translate([frame_x_offset, frame_y_offset, 0])
                {
                    rounded_wall(frame_width, frame_height, wall_thickness);
                }
                translate([-compound_gear_1_2_dist() + compound_gear_1_5_dist(), 0, 0])
                {
                    gear_shaft_cutout();
                }
                translate([-compound_gear_1_2_dist(), 0, 0])
                {
                    free_shaft_cutout();
                }
            }
        }
    }

    floor_height = 50;
    floor_z_offset = -floor_height + gear_thickness + gear_wall_clearance + wall_thickness;

    module camera_gear_retainer()
    {
        $fn = cylinder_resolution;

        gear_lip_retainer_thickness = 2;
        lip_retainer_width = frame_width - 30;
        lip_retainer_height = frame_height - wall_thickness / 2;
        // + 0.5 for a decent fit
        lip_retainer_thickness = gear_lip_retainer_thickness * 2 + 1.5;

        difference()
        {
            translate([frame_x_offset, frame_y_offset + (wall_thickness / 2), floor_z_offset])
            {
                rounded_wall(lip_retainer_width, lip_retainer_height,
                             lip_retainer_thickness * 2 - wall_thickness / 2);
            }

            translate([-compound_gear_1_2_dist(), 0, floor_z_offset - 1])
            {
                cylinder(r=compound_gear_1_5_dist() - 2, h=20);
            }

            
            translate([-compound_gear_1_2_dist(), 0, floor_z_offset + gear_lip_retainer_thickness - 0.2])
            {
                cylinder(r=compound_gear_1_5_dist(), h=camera_mount_retainer_thickness + 0.75);
            }
        }

    }

    module floor()
    {
        $fn = cylinder_resolution;
        difference()
        {
            union()
            {
                translate([frame_x_offset, frame_y_offset - wall_thickness / 2, floor_z_offset])
                {
                    cube([frame_width, wall_thickness, floor_height]);
                }

                // Mounting block for the stepper motor
                translate([frame_x_offset, frame_y_offset - wall_thickness / 2,
                           -middle_wall_z_offset + wall_thickness])
                {
                    cube([frame_width, wall_thickness * 3, gear_thickness * 13]);
                }
            }

            // Tripod mount assembly through-holes - M4s
            screw_hole_diameter = 4.3;
            translate([0, frame_y_offset + 15, 0])
            {
                inset = 5;
                left = frame_x_offset + inset;
                right = frame_x_offset + frame_width - inset;
                top = floor_z_offset + gear_thickness * 5;
                bottom = 32;

                for(x = [left, right])
                for(z = [top, bottom])
                {
                    translate([x, 0, z])
                    {
                        rotate([90, 0, 0])
                        {
                            cylinder(r=screw_hole_diameter / 2, h=20);
                        }
                    }
                }
            }
        }
    }

    difference()
    {
        union()
        {
            first_shaft_support_wall();
            middle_shaft_support_wall();
            union()
            {
                last_shaft_support_wall();
                camera_gear_retainer();
            }
            floor();
        }

        translate([-stepper_width / 2, stepper_y_offset, -9 - stepper_shaft_diameter / 2])
        {
            rotate([90, 0, 0])
            {
                stepper_motor_mount();
            }
        }
    }
}

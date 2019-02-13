use <lib/gear_lib.scad>

/*--------------------------------
1 : 5 ratio
--------------------------------*/
//sun_teeth       = 8;
//ring_teeth      = 32;
//planet_teeth    = 12;

/*--------------------------------
1 : 4 ratio
--------------------------------*/
sun_teeth       = 10;
ring_teeth      = 30;
planet_teeth    = 10;

planet_count    = 4;

ring_diameter   = 70;
ring_height     = 10;

stepper_width = 42.3;

sun_axle_diameter           = 5;    // Diameter of driving motor shaft
planet_axle_diameter        = 4;    // M4 screw/bolt
ring_through_hole_diameter  = 3;    // M3 threaded rod

sun_axle_type               = 1;    // 0 = driver motor shaft,
                                    // 1 = previous stage carrier shaft

carrier_height  = 5;
carrier_post_height = 6;
carrier_post_size   = 5;

retainer_height = 1.5;

mm_per_tooth    = 5.5;

gear_scaling    = 0.98;

$fn = 150;

render_ring             = false;
render_ring_tripod_mount_wings = true;

render_sun              = false;
render_planets          = false;

render_carrier          = true;
render_as_camera_carrier= true;

render_retainer         = false;
render_second_retainer  = false;
render_as_motor_retainer= false;
render_as_final_retainer= true;

render_tripod_mount     = false;

exploded_view           = false;

/*----------------------------------
Render control
----------------------------------*/
y_rotation = (exploded_view) ? 90 : 0;
rotate([0, y_rotation, 0])
{
    if (render_ring)
    {
        // Ring
        color("lightgreen")
        {
            z = (exploded_view) ? ring_height * 3.5 : 0;
            translate([0, 0, z])
            {
                ring();
            }
        }
    }

    if (render_retainer)
    {
        color("lightgray")
        {
            z = (exploded_view) ? ring_height * 5.5 : ring_height;
            translate([0, 0, z])
            {
                if (render_as_motor_retainer && exploded_view == false)
                {
                    retainer_ring_motor_mount();
                }
                else
                {
                    retainer_ring();
                }
            }

            if (render_second_retainer)
            {
                z2 = (exploded_view) ? -ring_height : -retainer_height;
                translate([0, 0, z2])
                {
                    if (exploded_view && render_as_motor_retainer)
                    {
                        retainer_ring_motor_mount();
                    }
                    else
                    {
                        retainer_ring();
                    }
                }
            }
        }
    }

    if (render_sun)
    {
        // Sun
        color("lightblue")
        {
            z = (exploded_view) ? ring_height / 2 : ring_height / 2;
            translate([0, 0, z])
            {
                sun(0, sun_axle_diameter);
            }
        }
    }

    // Planets
    if(render_planets)
    {
        color("salmon")
        {
            z = (exploded_view) ? ring_height / 2 : ring_height / 2;
            translate([0, 0, z])
            {
                all_planets();
            }
        }
    }

    // Planetary carrier
    if(render_carrier)
    {
        color("tan")
        {
            z = (exploded_view) ? ring_height * 1.25 : ring_height / 2;
            translate([0, 0, z])
            {
                planetary_carrier();
            }
        }
    }
    
    if (render_tripod_mount)
    {
        color("goldenrod")
        {
            tripod_mount();
        }
    }
}

module tripod_mount()
{
    mount_thickness = 15;
    mount_diameter = ring_diameter + mount_thickness;
    mount_ring_height = ring_height * 2;
    
    rotate([0, 0, 45 - (360 / ring_teeth / 2)])
    {
        difference()
        {
            cylinder(r=mount_diameter / 2, h = mount_ring_height);
            translate([0, 0, -0.5])
            {
                cylinder(r=ring_diameter / 2, h = mount_ring_height + 1);
                cube_dim = mount_diameter + 1;
                cube_height = ring_height * 2 + 1;
                rotate([0, 0, 45 + (360 / ring_teeth / 2)])
                {
                    translate([0, cube_dim / 2, cube_height / 2])
                    {
                        rotate([0, 0, 45])
                        {
                            translate([-8.25, -8.25, 0])
                            cube([cube_dim, cube_dim, cube_height], center=true);
                        }
                    }
                    wing_holes(10, ring_height * 3);
                    translate([0, 0, -2])
                    {
                        wing_nut_cutouts(10, ring_height * 3);
                    }
                }
            }
            
            translate([0, 0, ring_height / 2])
            {
                ring_wings(false);
            }
        }

        rotate([-90, 0, 0])
        rotate([0, 135 - (360 / ring_teeth / 2), 0])
        {
            translate([-mount_diameter / 4, -19 - 6,
                       mount_diameter / 2 - mount_thickness / 2])
            {
                tripod_adapter();
            }
        }
    }
}

module tripod_adapter()
{
    adapter_corner_radius   = 4;
    adapter_height          = 10;
    adapter_width           = 38;
    adapter_length          = 50;

    difference()
    {
        /***** Main body *************************************/
        hull()
        {
            w = adapter_width - adapter_corner_radius * 2;
            l = adapter_length - adapter_corner_radius * 2;
            for(x=[0, l])
            for(y=[0, w])
            {
                translate([x, y, 0])
                {
                    cylinder(r=adapter_corner_radius, h=adapter_height);
                }
            }
        }

        /***** Side cuts *************************************/
        side_cut_length = adapter_length * 1.5;
        translate([side_cut_length / -4, adapter_corner_radius * -2, adapter_height / -4])
            rotate([45, 0, 0])
                cube([side_cut_length, adapter_height, adapter_height]);

        translate([side_cut_length / -4, adapter_width, adapter_height / -4])
            rotate([45, 0, 0])
                cube([side_cut_length, adapter_height, adapter_height]);
    }
}

module ring_through_holes(h)
{
    for(i=[0:3])
    {
        // Put the hole where a tooth is to maximize surrounding material
        rotate([0, 0, i * 90 + (360 / ring_teeth) / 2])
        {
            translate([ring_diameter / 2 - 3.5, 0, -0.5])
            {
                cylinder(r=ring_through_hole_diameter / 2, h=h + 1);
            }
        }
    }
}

module ring()
{
    ring_top_modifier = (ring_teeth == 32) ? 0.71 : 0.68;
    union()
    {
        difference()
        {
            cylinder(r = ring_diameter / 2, h = ring_height);
            gear(mm_per_tooth, ring_teeth, ring_height, 0);
            translate([0, 0, -1])
            {
                cylinder(r = (ring_diameter / 2) * ring_top_modifier, h=ring_height + 2);
            }
            ring_through_holes(ring_height);
        }
        
        if (render_ring_tripod_mount_wings)
        {
            ring_wings(true);
        }
    }
}

module ring_wings(render_wing_holes)
{
    mount_width = 10;
    inset = 2;
    rotate([0, 0, 45 + (360 / ring_teeth / 2)])
    difference()
    {
        union()
        {
            for(x=[-ring_diameter / 2 - mount_width + inset, ring_diameter / 2 - inset])
            {
                for(r=[-9, -6, -3, 3, 6, 9])
                rotate([0, 0, r])
                {
                    translate([x, -mount_width / 2, 0])
                    {
                        cube([mount_width, mount_width, ring_height]);
                    }                            
                }
            }
        }
    
        translate([0, 0, -0.5])
        {
            difference()
            {
                cylinder(r=ring_diameter / 2 + mount_width, h=ring_height + 1);
                translate([0, 0, -0.5])
                {
                    cylinder(r=ring_diameter / 2 + mount_width - inset, h=ring_height + 2);
                }
            }
            
            if (render_wing_holes)
            {
                wing_holes(mount_width, ring_height + 1);
            }
        }
    }
}

module wing_holes(mount_width, height)
{
    for(r=[-45, 135])
    for(r2=[-6, 6])
    rotate([0, 0, r + r2])
    translate([ring_diameter / 4 + mount_width, ring_diameter / 4 + mount_width, 0])
    {
        cylinder(r=3.2/2, h=height);
    }
}

module wing_nut_cutouts(mount_width, height)
{
    for(r=[-45, 135])
    for(r2=[-6, 6])
    rotate([0, 0, r + r2])
    translate([ring_diameter / 4 + mount_width, ring_diameter / 4 + mount_width, 0])
    {
        cylinder(r=(5.5/2), h=5, $fn=6);
    }
}

module retainer_ring()
{
    difference()
    {
        cylinder(r = ring_diameter / 2, h=retainer_height);
        translate([0, 0, -0.5])
        {
            diameter = (render_as_final_retainer) ? 31 / 2 : sun_axle_diameter;
            cylinder(r = diameter, h=retainer_height + 1);
        }
        ring_through_holes(2);
    }
}

module retainer_ring_motor_mount()
{
    cube_dim = 19;
    union()
    {
        difference()
        {
            retainer_ring();
            translate([0, 0, -0.5])
            {
                cylinder(r=11.5, h=retainer_height + 1);
            }
        }

        difference()
        {
            translate([0, 0, -cube_dim / 2])
            {
                cube([stepper_width, stepper_width, cube_dim], center=true);
            }
            translate([-stepper_width / 2, -stepper_width / 2, -20])
            {
                stepper_motor_hole_pattern();
            }
            
            cutout_dim = stepper_width - 3;
            mount_thickness = cube_dim - 3;
            translate([0, 0, -mount_thickness])
            {
                for(x=[-stepper_width / 2, stepper_width / 2])
                for(y=[-stepper_width / 2, stepper_width / 2])
                translate([x, y, 0])
                {
                    cylinder(r=12, h=mount_thickness);
                }
            }
        }
    }
}

module stepper_motor_hole_pattern()
{
    extra = 0.0;
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
        translate([stepper_width / 2, stepper_width / 2, 0])
        {
            cylinder(r=11.5, h=hole_height * 2);
        }
    }
}

module sun()
{
    difference()
    {
        translate([0, 0, -ring_height / 4])
        {
            rotate([0, 0, 360 / sun_teeth / 2])
            {
                scale([gear_scaling, gear_scaling, 1.0])
                {
                    gear(mm_per_tooth, sun_teeth, ring_height / 2, 0);
                }
            }
        }

        translate([0, 0, -ring_height / 2 - 0.5])
        {
            if (sun_axle_type == 0)
            {
                cylinder(r=sun_axle_diameter / 2, ring_height + 1);
            }
            else if (sun_axle_type == 1)
            {
                dim = carrier_post_size * 1.025;
                translate([0, 0, (ring_height + 1) / 2])
                {
                    cube([dim, dim, ring_height + 1], center=true);
                }
            }
        }
    }
}

module planet()
{
    difference()
    {
        translate([0, 0, -ring_height / 4])
        {
            scale([gear_scaling, gear_scaling, 1.0])
            {
                gear(mm_per_tooth, planet_teeth, ring_height / 2, 0);
            }
        }
        translate([0, 0, -ring_height / 2 - 0.5])
        {
            cylinder(r=(planet_axle_diameter / 2) * 1.075, ring_height + 1);
        }
    }
}

module all_planets()
{
    for(i=[0:planet_count - 1])
    {
        rotate(planet_axis_rotation(i))
        {
            translate(planet_axis_translation())
            {
                planet();
            }
        }
    }
}

module rounded_cube(s, h)
{
    hull()
    {
        for(x=[-s / 2, s / 2])
        for(y=[-s / 2, s / 2])
        {
            translate([x, y, 0])
            {
                cylinder(r=2, h=h);
            }
        }
    }
}

module planetary_carrier()
{
    planet_radius = pitch_radius(mm_per_tooth, planet_teeth);
    
    small_screw_hole_diameter = 4.4;
    small_screw_hole_spacing = 14.2;
    
    difference()
    {
        union()
        {
            for(i=[0:planet_count-1])
            {
                hull()
                {
                    cylinder(r=pitch_radius(mm_per_tooth, sun_teeth), h=carrier_height);
                    rotate(planet_axis_rotation(i))
                    {
                        translate(planet_axis_translation())
                        {
                            rounded_cube(planet_radius - 2, carrier_height);
                        }
                    }
                }
            }

            if (render_as_camera_carrier == false)
            {
                translate([0, 0, carrier_height + carrier_post_height / 2])
                {
                    cube([carrier_post_size,
                          carrier_post_size, carrier_post_height], center=true);
                }
            }
            
            if (render_as_camera_carrier)
            {
                cylinder(r=28/2, h=carrier_height + retainer_height);
            }
        }
        
        if (render_as_camera_carrier)
        {
            translate([0, 0, -0.5])
            {
                for(x=[-1, 1])
                {
                    through_height = carrier_height + retainer_height + 1;
                    counter_sink_diameter = 9;
                    counter_sink_depth = 3;
                    translate([small_screw_hole_spacing / 2 * x, 0, 0])
                    {
                        cylinder(r=small_screw_hole_diameter / 2,
                                 h=through_height);
                        cylinder(r=counter_sink_diameter / 2, 
                                 h=counter_sink_depth + 0.5);
                    }
                }
            }
        }
        
        for(i=[0:planet_count-1])
        {
            rotate(planet_axis_rotation(i))
            {
                translate(planet_axis_translation())
                {
                    translate([0, 0, -0.5])
                    {
                        cylinder(r=(planet_axle_diameter / 2) * 1.075, h=carrier_height + 1);
                    }
                    hex_head_depth = 3;
                    translate([0, 0, carrier_height - hex_head_depth])
                    {
                        cylinder(r=planet_axle_diameter + 0.2, hex_head_depth + 0.5, $fn=6);
                    }
                }
            }
        }
    }
}

function planet_axis_translation() =
    [sun_to_planet_dist(), 0, 0];

function planet_axis_rotation(i) =
    [0, 0, (360 / sun_teeth) * i * (sun_teeth / planet_count)];

function sun_to_planet_dist() =
    gear_dist(mm_per_tooth, sun_teeth, planet_teeth);

function gear_dist(mm, t1, t2) =
    pitch_radius(mm, t1) + pitch_radius(mm, t2);
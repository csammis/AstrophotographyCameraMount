use <lib/gear_lib.scad>

/*--------------------------------
1 : 5 ratio
--------------------------------*/
sun_teeth       = 8;
ring_teeth      = 32;
planet_teeth    = 12;

/*--------------------------------
1 : 4 ratio
--------------------------------*/
//sun_teeth       = 10;
//ring_teeth      = 30;
//planet_teeth    = 10;

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

render_ring             = true;
render_ring_tripod_mount_wings = true;
render_sun              = true;
render_planets          = true;
render_carrier          = true;
render_retainer         = true;
render_second_retainer  = true;
render_as_motor_retainer= true;

exploded_view           = true;

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
                    
                    for(r=[-45, 135])
                    for(r2=[-6, 6])
                    rotate([0, 0, r + r2])
                    translate([ring_diameter / 4 + mount_width, ring_diameter / 4 + mount_width, 0])
                    {
                        cylinder(r=3.2/2, h=ring_height + 1);
                    }
                }
                
                
            }
        }
    }
}

module retainer_ring()
{
    difference()
    {
        cylinder(r = ring_diameter / 2, h=retainer_height);
        translate([0, 0, -0.5])
        {
            cylinder(r = sun_axle_diameter, h=retainer_height + 1);
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

            translate([0, 0, carrier_height + carrier_post_height / 2])
            {
                cube([carrier_post_size, carrier_post_size, carrier_post_height], center=true);
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
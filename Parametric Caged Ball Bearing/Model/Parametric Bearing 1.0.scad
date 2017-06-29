// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Title:        Parametric Caged Bearing
// Version:      1.0
// Release Date: 2017-03-25 (ISO)
// Author:       Rohin Gosling
// -------------------------------------------------------------------------------------------------------------------------------------------------------------
//
// TODO:
//
// - Review code quality and comments.
//
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Constants:
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

// System constants.

C_CONSTANT = 0 + 0;         // Used to hide constant values from Thingiverse. Add to other constants to hide them as well.
C_NULL     = C_CONSTANT;    // Used to specify non assigned value.

// Booleans
// - Used in place of the OpenSCAD booleans for Thingiverse compatibility. )

C_FALSE = C_CONSTANT + 0;
C_TRUE  = C_CONSTANT + 1;

// Toolerances and machining constants.

C_EXCESS = C_CONSTANT + 0.5;    // Small overshoot used to prevent modeling artifacts during cuts (differences) at co-planar faces.

// Debugging constants.

C_EXTRUDE_ENABLED       = C_TRUE;
C_BALL_TEMPLATE_ENABLED = C_FALSE;

// OpenSCAD constants.

C_OPEN_SCAD_VERSION_2015 = C_CONSTANT + 2015;
C_OPEN_SCAD_VERSION_2016 = C_CONSTANT + 2016;

C_OPEN_SCAD_VERSION = C_OPEN_SCAD_VERSION_2016;     // Used to manage version specific syntax and features.


// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Thingiverse Parameters.
//
// - These parameters are used to integrate with the Thingiverse Customizer, and should only be used by the
//   class member variables specified in the "Model parameters" section below.
//
// - These Thingiverse Parameters should never be accessed from inside any module. We do this to enfoce 
//   principles of object orientation.
//
// - By seperating concerns between variables exposed to Thingiverse vs. variables used internaly by the 
//   SCAD model (class), we are better able to manage the ordering and grouping of variables exposed to 
//   Thingiverse, vs. the ordering of variables used internaly by the model.
//
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

// Model options.

// We use integer values for Thingiverse booleans, because Thingiverse does not support boolean values
// at this time (2017-03-25).

/* [Model Options] */

// Recomended value of 64 or more. Default = 128.
resolution                      = 64;
enable_inner_ring               = 1;     // [ 0:No, 1:Yes ]
enable_outer_ring               = 1;     // [ 0:No, 1:Yes ]
enable_cage                     = 1;     // [ 0:No, 1:Yes ]
enable_balls                    = 1;     // [ 0:No, 1:Yes ]
enable_inner_ring_chamfer       = 1;     // [ 0:No, 1:Yes ]
enable_outer_ring_chamfer       = 1;     // [ 0:No, 1:Yes ]
enable_inner_ring_knerling      = 1;     // [ 0:No, 1:Yes ]
enable_outer_ring_knerling      = 1;     // [ 0:No, 1:Yes ]
enable_bottom_cage_access_ports = 1;     // [ 0:No, 1:Yes ]
enable_top_cage_access_ports    = 1;     // [ 0:No, 1:Yes ]


// Ring parameters.

/* [Ring and Cage Parameters] */

bore            = 20.5;
outer_diameter  = 50.0;
shoulder_height = 1.0;
radial_gauge    = 2.0;
axial_gauge     = 1.0;

// Cage parameters.

cage_access_port_diameter = 2.5;

// Mechanical parameters.

/* [Mechanical Parameters] */

ball_count          = 6;
ball_ring_clearance = 0.1;
ball_cage_clearance = 0.3;

// Feature parameters.

/* [Feature Parameters] */

inner_chamfer_size        = 1.0;
outer_chamfer_size        = 1.0;

inner_knerling_count     = 3;
inner_knerling_depth     = 1.0;
inner_knerling_cut_ratio = 0.1;

outer_knerling_count     = 12;
outer_knerling_depth     = 1.0;
outer_knerling_cut_ratio = 0.2;

// Model parameters.

/* [Color Settings (Used only for model visualization)] */

enable_multiple_colors = 0;     // [ 0:No, 1:Yes ] 
// Only used if "Enable Multiple Colors" is set to "No".
default_color          = "silver";
inner_ring_color       = "red";
outer_ring_color       = "blue";
ball_color             = "yellow";
cage_color             = "green";

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Model parameters and geometric constraints. (Class member variables).
//
// - If we treat an SCAD file as though it is an object oriented class, then we can prefix global variables
//   with "m_", to denote class membership. 
//   As an alternative to "m_", we could also use "this_" as a standard.
//   However, "m_" is shorter and faster to type.
//
// - Once we have defined global variables as member variables of a class, in this case the class represented
//   by the SCAD file, then we are free to better manage the global vs local scope of class member 
//   variables, vs. local module (method) variables.
//
// - Thingiverse only integrates constant values. So as long as we reference other parameters or perform
//   computaions, then none of these will apear in Thingiverse. Through this mechanism, we can control the 
//   seperation of parameers that apear in Thingiverse, and those that don't.
//
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

// Cliping function used to apply value limit constraints.

function clip           ( x, x_min, x_max ) = ( x < x_min ) ? x_min : ( x > x_max ) ? x_max : x;
function max_ball_count ( r, d )            = floor ( 2.0*PI*r / d );

// Integer to Boolean conversion.

m_inner_ring_enabled               = ( enable_inner_ring               == 1 ) ? true : false;
m_outer_ring_enabled               = ( enable_outer_ring               == 1 ) ? true : false;
m_cage_enabled                     = ( enable_cage                     == 1 ) ? true : false; 
m_balls_enabled                    = ( enable_balls                    == 1 ) ? true : false;
m_inner_ring_chamfer_enabled       = ( enable_inner_ring_chamfer       == 1 ) ? true : false;
m_outer_ring_chamfer_enabled       = ( enable_outer_ring_chamfer       == 1 ) ? true : false;
m_inner_ring_knerling_enabled      = ( enable_inner_ring_knerling      == 1 ) ? true : false;
m_outer_ring_knerling_enabled      = ( enable_outer_ring_knerling      == 1 ) ? true : false;
m_bottom_cage_access_ports_enabled = ( enable_bottom_cage_access_ports == 1 ) ? true : false;
m_top_cage_access_ports_enabled    = ( enable_top_cage_access_ports    == 1 ) ? true : false;
m_colors_enabled                   = ( enable_multiple_colors          == 1 ) ? true : false;

// Mechanical parameters.

m_ball_ring_clearance = clip ( ball_ring_clearance, 0.0, 1.0 );
m_ball_cage_clearance = clip ( ball_cage_clearance, 0.0, 1.0 );
m_cage_ring_clearance = 0.2 + m_ball_ring_clearance + m_ball_cage_clearance;

// Bearing parameters.

m_outer_diameter  = outer_diameter;
m_bore            = bore;
m_radial_gauge    = radial_gauge;
m_axial_gauge     = axial_gauge;
m_shoulder_height = shoulder_height;
m_ball_diameter   = ( m_outer_diameter - m_bore )/2.0 - 2.0*m_radial_gauge;
m_width           = m_ball_diameter + 2.0*m_axial_gauge;
m_pitch_radius    = m_bore/2.0 + ( m_outer_diameter - m_bore )/4.0;
max_ball_count    = max_ball_count ( m_pitch_radius, m_ball_diameter );
m_ball_count      = ( ball_count < max_ball_count ) ? ball_count : max_ball_count;

// Cage parameters.

m_access_port_diameter = cage_access_port_diameter;

// Feature parameters.

m_inner_chamfer_size       = inner_chamfer_size;
m_outer_chamfer_size       = outer_chamfer_size;

m_inner_knerling_count     = inner_knerling_count;
m_inner_knerling_depth     = inner_knerling_depth;
m_inner_knerling_cut_ratio = inner_knerling_cut_ratio;

m_outer_knerling_count     = outer_knerling_count;
m_outer_knerling_depth     = outer_knerling_depth;
m_outer_knerling_cut_ratio = outer_knerling_cut_ratio;

// Model options.

m_resolution       = resolution;
m_default_color    = default_color;
m_inner_ring_color = inner_ring_color;
m_outer_ring_color = outer_ring_color;
m_ball_color       = ball_color;
m_cage_color       = cage_color;


// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Display data to console.
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

echo ( cage_ring_clearance = m_cage_ring_clearance );
echo ( ball_diameter       = m_ball_diameter - m_ball_ring_clearance );
echo ( width               = m_width );
echo ( bore                = m_bore );
echo ( pitch_radius        = m_pitch_radius );
echo ( outer_diameter      = m_outer_diameter );

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Program: Main module.
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

main();

module main ()
{
    // Initialize model resolution.
    
    $fn = m_resolution;
        
    // Generate model.

    if ( m_inner_ring_enabled ) component_inner_ring ();
    if ( m_outer_ring_enabled ) component_outer_ring ();
    if ( m_balls_enabled )      component_ball_array ( m_ball_count, m_ball_diameter, m_ball_ring_clearance );
    if ( m_cage_enabled )       component_cage ();
    
    // Debugging code.
    
    if ( C_BALL_TEMPLATE_ENABLED ) profile_ball_template ();       
        
    // Test
    
    //cylinder_sector ( radius = m_bore/2, height = m_width, angle = 10, tessellation = resolution, center = true );
   
    if ( 0 )
    {
        color ( "red" )
        circle ( r=m_pitch_radius, center = true );
    }
}



// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Component: Ball array.
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module component_ball_array ( count, diameter, clearance )
{
    // Retrieve class memeber data.
    // - We do this to make it easier to change member variable names more easily if we have to in the future.
    // - This also helps us quickly see which global variables we need to access for this module.
    // - Also neatens up our computation a bit, by removing the "m_" from the local module variable names.
    
    radial_gauge    = m_radial_gauge;
    bore            = m_bore;
    component_color = ( m_colors_enabled ) ? m_ball_color : m_default_color;
    
    // Generate ball array.
    
    color ( component_color )
    
    if ( C_EXTRUDE_ENABLED )
    {
        // Compute ball diameter, reduced by ball-ring clearance.
        
        d = diameter - 2.0*clearance;
        
        // Compute the radial translation of the ball array. i.e. the bearing pitch.
        
        tx = ( bore + d ) / 2 + radial_gauge + clearance;
        ty = 0.0;
        tz = 0.0;
        
        // Compute the angular translation between each ball, relative to the ball count.
            
        tr = 360 / count;
        
        // Generate the ball array.
        
        for ( i = [ 0 : count ] )
        {    
            tri = tr * i;
            rotate ( [ 0, 0, tri ] ) translate ( [ tx, ty, tz ] ) sphere ( d = d );
        }
    }
}

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Component: Inner Ring.
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module component_inner_ring ()
{   
    if ( C_EXTRUDE_ENABLED )
    {
        component_color = ( m_colors_enabled ) ? m_inner_ring_color : m_default_color;
        
        color ( component_color )
        difference ()
        {
            // Extrude the 3D object.
            
            rotate_extrude()
            profile_inner_ring ();
            
            // Cut knerling.
            
            if ( m_inner_ring_knerling_enabled )
            {
                cutting_tool_inner_knerling ();
            }
        }
        
    }
    else
    {
        // Sow only the profile for debugging purposes.
        
        profile_inner_ring ();
    }
}

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Component: Outer Ring.
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module component_outer_ring ()
{   
    if ( C_EXTRUDE_ENABLED )
    {
        component_color = ( m_colors_enabled ) ? m_outer_ring_color : m_default_color;
        
        color ( component_color )
        difference ()
        {        
            // Extrude the 3D object.
            
            rotate_extrude()
            profile_outer_ring ();

            // Cut Knerling;
            
            if ( m_outer_ring_knerling_enabled )
            {
                cutting_tool_outer_knerling ();
            }
        }        
    }
    else
    {
        // Sow only the profile for debugging purposes.
        
        profile_outer_ring ();
    }
}

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Component: Cage.
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module component_cage ()
{   
    // Retrieve class memeber data.
    // - We do this to make it easier to change member variable names more easily if we have to in the future.
    // - This also helps us quickly see which global variables we need to access for this module.
    // - Also neatens up our computation a bit, by removing the "m_" from the local module variable names.
    
    ball_count          = m_ball_count;    
    ball_diameter       = m_ball_diameter;
    ball_ring_clearance = m_ball_ring_clearance;
    ball_cage_clearance = m_ball_cage_clearance;
    component_color     = ( m_colors_enabled ) ? m_cage_color : m_default_color;
    
    // Generate component.
    
    if ( C_EXTRUDE_ENABLED )
    {
        // Compute relative cage clearance.
        
        ball_cut_diameter = ball_diameter - ball_ring_clearance;
        clearance         = -ball_cage_clearance;
        
        // Loft the 3D object.
        
        color ( component_color )
        difference ()
        {
            // Cage frame.
            
            rotate_extrude()
            profile_cage ();
            
            // Ball enclusure.
            
            component_ball_array ( ball_count, ball_cut_diameter, clearance );
            
            // Access ports.
                
            cutting_tool_access_port_array ();
        }
    }
    else
    {
        // Sow only the profile for debugging purposes.
        
        profile_cage ();
    }
}

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Cutting Tool: Access port array.
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module cutting_tool_access_port_array ()
{
    // Retrieve class memeber data.
    // - We do this to make it easier to change member variable names more easily if we have to in the future.
    // - This also helps us quickly see which global variables we need to access for this module.
    // - Also neatens up our computation a bit, by removing the "m_" from the local module variable names.
    
    width                            = m_width;
    access_port_diameter             = m_access_port_diameter;
    pitch_radius                   = m_pitch_radius;
    ball_count                       = m_ball_count;
    bottom_cage_access_ports_enabled = m_bottom_cage_access_ports_enabled;
    top_cage_access_ports_enabled    = m_top_cage_access_ports_enabled;
    
    // Configure access port dimentions.
    
    e  = C_EXCESS;
    ah = width / 2.0 + e;
    ar = access_port_diameter;    
    
    // Compute cutting tool component translations.
    
    tx0 = pitch_radius;
    ty0 = 0.0;
    tz0 = -ah;
    
    tx1 = pitch_radius;
    ty1 = 0.0;
    tz1 = 0.0;
    
    // Compute the angular translation between each cutting tool component, relative to the ball count.
            
    tr = 360 / ball_count;
        
    // Generate the cutting tool array.
        
    for ( i = [ 0 : ball_count ] )
    {    
        tri = tr * i;
        rotate ( [ 0, 0, tri ] )
        {
            // Generate bottom access port cutting tool components.
            
            if ( bottom_cage_access_ports_enabled )
            {
                translate ( [ tx0, ty0, tz0 ] ) cylinder ( h = ah, r = ar, center = false );
            }
            
            // Generate top access port cutting tool components.
            
            if ( top_cage_access_ports_enabled )
            {
                translate ( [ tx1, ty1, tz1 ] ) cylinder ( h = ah, r = ar, center = false );
            }            
        }
    }        
}


// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Cutting Tool: Inner knerling cutting tool. 2016 version.
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module cutting_tool_inner_knerling ()
{
    // Retrieve global parameters.
    
    e = C_EXCESS;                   // Extra length used to eliminate floating point diffrence errors during bollean operations.
    n = m_inner_knerling_count;     // Number of knerling cuts.
    d = m_inner_knerling_depth + e; // Cut depth.
    k = 360.0 / n;                  // Arc length in degrees.
    p = m_inner_knerling_cut_ratio; // Knerling cut ratio.
    w = m_width + 2.0*e;            // Bearing width.
    
    // Generate cutting tool.
    
    for ( i = [ 0 : n-1 ] )
    {
        // Compute rotation and cut ratio angles.
        
        t = i*k;
        a = p*k;
        
        // Compute radial translation.
        
        tx = m_bore/2.0 - e;
        ty = -w/2.0;
                
        // Generate cutting tool parts.
        //
        // Note:
        //
        // - For post-2016 versions of OpenSCAD, rotate_extrude offers a parameter to specify a central 
        //   angle for the rotaitonal extrusion.
        //
        // - For pre-2016 versions of OpenSCAD, rotate_extrude does not offer a central angle parameter.
        //   Therefor, we will need to scratch compute a cylindrical sector for the knerling cuts.
        
        if ( C_OPEN_SCAD_VERSION == C_OPEN_SCAD_VERSION_2016 )
        {
            tz = t - a/2.0;
            
            rotate ( [ 0.0, 0.0, tz ] )
            {        
                rotate_extrude ( angle = a )
                translate      ( [ tx, ty, 0 ] )
                rectangle      ( h = w, w = d, center = false );
            }
        }
        
        if ( C_OPEN_SCAD_VERSION == C_OPEN_SCAD_VERSION_2015 )
        {
            tz = t - 90 + a/2.0;
            
            rotate ( [ 0.0, 0.0, tz ] )
            {
                cylinder_sector
                (
                    inner_radius = 0.0,
                    outer_radius = tx + d,
                    height       = w,
                    angle        = a,
                    tessellation = m_resolution,
                    center       = true
                );
            }
        }        
    }
}       

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Cutting Tool: Outer knerling cutting tool. 2016 version.
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module cutting_tool_outer_knerling ()
{
    // Retrieve global parameters.
    
    e = C_EXCESS;                   // Extra length used to eliminate gloating point diffrence errors during bollean operations.
    n = m_outer_knerling_count;     // Number of knerling cuts.
    d = m_outer_knerling_depth + e; // Cut depth.
    k = 360.0 / n;                  // Arc length in degrees.
    p = m_outer_knerling_cut_ratio; // Knerling cut ratio.
    w = m_width + 2.0*e;            // Bearing width.
    
    // Generate cutting tool.
    
    for ( i = [ 0 : n-1 ] )
    {
        // Compute rotation and cut ratio angles.
        
        t = i*k;
        a = p*k;
        
        // Compute radial translation.
        
        tx = m_outer_diameter/2.0 - d + e;
        ty = -w/2.0;
        
        // Generate cutting tool parts.
        //
        // Note:
        //
        // - For post-2016 versions of OpenSCAD, rotate_extrude offers a parameter to specify a central 
        //   angle for the rotaitonal extrusion.
        //
        // - For pre-2016 versions of OpenSCAD, rotate_extrude does not offer a central angle parameter.
        //   Therefor, we will need to scratch compute a cylindrical sector for the knerling cuts.
        
        if ( C_OPEN_SCAD_VERSION == C_OPEN_SCAD_VERSION_2016 )
        {
            tz = t - a/2.0;
            
            rotate ( [ 0, 0, tz ] )
            {
                rotate_extrude ( angle = a )
                translate      ( [ tx, ty, 0 ] )
                rectangle      ( h = w, w = d, center = false );
            }
        }
        
        if ( C_OPEN_SCAD_VERSION == C_OPEN_SCAD_VERSION_2015 )
        {
            tz = t - 90 + a/2.0;
            
            rotate ( [ 0.0, 0.0, tz ] )
            {
				cylinder_sector
				(
					inner_radius = 0.0,
					outer_radius = tx + d,                    
					height       = w,
					angle        = a,
					tessellation = m_resolution,
					center       = true
				);
            }
        }
    }
}

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Profile: Inner Ring.
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module profile_inner_ring ()
{
    // Retrieve class memeber data.
    // - We do this to make it easier to change member variable names more easily if we have to in the future.
    // - This also helps us quickly see which global variables we need to access for this module.
    // - Also neatens up our computation a bit, by removing the "m_" from the local module variable names.
    
    bore                       = m_bore;
    inner_ring_chamfer_enabled = m_inner_ring_chamfer_enabled;
    inner_chamfer_size         = m_inner_chamfer_size;
    
    // Compute translation.
    
    tx = bore / 2.0;
    ty = 0.0;
    tz = 0.0;
    
    // Generate profile.
    
    translate ( [ tx, ty, tz ] ) profile_ring ( inner_ring_chamfer_enabled, inner_chamfer_size );
}

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Profile: Outer Ring.
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module profile_outer_ring ()
{
    // Retrieve class memeber data.
    // - We do this to make it easier to change member variable names more easily if we have to in the future.
    // - This also helps us quickly see which global variables we need to access for this module.
    // - Also neatens up our computation a bit, by removing the "m_" from the local module variable names.
    
    bore                       = m_bore;
    radial_gauge               = m_radial_gauge;
    ball_diameter              = m_ball_diameter;    
    outer_ring_chamfer_enabled = m_outer_ring_chamfer_enabled;
    outer_chamfer_size         = m_outer_chamfer_size;
    
    // Compute translation.
    
    tx = m_outer_diameter/2.0;

    // Generate profile.

    translate ( [ tx, 0.0, 0.0 ] ) rotate ( [ 0.0, 0.0, 180 ] ) profile_ring ( outer_ring_chamfer_enabled, outer_chamfer_size );
}

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Profile: Ring.
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module profile_ring ( chamfer_enabled, chamfer_size )
{
    // Retrieve class memeber data.
    // - We do this to make it easier to change member variable names more easily if we have to in the future.
    // - This also helps us quickly see which global variables we need to access for this module.
    // - Also neatens up our computation a bit, by removing the "m_" from the local module variable names.
    
    radial_gauge    = m_radial_gauge;
    shoulder_height = m_shoulder_height;
    width           = m_width;
    ball_diameter   = m_ball_diameter;
    
    // Compute ring geometry.
    
    rsx = radial_gauge + shoulder_height;
    rsy = width;
    
    // Compute ring translation.
    
    rtx = rsx / 2.0;
    rty = 0.0;
    rtz = 0.0;    
    
    // Compute ball raceway geometry.
    
    bsd = ball_diameter;
    
    // Compute ball raceway translation.
    
    btx = bsd / 2.0 + radial_gauge;
    bty = 0.0;
    btz = 0.0;
    
    // Compute chamfer geometry;
    
    cr = 2*chamfer_size;
    cs = sqrt ( ( cr * cr ) / 2.0 );
    
    // Compute chamfer translation.
    
    ctx = 0.0;
    cty = width / 2.0;
    ctz = 0.0;
    
    // Generate profile.
    
    difference ()
    {
        // Target = uncut inner ring profile.
        
        translate ( [ rtx, rty, rtz ] ) rectangle ( rsx, rsy, center = true );
        
        // Cut away raceway.
        
        translate ( [ btx, bty, btz ] ) circle    ( d = bsd );
        
        // Cut away left and right side chamfers.
        
        if ( chamfer_enabled )
        {
            translate ( [ ctx,  cty, ctz ] ) rotate ( [ 0, 0, 45 ] ) square ( size = cs, center = true );
            translate ( [ ctx, -cty, ctz ] ) rotate ( [ 0, 0, 45 ] ) square ( size = cs, center = true );
        }
    }
}

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Profile: Cage.
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module profile_cage ()
{
    // Retrieve class memeber data.
    // - We do this to make it easier to change member variable names more easily if we have to in the future.
    // - This also helps us quickly see which global variables we need to access for this module.
    // - Also neatens up our computation a bit, by removing the "m_" from the local module variable names.
    
    ball_diameter       = m_ball_diameter;
    shoulder_height     = m_shoulder_height;
    cage_ring_clearance = m_cage_ring_clearance;
    width               = m_width;
    ball_diameter       = m_ball_diameter;
    cage_ring_clearance = m_cage_ring_clearance;
    pitch_radius        = m_pitch_radius;
    
    // Compute cage geometry.
    
    csx = ball_diameter - 2.0*( shoulder_height + cage_ring_clearance );
    csy = width;
    
    // Compute ball enclosure geometry.
    
    bd = ball_diameter - 2.0*cage_ring_clearance;
    
    // Compute cage translation.
    
    tx = pitch_radius;
    ty = 0.0;
    tz = 0.0;    
    
    // Generate profile.
    
    translate ( [ tx, ty, tz ] )
    {
        union ()
        {
            rectangle ( csx, csy, center = true );        
            circle    ( d = bd );
        }
    }
}

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Profile: Ball template. Ueed for debuging only.
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module profile_ball_template ()
{
    // Retrieve class memeber data.
    // - We do this to make it easier to change member variable names more easily if we have to in the future.
    // - This also helps us quickly see which global variables we need to access for this module.
    // - Also neatens up our computation a bit, by removing the "m_" from the local module variable names.
    
    ball_diameter       = m_ball_diameter;
    ball_ring_clearance = m_ball_ring_clearance;
    bore                = m_bore;
    radial_gauge        = m_radial_gauge;
    ball_ring_clearance = m_ball_ring_clearance;
    
    // Generate 2D ball template.


    d = m_ball_diameter - 2*m_ball_ring_clearance;
    
    tx = ( m_bore + d ) / 2 + m_radial_gauge + m_ball_ring_clearance;
    ty = 0.0;
    tz = 0.0;
    
    translate ( [ tx, ty, tz ] ) circle ( d = d );
    
}

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Program: Rectangle.
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module rectangle ( w, h, center )
{
    scale ( [ w, h ] ) square ( size = 1.0, center = center );
}

//--------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module: Cylinder Sector
//
// Description:
//
// - Creates a cylindrical sector object.
//
// Parameters:
//
// - radius:
//   Radius of the cylinder sector.
//
// - height:
//   Height of the cylinder sector.
//
// - angle:
//   The central angle (angular distance) of the cylinder sector, measured in degrees.
// 
// - tessallation:
//   The tessallation factor is the dynamicaly adjusted polygon side count.
//   - For example, given a central angle of 360 degrees (i.e. a complete cylinder), and a tessallation of 8, the
//     module will generate a cylindrical solid with 8 sides.
//   - Given a central angle of 180 degrees (i.e. a half disk cylinder), and again a tessallation of 8, the 
//     module will generate a cylindrical solid with the number of sides dynamically adjusted to 4 sides in 
//     order to keep the tessallation resolution consistent. 
//   
// - center:
//   Boolean flag used to set the geometric center of the object.
//   - If true, the geometric center of the object is located about the origin, (0,0,0).
//   - If false, the base of the cylinder is locatedabout the origin, (0,0,0).
//
//--------------------------------------------------------------------------------------------------------------------------------------------------------------

module cylinder_sector ( inner_radius, outer_radius, height, angle, tessellation, center )
{    
    // Recursive function that generates an n dimentional vector of integers, in the range [0..n-1].
    //
    // Parameters:
    //
    //   n = Number of elements in the vector.
    //   i = Element index. Initialize to zero.
    //   v = Vector to be populated with sequence. Initialize with an empty vector, [].
    //
    // Example:
    //
    //   n = 8;
    //   i = 0;
    //   v = [];
    //   x = count_loop ( n, i, v );
    //   echo ( x = x );
    //  
    //   ECHO: x = [0, 1, 2, 3, 4, 5, 6, 7 ]
    
    function count_loop  ( n, i, v ) = ( i >= n  ? v : count_loop  ( n, i+1, concat ( v, [i] ) ) );
    
    // Recursive function that generates the cooridinates for a 2D pie slice.
    //
    // Parameters:
    //
    //   r = Pie slice radius. Initialize to the radius of the pie slice.
    //   t = Arc angle.
    //   n = Number of arc points. Initialize to the number of points for the pie slice geomtery.
    //   i = Point index. Initialize to zero.
    //   v = Vector that will be populated with geometry poitns. Initialize to empty vector, [].

    function vector_loop ( r, t, n, i, v ) =
    (
        i>n
    
        // On the recursive terminating condition, add the center point of the pie slice.
    
        ? concat ( v, [[0,0]] )
    
        // On the recursive general condition, compute the next angular point of the pie slice.
        //
        // x = r*cos(i*t/n), where i is the point index, t is the arc angle, and n is the tessellation factor.
        // y = r*sin(i*t/n), where i is the point index, t is the arc angle, and n is the tessellation factor.
    
        : vector_loop ( r, t, n, i+1, concat ( v, [ [ r*sin ( i*t/n ), r*cos ( i*t/n ) ] ] ) )
    );
    
    // Initialize local variables.
    
    e  = 0.01;
    t  = angle;
    h  = height;
    ri = inner_radius;
    ro = outer_radius;
    n  = round ( tessellation*angle/360 );     // Compute dynamicly adjusted tessellation.        
    i  = 0;
    v  = [];
    
    // Generate 2D geometry
        
    points_outer = vector_loop ( ro, t, n, i, v );
    indicies     = [ count_loop ( n+2, i, v ) ];
    
    // Generate 3D object.

    difference()
    {
        linear_extrude ( height = h, center = center )
        polygon ( points_outer, indicies );
        
        if ( ri > 0.0 )
        {
            cylinder ( r = ri, h = h + e, center = center, $fn = tessellation );
        }
    }
}


// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// 
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

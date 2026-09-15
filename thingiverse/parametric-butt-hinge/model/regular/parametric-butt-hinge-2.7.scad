// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Title:        Parametric Caged Bearing
// Version:      2.6
// Release Date: 2017-03-25 (ISO)
// Author:       Rohin Gosling
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
//
// Description:
//
// - Parametric butt hinge, designed to be printed in one step.
//
// Module and Function Call Structure:
//
// - Main
//   - leaf
//     - workpiece_leaf_knuckle_pin
//       - workpiece_leaf_knuckle
//         - workpiece_leaf
//         - tool_cutter_knuckles
//       - pin
//     - tool_cutter_fastener_set
//       - tool_cutter_fastener
//
// TODO:
//
// - Replace module "tool_cutter_knuckles", with the new version "tool_cutter_knuckle_array".
// - Check comment spelling.
// - Review header comments for new modules.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Constants:
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

// System constants.

C_CONSTANT = 0 + 0;     // Used to hide constant values from Thingiverse. Add to other constants to hide them as well.

// Leaf gender.

C_FEMALE   = C_CONSTANT + 0;
C_MALE     = C_CONSTANT + 1;

// SCG component type.

C_NEGATIVE = C_CONSTANT + 0;
C_POSITIVE = C_CONSTANT + 1;

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Thingiverse Parameters.
//
// - These parameters are used to integrate with the Thingiverse Customizer, and should only be used by the
//   class member variables specified in the "Model parameters" section below.
//
// - These Thingiverse Parameters should never be accessed from inside any module. We do this to enforce 
//   principles of object orientation.
//
// - By separating concerns between variables exposed to Thingiverse vs. variables used internally by the 
//   SCAD model (class), we are better able to manage the ordering and grouping of variables exposed to 
//   Thingiverse, vs. the ordering of variables used internally by the model.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

/* [Options] */

enable_male_leaf      = 1;     // [ 0:No, 1:Yes ]
enable_female_leaf    = 1;     // [ 0:No, 1:Yes ]
enable_fillet         = 1;     // [ 0:No, 1:Yes ]
enable_knuckle_gusset = 1;     // [ 0:No, 1:Yes ]
// Turn this off to set a custom pin diameter. Auto pin size is equal to the leaf gauge.
enable_auto_pin_size  = 1;     // [ 0:No, 1:Yes ]
enable_fasteners      = 1;     // [ 0:No, 1:Yes ]

/* [Leaf Parameters] */

hinge_width        = 60.0;
leaf_width         = hinge_width / 2.0;
leaf_height        = 60.0;
// Leaf and knuckle thickness. Values greater than 3mm recommended.
leaf_gauge         = 5.0;

/* [Mechanical Properties] */

// Recomended values between 0.3 and 4.0. Better quality below 3.0, tough to loosen.
component_clearance  = 0.4;
knuckle_outer_radius = leaf_gauge * 2.0;
knuckle_count        = 5;               // [3,5,7,9,11,13,15]
//knuckle_gusset_width = 3.0;

// Pin parameters.

// Manual pin diameter setting. This will only have an effect, if "Enable Auto Pin Size" is set to "No".
pin_diameter            = 4.0;
parametric_pin_diameter = ( enable_auto_pin_size == 1 ) ? leaf_gauge : pin_diameter;

/* [Fastener Holes] */

// For countersunk, the chamfer angle may be adjusted using the other parameters.
fstener_head_type                = 0;   // [ 0:Counterbored, 1:Countersunk ]
counter_sink_depth               = 2.5;
fastener_thread_diameter         = 3.0;
// Add 0.5mm to 1.0mm to the fastener head diameter, to allow for head clearance. 
fastener_head_diameter           = 7.0;
fastener_count                   = 6;
fastener_column_count            = 2;   // [1,2]
// Distance from the edge of the head diameter, to the edges of the leaves.
fastener_margin                  = 4.0;
leaf_fillet_radius               = fastener_head_diameter/2.0 + fastener_margin;

/* [Model Parameters] */

// Recommended value is 64 or greater.
resolution      = 128;
component_color = "Silver";

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Model parameters and geometric constraints. (Class member variables).
//
// - If we treat an SCAD file as though it is an object oriented class, then we can prefix global variables
//   with "m_", to denote class membership. 
//   As an alternative to "m_", we could also use "this_" as a standard.
//   However, "m_" is shorter and faster to type.
//
// - Once we have defined global variables as member variables of a class, in this case the class represented
//   by the SCAD file, then we are free to better manage global vs local scope of class member 
//   variables, vs. local module (method) variables.
//
// - Thingiverse only integrates constant literal values. So as long as we reference other parameters or 
//   initialize variables as expressions, then none of these will appear in the Thingiverse customizer.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

// Model Options

m_male_leaf_enabled      = ( enable_male_leaf      == 1 ) ? true : false;
m_female_leaf_enabled    = ( enable_female_leaf    == 1 ) ? true : false;
m_leaf_fillet_enabled    = ( enable_fillet         == 1 ) ? true : false;
m_knuckle_gusset_enabled = ( enable_knuckle_gusset == 1 ) ? true : false;
m_pin_auto_size_enabled  = ( enable_auto_pin_size  == 1 ) ? true : false;
m_fasteners_enabled      = ( enable_fasteners      == 1 ) ? true : false;

// Leaf Parameters

m_hinge_width = hinge_width;
m_leaf_width  = hinge_width / 2.0;
m_leaf_height = leaf_height;
m_leaf_gauge  = leaf_gauge;

// Mechanical Properties

m_component_clearance  = component_clearance;
m_knuckle_outer_radius = leaf_gauge * 2.0;
m_knuckle_count        = knuckle_count;
m_knuckle_gusset_width = fastener_margin; 

// Pin Parameters

m_pin_diameter            = pin_diameter;
m_parametric_pin_diameter = ( m_pin_auto_size_enabled == true ) ? m_leaf_gauge : m_pin_diameter;

// Fastener Holes

m_fstener_head_type        = fstener_head_type;
m_counter_sink_depth       = counter_sink_depth;
m_fastener_thread_diameter = fastener_thread_diameter;
m_fastener_head_diameter   = fastener_head_diameter;
m_fastener_count           = fastener_count;
m_fastener_column_count    = fastener_column_count;
m_fastener_margin          = fastener_margin;
m_leaf_fillet_radius       = fastener_head_diameter / 2.0 + fastener_margin;

// Model parameters.

m_resolution      = resolution;
m_component_color = component_color;

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// DEBUG: Console Output. 
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

echo ( absolute_pin_diameter = m_parametric_pin_diameter - m_component_clearance / 2.0 );

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      Main
// Module Type: Model
//
// Description:
//
// - Program entry point.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

main();

module main ()
{   
    // Initialize model resolution.
    
    $fn = m_resolution;
    
    // Generate model.
    
    if ( m_female_leaf_enabled ) leaf ( C_FEMALE ); 
    if ( m_male_leaf_enabled )   leaf ( C_MALE );  
    
    //test_workpiece_leaf_knuckle ( C_MALE );
    //test_workpiece_leaf_knuckle ( C_FEMALE );
    
    //workpiece_gusset_array ( gender = C_FEMALE, scg_type = C_POSITIVE, fill_component_clearance = true );
}

module test_workpiece_leaf_knuckle ( gender )
{   
    w = m_leaf_width;
    l = m_leaf_height;
    h = m_leaf_gauge;
    r = m_leaf_fillet_radius;
    d = m_knuckle_outer_radius;
    c = 0.5;
    
    // Create workpiece.
    
    difference ()
    {
        // leaf and knuckle work piece.
        
        translate ( [ 0, -l/2, 0 ] )   rotate ( [ -90, 0, 0 ] ) cylinder ( d = d, h = l );
        translate ( [ 0, -l/2-c, 0 ] ) rotate ( [ -90, 0, 0 ] ) cylinder ( d = d-c, h = l+2*c );
            
        // Cut knucke gaps.
        
        tool_cutter_knuckles ( gender );
    }
}



// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      leaf.
// Module Type: Component.
//
// Description:
//
// - Creates a hinge leaf component, whose gender may be selected through the gender argument.
//
// Parameters:
//
// - gender:
//   The gender (male, female), of the leaf. The female leaf holds the pin.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module leaf ( gender )
{  
    gender_angle = ( gender == C_FEMALE ) ? 0 : 180;
    
    rotate ( [ 0, 0, gender_angle ] )
    {
        color ( m_component_color )
        difference ()
        {
            // Cut pin hole.
            
            workpiece_leaf_knuckle_pin ( gender );   
            
            // Cut fstener holes.
            
            if ( m_fasteners_enabled )
            {
                tool_cutter_fastener_set ( m_fastener_count, m_fastener_column_count, 0 );                
            }
        }
    }
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      workpiece_leaf_knuckle_pin
// Module Type: Workpiece.
//
// Description:
//
// - This module creates the workpiece used to construct either a male or female leaves.
//
// Parameters:
//
// - gender:
//   The gender (male, female), of the leaf. The female leaf holds the pin.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module workpiece_leaf_knuckle_pin ( gender )
{    
    d = m_parametric_pin_diameter;
    c = m_component_clearance;
    t = 0.01;                       // Small tolerance to prevent SCG surface interference. 
    
    if ( gender == C_FEMALE )
    {   
        union ()
        {                           
            dc = d - c/2.0;
            
            workpiece_leaf_knuckle ( C_FEMALE );            
            pin ( dc, m_leaf_height - t );
        }
    }
    else
    {
        difference ()
        {   
            dc = d + c/2.0;            
            
            workpiece_leaf_knuckle ( C_MALE );            
            pin ( dc, m_leaf_height + t );
        }
    }
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      pin
// Module Type: Component.
//
// Description:
//
// - Hinge pin component.
//
// Parameters:
//
// - diameter:
//   Diameter of the cylinder used to create the pin.
//
// - length:
//   Length of the cylinder used to create the pin.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module pin ( diameter, length )
{   
    rotate ( [ 90, 0, 0 ] )
    {   
        // Initialize pin dimensions.
        
        tx = 0;
        ty = 0;
        tz = -length/2;
        
        // Create pin.
        
        translate ( [ tx, ty, tz ] )
        {
            cylinder ( d = diameter, h = length );
        }
    }
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      workpiece_leaf_knuckle
// Module Type: Workpiece.
//
// Description:
//
// - Workpiece used to cut away knuckle structures.
//
// Parameters:
//
// - gender:
//   The gender (male, female), of the leaf. The female leaf holds the pin.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module workpiece_leaf_knuckle ( gender )
{
    // Initialize local variables.
    
    gender_flipped = ( gender == C_MALE ) ? C_FEMALE : C_MALE;
    
    w = m_leaf_width;
    l = m_leaf_height;
    h = m_leaf_gauge;
    r = m_leaf_fillet_radius;
    d = m_knuckle_outer_radius;
    
    // Create workpiece.
    
    difference ()
    {
        difference ()
        {
            // leaf and knuckle work piece.
            
            translate ( [ 0, -l/2, 0 ] )
            {        
                union ()
                {                    
                    // Leaf.
                          
                    workpiece_leaf ( w, l, h, r );
                                    
                    // Knuckle.
                    
                    rotate ( [ -90, 0, 0 ] ) cylinder ( d = d, h = l );
                    
                    // Gusset array.
                    if ( m_knuckle_gusset_enabled ) 
                    {
                        translate ( [ 0, l/2, 0 ] )
                        workpiece_gusset_array ( gender = gender, scg_type = C_POSITIVE, fill_component_clearance = false );
                    }
                }
            }
                
            // Cut knucke gaps.
            
            tool_cutter_knuckles ( gender );        
        }
     
        if ( m_knuckle_gusset_enabled )
        {
            workpiece_gusset_array ( gender = gender_flipped, scg_type = C_NEGATIVE, fill_component_clearance = true );
        }
    }
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      workpiece_leaf
// Module Type: Workpiece.
//
// Description:
//
// - Workpiece used to cut away leaf structures.
//
// Parameters:
//
// - w:
//   Width of a single leaf.
//
// - l:
//   Length of the leaf.
//
// - h:
//   Height of the leaf.
//
// - r:
//   Radius of the hinge knuckle.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module workpiece_leaf ( w, l, h, r )
{
    translate ( [ 0, 0, -h ] )
    {   
        union ()
        {
            if ( m_leaf_fillet_enabled )
            {
                // Leaf.
            
                cube ( [ w-r, l, h] );
                translate ( [  0, r, 0 ] ) cube ( [ w, l-2*r, h] );
            
                // Fillet corcers.            
            
                translate ( [  w - r, r,   0 ] ) cylinder ( r = r, h = h );
                translate ( [  w - r, l-r, 0 ] ) cylinder ( r = r, h = h );
            }
            else
            {
                // Leaf.
            
                cube ( [ w, l, h] );
            }
        }
    }  
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      tool_cutter_knuckles
// Module Type: Cutting Tool.
//
// Description:
//
// - An array of cubic blocks, used as a cutting tool to cut knuckle features out of the knuckle workpieces.
//
// Parameters:
//
// - gender:
//   The gender (male, female), of the leaf. The female leaf holds the pin.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module tool_cutter_knuckles ( gender )
{
    // Initialize local variables.
    
    n = m_knuckle_count;
    h = m_leaf_height;
    c = m_component_clearance;
    e = m_leaf_gauge;    
    
    // Compute absolute knuckle height, k.
    
    k = ( h - n*c + c ) / n;
    
    // Generate tool parts.

    a = 0;
    b = ( gender == 0 ) ? n/2-1 : n/2;
    
    for ( i = [ a : b ] )
    {
        // Compute knuckle segment increment.
        
        si = 2.0*i*( k + c );        
        g  = ( gender == 0 ) ? k + c : 0;
        
        // Compute relative origin.
        
        o = h/2.0;
        s = 2.0*e;    
        
        // Compute translation.
        
        tx = -( s + c )/2.0;
        ty = -o + g + si - c;
        tz = -( s + c )/2.0;
        
        // Compute size.
        
        dx = s + c;
        dy = k + 2.0*c;
        dz = s + c;
        
        // Generate cutting tool component.
        
        translate ( [ tx, ty, tz ] ) cube ( [ dx, dy, dz] );
    }
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      tool_cutter_fastener
// Module Type: Cutting Tool.
//
// Description:
//
// - Cutting tool used to cut fastener holes into leaf workpiece.
//
// Parameters:
//
// - z_offset:
//   Depth of the cut.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module tool_cutter_fastener ( z_offset,  )
{
    offcut = 1.0;
    id     = m_fastener_thread_diameter;              // Inner diameter.
    od     = m_fastener_head_diameter;                // Outer diameter.
    t      = m_fstener_head_type;                     // 0 = Fillister (Pan head), 1 = flat countersunk.
    d      = m_counter_sink_depth;                    // Depth of head counter sink.
    z0     = z_offset - ( m_leaf_gauge + offcut );    // Vertical position of head.
    z1     = z_offset - m_counter_sink_depth;         // Vertical position of thread.
    h0     = m_leaf_gauge + offcut;                   // Height of head.
    h1     = m_counter_sink_depth + offcut;           // Height of thread.
    
    union ()
    {
        // Thread
        
        translate ( [ 0, 0, z0 ] )
        {
            cylinder ( d = id, h = h0 );
        }
        
        // Head.
        
        translate ( [ 0, 0, z1 ] )
        {   
            d_top    = od;
            d_bottom = ( t == 0 ) ? od : id;            
            cylinder ( d2 = d_top, d1 = d_bottom, h = h1 );
        }
    }
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      tool_cutter_fastener_set
// Module Type: Cutting Tool.
//
// Description:
//
// - Cutting tool used to cut fastener holes into leaf workpiece.
//
// Parameters:
//
// - fastener_count:
//   Number of fasterner holes to be cut into a single leaf.
//   The total number of fastener holes on the whole hinge, will be twice the value of fastener_count.
//   i.e. 'fastener_count' holes, on each leaf.
//
// - fastener_column_count:
//   Number of fastener column per leaf. This value can be either 1, or 2.
//
// - z_offset:
//   Depth of the cut.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module tool_cutter_fastener_set ( fastener_count, fastener_column_count, z_offset )
{
    // Relative origin.
    
    xo = m_leaf_gauge + m_component_clearance/2 + m_fastener_head_diameter/2 + m_fastener_margin;
    yo = -m_leaf_height/2 + m_fastener_head_diameter/2 + m_fastener_margin;
    
    // Column offsets.
    
    col0 = 0;
    col1 = m_leaf_width - m_fastener_head_diameter/2 - m_fastener_margin - xo;
    
    // Loop configuration.
    
    even = ( fastener_count % 2 ) ? false : true;
    n1   = fastener_count - 1;    
    n2   = round ( fastener_count / 2 ) - 1;
    k1   = ( leaf_height - fastener_head_diameter - 2*fastener_margin ) / n1;
    k2   = ( leaf_height - fastener_head_diameter - 2*fastener_margin ) / n2;
            
    // Generate fastener cutting tool.
    
    // One column of fastener holes, if we have selected one fastener hole column.
    
    if ( fastener_column_count == 1 )
    {
        for ( row = [ 0 : n1 ] )
        {
            cx = ( col0 + col1 ) / 2.0;
            tx = xo + cx;
            ty = yo + row * k1;
            tz = 0;                
                            
            translate ( [ tx, ty, tz ] ) tool_cutter_fastener ( z_offset );
        }
    }
    
    // Two columns of fastener holes, if we have selected two fastener hole column.
    
    if ( fastener_column_count == 2 )
    {
        for ( col = [ 0 : 1 ] )
        {  
            // Column 0, offset translation when we have an odd number of fasteners.
            
            if ( col == 0 )
            {
                m = ( even ) ? 0 : 1;
                
                for ( row = [ 0 : n2 - m ] )
                {        
                    cx = ( col == 0 ) ? col0 : col1;
                    tx = xo + cx;
                    ty = ( even ) ? yo + row * k2 : yo + row * k2 + k2/2;
                    tz = 0;                
                                    
                    translate ( [ tx, ty, tz ] ) tool_cutter_fastener ( z_offset );
                }
            }
            
            // Column 1.
            
            if ( col == 1 )
            {
                for ( row = [ 0 : n2 ] )
                {        
                    cx = ( col == 0 ) ? col0 : col1;
                    tx = xo + cx;
                    ty = yo + row * k2;
                    tz = 0;                
                    
                    translate ( [ tx, ty, tz ] ) tool_cutter_fastener ( z_offset );
                }
            }                    
        }
    }
}

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module:      workpiece_gusset_array
// Module Type: Workpiece.
//
// Description:
//
// - Create an array of cutting blocks. Mostly used to cut gusset workpiece into indevidual gusset positives or negatives.
//
// Parameters:
//
// - gender:
//   Specifies the number of knuckle joints based on hinge leaf gender.   
//
// - scg_type:
//   Solid Constructive Geometry type.
//   If C_POSITIVE, then add to the base work peice.
//   If C_NAGATIVE, then subtract from the base work peice.
//
// - fill_component_clearance:
//   If true, then create wide cutting blocks that fill in the component clearance.
//   If false, then create narrow cutting blocks that leave space for the component clearance.
//
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module workpiece_gusset_array ( gender, scg_type, fill_component_clearance )
{   
    // Local constants.
    
    SCG_OVERLAP = 0.1;
    
    // Compute cutting block size.
    
    cutting_block_size = m_leaf_gauge + m_knuckle_gusset_width;
    leaf_height        = ( scg_type == C_NEGATIVE ) ? m_leaf_height + SCG_OVERLAP : m_leaf_height; 
    
    // Compute cutting block translation.
    
    xt = ( scg_type == C_NEGATIVE ) ? cutting_block_size/2.0 + SCG_OVERLAP : cutting_block_size/2.0;
    yt = 0.0;
    zt = 0.0;
    
    // Create gusset array.
    
    difference ()
    {
        workpiece_gusset
        (
            width         = m_knuckle_gusset_width, 
            height        = leaf_height, 
            knuckle_radus = m_leaf_gauge, 
            scg_type      = scg_type
        );
        
        translate ( [ xt, yt, zt ] )
        tool_cutter_knuckle_array
        (
            gender                   = gender,
            fill_component_clearance = !fill_component_clearance,
            size                     = cutting_block_size
        );
    }
}

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module:      tool_cutter_knuckle_array
// Module Type: Cutting tool.
//
// Description:
//
// - Create an array of cutting blocks. Mostly used to cut gusset workpiece into indevidual gusset positives or negatives.
//
//
// Parameters:
//
// - gender:
//   Specifies the number of knuckle joints based on hinge leaf gender.
//
// - fill_component_clearance:
//   If true, then create wide cutting blocks that fill in the component clearance.
//   If false, then create narrow cutting blocks that leave space for the component clearance.
//
// - size:
//   Specifies the dimention used for the x and z axies.
//
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module tool_cutter_knuckle_array ( gender, fill_component_clearance, size )
{   
    // Local constants.
    
    SCG_OVERLAP = 0.1;    
    
    // Initialize local variables.
    
    n = m_knuckle_count;
    h = m_leaf_height;
    c = m_component_clearance;
    e = SCG_OVERLAP;
    
    // Compute knuckle width and segment width.
    
    k = ( h + c )/n - c;
    s = ( fill_component_clearance ) ? k + 2.0*c : k;
    
    // Compute segment offset.
    
    o = ( fill_component_clearance ) ? c : 0.0;
    
    // Generate block array.
    
    a = 0;
    b = ( gender == C_MALE ) ? n/2 : n/2-1;
    g = ( gender == C_MALE ) ? 0.0 : k + c;
    
    for ( i = [ a : b ] )
    {
        // Compute translation index.
        
        ki = g + 2.0*i*(k + c ) - h/2.0 - o;
        
        // Initialize translation.
        
        xt = -size/2.0;
        yt = ki;
        zt = -size/2.0;
        
        // Initialize cutting block dimentions.
    
        cube_x = size;
        cube_y = s;
        cube_z = size;
        
        // Create cutting block.
        
        color ( "red" )
        translate ( [ xt, yt, zt ] )        
        cube ( [ cube_x, cube_y, cube_z ] );
    }
}

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module:      workpiece_gusset
// Module Type: Workpeice
//
// Description:
//
// - Knuckle gusset used to strengthen the knuckle joints.
//
// Parameters:
//
// - width
//   The length of the gusset, as measured from the edge of the knucke.
//   We name it "width", in order to maintain dimention naming consistancy with the rest of the hinge dimentions.
//
// - height
//   The thickness of the gusset.
//   We name this "height", in order to maintain dimention naming consistency with the rest of the hinge dimentions.
//
// - knuckle_radus
//   Outer radius of the knuckles. This is also the same value as the leaf gauge.
//
// - scg_type
//   If set to 0 or C_NEGATVE, to greate the version of the component used for cutting away from the leaves.
//   If set to 1 or C_POSITIVE, to greate the version of the component used for adding to the leaves and knuckles.
//
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module workpiece_gusset ( width, height, knuckle_radus, scg_type )
{
    // Local constants.
    
    SCG_OVERLAP = 0.1;
    CENTER      = true;
    
    // Initialize input values.
    
    w = width;          // Gusset width.
    g = knuckle_radus;  // Knucle radius is equal to the leaf guage.
    c = SCG_OVERLAP;    // Amount to overlap unions in order to prevent boolean anomolies.
    
    // Compute gusset radius. The radius of the circle, that is tangental to the knuckle cylinder.
    
    r = ( 2.0*g*w + w*w ) / ( 2.0*g );

    // Compute gusset height. The point of intersection between the knuckle cylinder and the gusset cutter.
    
    h = ( g*r ) / sqrt ( g*g + 2.0*g*w + r*r + w*w );
    
    // Compute intersection point between knuckle and gusset cutting tool, using gusset height.
    // The coordinate of the intersection point are, p(x,h), where h is the vertical value of the coordinate.
    
    x = h*( g + w ) / r;
        
    // Compute gusset cutting tool translation.
    
    ctxd = g + w;
    ctyd = c;
    ctzd = r;
    ctt  = height + 2.0*x;
    
    // Compute gusset work piece translation and dimentions..
    
    wpw  = g + w -x;
    wph  = h + c;    
    wpxd = x;
    wpyd = 0.0;
    wpzd = 0.0 - c;
    wpt  = height;
    
    // Initialize cutting plane and component scaling.
    
    xr = 90.0;
    yr = 0.0;
    zr = 0.0;
    
    xs =  1.0;
    ys = -1.0;
    zs =  ( scg_type == C_POSITIVE ) ? 1.0 : -1.0;
   
    // Generate gusset.
    
    color ( "silver" )
    scale ( [ xs, ys, zs ] )
    difference ()
    {
        translate ( [ wpxd, wpyd, wpzd ] ) rotate ( [ xr, yr, zr ] ) linear_extrude ( height = wpt, center = CENTER ) rectangle ( w = wpw, h = wph );
        translate ( [ ctxd, ctyd, ctzd ] ) rotate ( [ xr, yr, zr ] ) linear_extrude ( height = ctt, center = CENTER ) circle    ( r = r );            
    }
}

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module:      Rectangle.
// Module Type: 2D Shape.
//
// Description:
//
// - Creates a 2D rectangle.
//
// Parameters:
//
// - w
//   Rectangle width.
//
// - h
//   Rectangle height.
//
// - center
//   Center the rectangle about the origin (0,0,0) if true, else place the rectangle in the positive quadrant.
//
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module rectangle ( w, h, center )
{
    scale ( [ w, h ] ) square ( size = 1.0, center = center );
}

//--------------------------------------------------------------------------------------------------------------------------------------------------------------
// Function: Clip
//
// Description:
//
// - Clips an input value, to a minimum and maximum value.
//
//   x_min ≤ x ≤ x_max
// 
// Parameters:
//
// - x
//   Input value.
//
// - x_min
//   Minimal value constraint. Any x less than x_min, is set to x_min. 
//
// - x_max
//   Maximum value constraint. Any x greater than x_max, is set to x_max.
//
//--------------------------------------------------------------------------------------------------------------------------------------------------------------

function clip ( x, x_min, x_max ) = ( x < x_min ) ? x_min : ( x > x_max ) ? x_max : x;

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Function: funtion_name
//
// Description:
//
// - Function description.
//
// Return Value:
//
// - Description of return value.
//
// Parameters:
//
// - x
//   Argument x description.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      Cylinder sector.
// Module Type: 2D Shape.
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
// - tessellation:
//   The tessellation factor is the dynamically adjusted polygon side count.
//   - For example, given a central angle of 360 degrees (i.e. a complete cylinder), and a tessellation of 8, the
//     module will generate a cylindrical solid with 8 sides.
//   - Given a central angle of 180 degrees (i.e. a half disk cylinder), and again a tessellation of 8, the 
//     module will generate a cylindrical solid with the number of sides dynamically adjusted to 4 sides in 
//     order to keep the tessellation resolution consistent. 
//   
// - center:
//   Boolean flag used to set the geometric center of the object.
//   - If true, the geometric center of the object is located about the origin, (0,0,0).
//   - If false, the base of the cylinder is located about the origin, (0,0,0).
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

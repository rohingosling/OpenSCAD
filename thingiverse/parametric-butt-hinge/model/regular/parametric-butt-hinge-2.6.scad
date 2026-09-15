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
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Constants:
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

// System constants.

C_CONSTANT = 0 + 0;     // Used to hide constant values from Thingiverse. Add to other constants to hide them as well.

// Leaf gender.

C_FEMALE   = C_CONSTANT + 0;
C_MALE     = C_CONSTANT + 1;

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

enable_male_leaf     = 1;     // [ 0:No, 1:Yes ]
enable_female_leaf   = 1;     // [ 0:No, 1:Yes ]
enable_fillet        = 1;     // [ 0:No, 1:Yes ]
// Turn this off to set a custom pin diameter. Auto pin size is equal to the leaf gauge.
enable_auto_pin_size = 1;     // [ 0:No, 1:Yes ]
enable_fasteners     = 1;     // [ 0:No, 1:Yes ]

male_leaf_enabled     = ( enable_male_leaf     == 1 ) ? true : false;
female_leaf_enabled   = ( enable_female_leaf   == 1 ) ? true : false;
leaf_fillet_enabled   = ( enable_fillet        == 1 ) ? true : false;
pin_auto_size_enabled = ( enable_auto_pin_size == 1 ) ? true : false;
fasteners_enabled     = ( enable_fasteners     == 1 ) ? true : false;

/* [Leaf Parameters] */

hinge_width        = 60;
leaf_width         = hinge_width / 2;
leaf_height        = 60;
// Leaf and knuckle thickness. Values greater than 3mm recommended.
leaf_gauge         = 5;

/* [Mechanical Properties] */

// Recomended values between 0.3 and 4.0. Better quality below 3.0, tough to loosen.
component_clearance  = 0.4;
knuckle_outer_radius = leaf_gauge * 2.0;
knuckle_count        = 5;               // [3,5,7,9,11,13,15]  

// Pin parameters.

// Manual pin diameter setting. This will only have an effect, if "Enable Auto Pin Size" is set to "No".
pin_diameter            = 4;
parametric_pin_diameter = ( pin_auto_size_enabled == true ) ? leaf_gauge : pin_diameter;

/* [Fastener Holes] */

// For countersunk, the chamfer angle may be adjusted using the other parameters.
fstener_head_type                = 0;   // [ 0:Counterbored, 1:Countersunk ]
counter_sink_depth               = 2.5;
fastener_thread_diameter         = 3;
// Add 0.5mm to 1.0mm to the fastener head diameter, to allow for head clearance. 
fastener_head_diameter           = 7;
fastener_count                   = 5;
fastener_column_count            = 2;   // [1,2]
// Distance from the edge of the head diameter, to the edges of the leaves.
fastener_margin                  = 3;
leaf_fillet_radius               = fastener_head_diameter/2 + fastener_margin;

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

m_male_leaf_enabled     = ( enable_male_leaf     == 1 ) ? true : false;
m_female_leaf_enabled   = ( enable_female_leaf   == 1 ) ? true : false;
m_leaf_fillet_enabled   = ( enable_fillet        == 1 ) ? true : false;
m_pin_auto_size_enabled = ( enable_auto_pin_size == 1 ) ? true : false;
m_fasteners_enabled     = ( enable_fasteners     == 1 ) ? true : false;

// Leaf Parameters

m_hinge_width = hinge_width;
m_leaf_width  = hinge_width / 2.0;
m_leaf_height = leaf_height;
m_leaf_gauge  = leaf_gauge;

// Mechanical Properties

m_component_clearance  = component_clearance;
m_knuckle_outer_radius = leaf_gauge * 2.0;
m_knuckle_count        = knuckle_count;

// Pin Parameters

m_pin_diameter            = pin_diameter;
m_parametric_pin_diameter = ( pin_auto_size_enabled == true ) ? m_leaf_gauge : m_pin_diameter;

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
            workpiece_leaf_knuckle_pin ( gender );   
            
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
    
    w = m_leaf_width;
    l = m_leaf_height;
    h = m_leaf_gauge;
    r = m_leaf_fillet_radius;
    d = m_knuckle_outer_radius;
    
    // Create workpiece.
    
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
            }
        }
        
        // Cutting tool.
        
        tool_cutter_knuckles ( gender  );
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
// - Cutting tool used to cut knuckle features out of the knuckle workpiece.
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
        
        g = ( gender == 0 ) ? k + c : 0;
        
        // Compute relative origin.
        
        o = h/2.0;
        s = 2.0*e;    
        
        // Compute translation.
        
        tx = -(s + c)/2;
        ty = -o + g + si - c;
        tz = -(s + c)/2;
        
        // Compute size.
        
        dx = s + c;
        dy = k + 2*c;
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

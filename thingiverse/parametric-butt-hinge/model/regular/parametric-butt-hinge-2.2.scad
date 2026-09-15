// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Title:        Parametric Butt Hinge
// Version:      2.2
// Release Date: 2017-03-24
// Author:       Rohin Gosling
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Constants.
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

C_CONSTANT = 0 + 0;             // This is used to create a null variable, that can be added to other variables to supress linkging with Thingiverse.
C_FEMALE   = C_CONSTANT + 0;
C_MALE     = C_CONSTANT + 1;

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Parameters. ( Formatted for Thingiverse )
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

// Options.

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

// Leaf parameters.

hinge_width        = 60;
leaf_width         = hinge_width / 2;
leaf_height        = 60;
// Leaf and knuckle thickness.
leaf_gauge         = 5;

// Mechanical properties.

// Recomended values are between 0.2 and 0.3.
component_clearance  = 0.3;
knuckle_outer_radius = leaf_gauge * 2;
knuckle_count        = 5;               // [3,5,7,9,11,13,15]  

// Pin parameters.

// Manual pin diamter seting. This will only have an effect, if "Enable Auto Pin Size" is set to "No".
pin_diameter            = 4;
parametric_pin_diameter = ( pin_auto_size_enabled == true ) ? leaf_gauge : pin_diameter;

// Fastener holes.

// For countersunk, the chamfer angle may be adjusted using the other parameters.
fstener_head_type                = 0;   // [ 0:Counterbored, 1:Countersunk ]
counter_sink_depth               = 2.5;
fastener_thread_diameter         = 3;
// Add 0.5mm to 1.0mm to the fastener head diameter, to alow for head clearance. 
fastener_head_diameter           = 7;
fastener_count                   = 3;
fastener_margin                  = 3;
leaf_fillet_radius               = fastener_head_diameter/2 + fastener_margin;

// Program options.

// Recomended value is 64 or greater.
resolution      = 128;
$fn             = resolution;
component_color = "Silver";

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Console Output. 
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

echo ( obsolute_pin_diameter = parametric_pin_diameter - component_clearance/2 );

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Main module.
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

main();

module main ()
{   
    if ( female_leaf_enabled ) leaf ( C_FEMALE ); 
    if ( male_leaf_enabled )   leaf ( C_MALE );    
}

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Component: Leaf.
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module leaf ( gender )
{  
    gender_angle = ( gender == C_FEMALE ) ? 0 : 180;
    
    rotate ( [ 0, 0, gender_angle ] )
    {
        color ( component_color )
        difference ()
        {
            workpiece_leaf_knuckle_pin ( gender );        
            if ( fasteners_enabled ) tool_cutter_fastener_set ( fastener_count, 0 );
        }
    }
}

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Workpiece: Adding a pin to the leaf and knuckle.
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module workpiece_leaf_knuckle_pin ( gender )
{    
    d = parametric_pin_diameter;
    c = component_clearance;
    t = 0.01;                       // Small tolerance to prevent SCG surface interferance. 
    
    if ( gender == C_FEMALE )
    {   
        union ()
        {                           
            dc = d - c/2;
            
            workpiece_leaf_knuckle ( C_FEMALE );            
            Pin ( dc, leaf_height - t );
        }
    }
    else
    {
        difference ()
        {   
            dc = d + c/2;            
            
            workpiece_leaf_knuckle ( C_MALE );            
            Pin ( dc, leaf_height + t );
        }
    }
}

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Component: Hinge Pin.
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module Pin ( diameter, length )
{   
    rotate ( [ 90, 0, 0 ] )
    {   
        tx = 0;
        ty = 0;
        tz = -length/2;
        
        translate ( [ tx, ty, tz ] )
        {
            cylinder ( d = diameter, h = length );
        }
    }
}

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Workpiece: Cutting knuckles into the leaf and knucke workpiece.
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module workpiece_leaf_knuckle ( gender )
{
    knuckle_enabled = true;
    
    w = leaf_width;
    l = leaf_height;
    h = leaf_gauge;
    r = leaf_fillet_radius;
    d = knuckle_outer_radius;
    
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

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Workpiece: Base leaf structure, including uncut knuckle joint.
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module workpiece_leaf ( w, l, h, r )
{
    translate ( [ 0, 0, -h ] )
    {   
        union ()
        {
            if ( leaf_fillet_enabled )
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

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Cuting Tool: Knuckle cutter.
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module tool_cutter_knuckles ( gender )
{
    // Tool parameters.
    
    n = knuckle_count;
    h = leaf_height;
    c = component_clearance;
    
    // Compute absolute knuckle height, k.
    
    k = ( h - n*c + c ) / n;
    
    // Generate tool parts.

    a = 0;
    b = ( gender == 0 ) ? n/2-1 : n/2;
    
    for ( i = [ a : b ] )
    {
        // Knuckle segment increment.
        
        si = 2*i*( k + c );
        
        g = ( gender == 0 ) ? k + c : 0;
        
        // Relative origin.
        
        o = leaf_height/2;
        s = 2*leaf_gauge;    
        
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

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Cuting Tool: Fastener cutter.
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module tool_cutter_fastener ( z_offset,  )
{
    offcut = 1;
    id     = fastener_thread_diameter;              // Inner diamater.
    od     = fastener_head_diameter;                // Outer diameter.
    t      = fstener_head_type;                     // 0 = Fillister (Pan head), 1 = flat countersunk.
    d      = counter_sink_depth;                    // Depth of head counter sink.
    z0     = z_offset - ( leaf_gauge + offcut );    // Vertical position of head.
    z1     = z_offset - counter_sink_depth;         // Vertical position of thread.
    h0     = leaf_gauge + offcut;                   // Height of head.
    h1     = counter_sink_depth + offcut;           // Height of thread.
    
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

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Cuting Tool: Fastener cutter array.
// 
// An array of fastener cutting tools, to be used as a single cutting tool unit.
//
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module tool_cutter_fastener_set ( fastener_count, z_offset )
{
    // Relative origin.
    
    xo = leaf_gauge + component_clearance/2 + fastener_head_diameter/2 + fastener_margin;
    yo = -leaf_height/2 + fastener_head_diameter/2 + fastener_margin;
    
    // Column offsets.
    
    col0 = 0;
    col1 = leaf_width - fastener_head_diameter/2 - fastener_margin - xo;
    
    // Loop configuration.
    
    even = ( fastener_count % 2 ) ? false : true;
    n    = round ( fastener_count / 2 ) - 1;    
    k    = ( leaf_height - fastener_head_diameter - 2*fastener_margin ) / n;
            
    // Generate fastener cutting tool.
    
    for ( col = [ 0 : 1 ] )
    {  
        // Column 0, offset translation when we have an odd number of fasteners.
        
        if ( col == 0 )
        {
            m = ( even ) ? 0 : 1;
            
            for ( row = [ 0 : n - m ] )
            {        
                cx = ( col == 0 ) ? col0 : col1;
                tx = xo + cx;
                ty = ( even ) ? yo + row * k : yo + row * k + k/2;
                tz = 0;                
                                
                translate ( [ tx, ty, tz ] ) tool_cutter_fastener ( z_offset );
            }
        }
        
        // Column 1.
        
        if ( col == 1 )
        {
            for ( row = [ 0 : n ] )
            {        
                cx = ( col == 0 ) ? col0 : col1;
                tx = xo + cx;
                ty = yo + row * k;
                tz = 0;                
                
                translate ( [ tx, ty, tz ] ) tool_cutter_fastener ( z_offset );
            }
        }        
        
    }
}








// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Title:        Sinusoidal Spur Gear
// Version:      1.0
// Release Date: 2017-06-05 (ISO)
// Author:       Rohin Gosling
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
//
// Description:
//
// - Sinusoidal spur gear.
//
// Release Notes:
//
// - Version 1.0
//   * Model created.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Constants:
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

// System constants.

C_CONSTANT = 0 + 0;     // Used to hide constant values from Thingiverse. Add to other constants to hide them as well.

// General constants.

C_NONE = C_CONSTANT + 0;

// SCG constants.

SCG_OVERLAP = C_CONSTANT + 0.01;    // Used for overlapping Boolean operations in order to avoid Boolean edge artefacts.

// Minimum and maximum constraints.

C_RESOLUTION_MIN = C_CONSTANT + 16;
C_RESOLUTION_MAX = C_CONSTANT + 256;

// Temp

C_N = 18+6;


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

/* [Assembly Options] */

resolution                   = 64;
component_color              = "white";

/* [Object Parameters] */


// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Model parameters and geometric constraints. (Class member variables).
//
// - If we treat an OpenSCAD file as though it is an object oriented class, then we can prefix global variables
//   with "m_", to denote class membership. 
//   - As an alternative to "m_", we could also use "this_" as a standard. However, "m_" is shorter and faster to type.
//   - Another advantage of this convention, is that we can arrange parameters meant for display in Thingiverse, in 
//     an order that makes sense to the user, while arranging the member versions of the parameters in an order
//     that better accommodates constraint computation.
//
// - Once we have defined global variables as member variables of a class, in this case the class represented
//   by the SCAD file, then we are free to better manage global vs local scope of class member 
//   variables, vs. local module (method) variables.
//
// - Thingiverse only integrates constant literal values. So as long as we reference other parameters or 
//   initialize variables as expressions, then none of these will appear in the Thingiverse customizer.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

// Assembly Options.

m_resolution               = clip ( resolution, C_RESOLUTION_MIN, C_RESOLUTION_MAX );
m_component_color          = component_color;

// Object Parameters




// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// DEBUG: Console Output. 
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

C_DEBUG_ENABLED = false;

if ( C_DEBUG_ENABLED )
{
    //echo ( m_x = m_x ); 
}

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
    
    // Generate hinge assembly.
    
    assembly ();
    
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      assembly_main
// Module Type: Assembly
//
// Description:
//
// - Main component assembly.
//
// Parameters:
//
// - N/A
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module assembly ()
{
    color ( m_component_color );
       
    center_distance = 43;
    twist           = 0;
    to              = 0;
    ta              = $t*180;
    
    translate ( [ -center_distance/2, 0, 0 ] ) rotate ( [ 0, 0,   to + ta ] )                  color ( "lightblue" ) component_gear (  twist );
    translate ( [  center_distance/2, 0, 0 ] ) rotate ( [ 0, 0, -(to + ta) + (360/(2*C_N)) ] ) color ( "pink" )      component_gear ( -twist );    
}

//--------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module:      Gear
// Module Type: Component.
//
// Description:
//
// - Creates a gear object.
//
// Parameters:
//
// - xyz:
//   ...
//
//--------------------------------------------------------------------------------------------------------------------------------------------------------------

module component_gear ( twist )
{
    rc     = 0.05;
    c      = 0.5;
    d      = 40 - 2*rc;
    m      = 0.925*d - 2*rc;
    n      = C_N;
    g      = 4;    
    k      = C_N*32;
    slices = 1;

   
    dm        = d - m;
    clearence = 0.05;
    
    // Wole parameters.
    
    dr = 4.2;
        
    union ()
    {
        difference()
        {
            
            union ()
            {     
                // Gear profile.
                
                ri = ( d - dm )/2 + clearence;
                
                linear_extrude ( height = g, twist = twist, slices = slices, center = true )
                profile_polar_sinoid ( pitch_diameter = d, major_diameter = m, tooth_count = n, gauge = g, tessellation = k );            
                
                // Add Root. 
                
                cylinder ( h = g, r1 = ri + 10*clearence, r2 = ri + 10*clearence, center = true );
                
                // Add rim
                
                translate ( [ 0, 0, 1 ] ) cylinder ( h = g, r1 = ri - dm, r2 = ri - dm, center = true );                
            }
                    
            // Subtract landings
            
            difference ()
            {
                ro = ( d + dm )/2 + c;
                ri = ( d + dm )/2 - clearence - c;
               
                cylinder ( h = g*2, r1 = ro, r2 = ro, center = true );
                cylinder ( h = g*3, r1 = ri, r2 = ri, center = true );
            }   

            ri = ( d - 4*dm )/2;
            cylinder ( h = g*2, r1 = ri, r2 = ri, center = true );
            
            // Subtract root cuts
            
            n   = 18+6;
            sr  = 3.0/2.0 + 0.1;
            sri = 360/n;
            for ( i = [ 0 : n - 1 ] )
            {
                rotate ( [ 0, 0, i*sri ] )
                translate ( [ 0, 20.5, 0 ] ) 
                linear_extrude ( height = 10*g, slices = 1, center = true ) rectangle ( 1.5, 3.8, center = true );
            }
        }
        
        // Add wheel.
        
        difference ()
        {
            // Wheel.
            
            union ()
            {
                ri = ( d - dm )/2;
                hw = 2;
                //translate ( [ 0, 0, -hw/2 ] ) cylinder ( h = g-hw-0.01, r1 = ri - dm, r2 = ri - dm, center = true );
                
                // Add stand-off.
                    
                translate ( [ 0, 0, 0.5 ] ) cylinder ( h = g+1, r1 = dr + 2, r2 = dr + 2, center = true );
                
                // Add spokes
                
                n = 3;
                for ( i = [ 0 : n - 1 ] )
                {
                    rotate ( [ 0, 0, i*360/n ] )
                    translate ( [ 0, 10, 0 ] ) 
                    linear_extrude ( height = g, slices = 1, center = true ) rectangle ( 3, 10, center = true );
                }
            }
            
            // Center hole.
            
            hr = dr/2;            
            cylinder ( h = g+3, r1 = hr, r2 = hr, center = true );
            
            echo ( hr = hr );
        }
    }
}

//--------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module:      polar_sinoid.
// Module Type: 2D Profile.
//
// Description:
//
// - Creates a polar sinoid object.
//
// Parameters:
//
// - xyz:
//   ...
//
//--------------------------------------------------------------------------------------------------------------------------------------------------------------

module profile_polar_sinoid ( pitch_diameter, major_diameter, tooth_count, gauge, tessellation )
{    
    // Clip parameters and initialize local variables.
    
    r = pitch_diameter/2.0;
    m = major_diameter/2.0;
    n = tooth_count;
    g = gauge;
    k = tessellation;
    
    // Generate 2D geometry
    
    t = 0;      // Point index. Initialize to zero.    
    v = [];     // Empty vector from which to recursively build output vectors.
    
    points = polar_sinoid_function ( r, m, n, k, t, v );
    
    // Compile index sequence.
    
    indices = [ index_vector ( k + 1, t, v ) ];    
    
    // Generate 3D object.
    
    polygon ( points, indices );
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
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
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module fillet_rectangle ( w, h, r, center )
{
    xs = w - 2.0*r;
    ys = h - 2.0*r;
    xd = w/2.0 - r;  
    yd = h/2.0 - r;    
    
    union ()
    {
        scale ( [ xs, h  ] ) square ( size = 1.0, center = center );
        scale ( [ w,  ys ] ) square ( size = 1.0, center = center );
        translate ( [  xd,  yd ] ) circle ( r = r, center = center );
        translate ( [  xd, -yd ] ) circle ( r = r, center = center );
        translate ( [ -xd, -yd ] ) circle ( r = r, center = center );
        translate ( [ -xd,  yd ] ) circle ( r = r, center = center );
    }
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
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
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module rectangle ( w, h, center )
{
    scale ( [ w, h ] ) square ( size = 1.0, center = center );
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
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
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

function clip ( x, x_min, x_max ) = ( x < x_min ) ? x_min : ( x > x_max ) ? x_max : x;

//--------------------------------------------------------------------------------------------------------------------------------------------------------------
// Function: Polar Sinoid Function
//
// Description:
//
// - Recursive function to generate an array of 2D points on a polar sinoid curve.
//
// Parameters:
//
// - t
//   Input angle.
//
// - d
//   Pitch circle diameter.
//
// - m
//   Major diameter.
//
// - n
//   Number of teath.
//
// - k
//   Tessellation factor. Initialize to the number of polar segments.
//
// - t
//   Point index. Initialize to zero.
//
// - v
//   Vector that will be populated with geometry points. Initialize to empty vector, [].
//
//--------------------------------------------------------------------------------------------------------------------------------------------------------------

function polar_sinoid_function ( r, m, n, k, t, v ) =
(
    t > 360

    // Recursive terminating condition:
    //
    //   Return an empty vector.

    ? concat ( v, [] )

    // Recursive general condition:
    //   
    //   p = ( r + ( m - r )·cos ( n·t ) )  ...Where, r is the pitch circle radius, m is the major diameter, and n is the tooth count.  
    //   x = p·cos ( t + 2π/k )             ...Where, k is the tesselation factor, t is the arc angle, and p is the gear profile.
    //   y = p·sin ( t + 2π/k )             ...Where, k is the tesselation factor, t is the arc angle, and p is the gear profile.
    
    : polar_sinoid_function
    (
        r, m, n, k, t+360/k,
        concat
        (
            v,
            [[
                ( r + ( m - r )*cos ( n*t ) )*cos ( t ),
                ( r + ( m - r )*cos ( n*t ) )*sin ( t )
            ]]
        )
    )
);

//--------------------------------------------------------------------------------------------------------------------------------------------------------------
// Function: Generate and index vector.
//
// Description:
//
// - Recursive function that generates an n dimensional vector of integers, in the range [0..n-1].
//
// Parameters:
//
// - n
//   Number of elements in the vector.
//
// - i
//   Element index. Initialize to zero.
//
// - v
//   Vector to be populated with sequence. Initialize with an empty vector, [].
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
//
//--------------------------------------------------------------------------------------------------------------------------------------------------------------

function index_vector ( n, i, v ) =
(
    i >= n
    
    // Recursive terminating condition:
    //   Just return the input vector unchanged.
    
    ? v
    
    // Recursive general condition:
    //   Add the next index to the input vector.
    
    : index_vector  ( n, i + 1, concat ( v, [ i ] ) )
);

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
// - y
//   Argument y description.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      module_name
// Module Type: [ 2D Shape, Profile, Tool, Workpiece, Component ] 
// Description:
//
// - Module description.
//
// Parameters:
//
// - x
//   Argument x description.
//
// - y
//   Argument y description.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------


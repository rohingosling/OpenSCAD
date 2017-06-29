// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Title:        Box
// Version:      1.0
// Release Date: 2017-06-05 (ISO)
// Author:       Rohin Gosling
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
//
// Description:
//
// - Simple box and lid.
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

resolution                   = 128;
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
    xs = w - 2*r;
    ys = h - 2*r;
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


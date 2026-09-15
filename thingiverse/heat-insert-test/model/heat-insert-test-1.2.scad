// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Title:        Heat Insert Test Plate
// Version:      1.2
// Release Date: 2017-06-03 (ISO)
// Author:       Rohin Gosling
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
//
// Description:
//
// - Test plate filled with holes to test insert sizing and practice assembing heat inserts.
//
// Release Notes:
//
// - Version 1.2
//   * Fixed bug, where positive text relief is too thin, because the Thingiverse Customizer does not support bold font styles.
//     To get arround this, the text is created multiple times using a nested 2D loop, so that the text is placed with a slight offset 
//     on a grid, which simulates the effect of bold font, as the expence of polygon count.
//   * Disabled positive text relief, due to printer resolution.
//     May add positive text relief again in the future, along with aditional font managment paramteres to better
//     printing small detailed features like text.
//   * Fixed the note pannel text alignment.
//     Note pannel text is now aligne to work piece origin, rather than global axis origin.
//
// - Version 1.1
//   * Fixed bug, where positive text relief would result in the text remaining when the information panels were disabled.
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

SCG_OVERLAP = C_CONSTANT + 0.01;    // Used for overlapping Boolean operations in order to avoid Boolean boundary artefacts.

// Geometry constants.

C_NOTE_PANEL_HEIGHT_SCALE = C_CONSTANT + 0.6;
C_TEXT_PANEL_WIDTH        = C_CONSTANT + 16.0;
C_TEXT_PANEL_THICKNESS    = C_CONSTANT + 3.0;

// Text constants.

C_TEXT_NEGATIVE  = C_CONSTANT + 0;
C_TEXT_POSITIVE  = C_CONSTANT + 1;
C_TEXT_DEPTH     = C_CONSTANT + 1.5;
C_TEXT_FONT_SIZE = C_CONSTANT + 4.2;

// Minimum and maximum constraints.

C_RESOLUTION_MIN                  = C_CONSTANT + 16;
C_RESOLUTION_MAX                  = C_CONSTANT + 256;
C_FILLET_RADIUS_MIN               = C_CONSTANT + 0.0;
C_FILLET_RADIUS_MAX               = C_CONSTANT + 50.0;
C_HEAT_INSERT_LENGHT_MIN          = C_CONSTANT + 1.0;
C_HEAT_INSERT_LENGHT_MAX          = C_CONSTANT + 50.0;
C_HEAT_INSERT_OUTER_DIAMTER_MIN   = C_CONSTANT + 1.0;
C_HEAT_INSERT_OUTER_DIAMTER_MAX   = C_CONSTANT + 50.0;
C_STANDOFF_HEIGHT_MIN             = C_CONSTANT + 0.1;
C_STANDOFF_HEIGHT_MAX             = C_CONSTANT + 50.0;
C_STANDOFF_WALL_THICKNESS_MIN     = C_CONSTANT + 1.0;
C_STANDOFF_WALL_THICKNESS_MAX     = C_CONSTANT + 10.0;
C_STANDOFF_DIAMETER_MIN           = C_CONSTANT + 1.0;
C_STANDOFF_DIAMETER_MAX           = C_CONSTANT + 60.0;
C_PILOT_HOLE_DIAMETER_MIN         = C_CONSTANT + 0.1;
C_PILOT_HOLE_DIAMETER_MAX         = C_CONSTANT + 50.0;
C_WORKPIECE_GRID_SPACING_MIN      = C_CONSTANT + 0.0;
C_WORKPIECE_GRID_SPACING_MAX      = C_CONSTANT + 50.0;
C_WORKPIECE_THICKNESS_MIN         = C_CONSTANT + 3.0;
C_WORKPIECE_THICKNESS_MAX         = C_CONSTANT + 60.0;
C_WORKPIECE_FILLET_RADIUS_MIN     = C_CONSTANT + 1.0;
C_WORKPIECE_FILLET_RADIUS_MAX     = C_CONSTANT + 70.0;
C_WORKPIECE_MARGIN_MIN            = C_CONSTANT + 1.0;
C_WORKPIECE_MARGIN_MAX            = C_CONSTANT + 10.0;
C_TEST_COLUMN_COUNT_MIN           = C_CONSTANT + 1;
C_TEST_COLUMN_COUNT_MAX           = C_CONSTANT + 10.0;
C_TEST_INCREMENT_MIN              = C_CONSTANT + 0.0;
C_TEST_INCREMENT_MAX              = C_CONSTANT + 0.2;
C_TEST_INCREMENT_RANGE_MIN        = C_CONSTANT + 0;
C_TEST_INCREMENT_RANGE_MAX        = C_CONSTANT + 5;
C_TEST_INCREMENT_RANGE_OFFSET_MIN = C_CONSTANT + -10;
C_TEST_INCREMENT_RANGE_OFFSET_MAX = C_CONSTANT +  10;
C_TEXT_DEPTH_MIN                  = C_CONSTANT + 0.15;
C_TEXT_DEPTH_MAX                  = C_CONSTANT + 3.0;

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

enable_standoffs             = 1;             // [ 0:No, 1:Yes ]
enable_pilot_hole            = 1;             // [ 0:No, 1:Yes ]
enable_workpiece_fillet      = 1;             // [ 0:No, 1:Yes ]
enable_size_lables           = 1;             // [ 0:No, 1:Yes ]
enable_increment_lables      = 1;             // [ 0:No, 1:Yes ]
enable_note_panel            = 1;             // [ 0:No, 1:Yes ]
//text_relief                  = 1;             // [ 0:Negative, 1:Positive ]
resolution                   = 128;
component_color              = "silver";

/* [Test Parameters] */

heat_insert_length          = 3.0;
heat_insert_outer_diameter  = 4.0;
test_column_count           = 2;
test_increment_range        = 3;
test_increment              = 0.1;
test_increment_range_offset = 0;

/* [Workpiece Parameters] */

standoff_height         = 1.5;
standoff_wall_thickness = 2.0;
pilot_hole_diameter     = 2.5;
workpiece_grid_spacing  = 10.0;
workpiece_thickness     = 4.5;
workpiece_fillet_radius = 3.0;
workpiece_margin        = 2.0;
note                    = "Heat Insert Test";

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

m_standoffs_enabled        = ( enable_standoffs        == 1 ) ? true : false;
m_pilot_hole_enabled       = ( enable_pilot_hole       == 1 ) ? true : false;
m_workpiece_fillet_enabled = ( enable_workpiece_fillet == 1 ) ? true : false;
m_size_lables_enabled      = ( enable_size_lables      == 1 ) ? true : false;
m_increment_lables_enabled = ( enable_increment_lables == 1 ) ? true : false;
m_note_panel_enabbled      = ( enable_note_panel       == 1 ) ? true : false;
m_text_relief              = 0; //clip ( text_relief, 0, 1 );
m_resolution               = clip ( resolution, C_RESOLUTION_MIN, C_RESOLUTION_MAX );
m_component_color          = component_color;

// Heat Insert Parameters

m_heat_insert_length          = clip ( heat_insert_length,         C_HEAT_INSERT_LENGHT_MIN,        C_HEAT_INSERT_LENGHT_MAX        );
m_heat_insert_outer_diameter  = clip ( heat_insert_outer_diameter, C_HEAT_INSERT_OUTER_DIAMTER_MIN, C_HEAT_INSERT_OUTER_DIAMTER_MAX );

// Workpiece Parameters

m_standoff_height         = clip ( standoff_height,         C_STANDOFF_HEIGHT_MIN,         C_STANDOFF_HEIGHT_MAX         );
m_standoff_wall_thickness = clip ( standoff_wall_thickness, C_STANDOFF_WALL_THICKNESS_MIN, C_STANDOFF_WALL_THICKNESS_MAX );
m_standoff_diameter       = m_heat_insert_outer_diameter + 2.0*standoff_wall_thickness;
m_pilot_hole_diameter     = clip ( pilot_hole_diameter,     C_PILOT_HOLE_DIAMETER_MIN,     C_PILOT_HOLE_DIAMETER_MAX     );
m_workpiece_grid_spacing  = clip ( workpiece_grid_spacing,  C_WORKPIECE_GRID_SPACING_MIN,  C_WORKPIECE_GRID_SPACING_MAX  );
m_workpiece_thickness     = clip ( workpiece_thickness,     C_WORKPIECE_THICKNESS_MIN,     C_WORKPIECE_THICKNESS_MAX     );
m_workpiece_fillet_radius = clip ( workpiece_fillet_radius, C_WORKPIECE_FILLET_RADIUS_MIN, C_WORKPIECE_FILLET_RADIUS_MAX );
m_workpiece_margin        = clip ( workpiece_margin,        C_WORKPIECE_MARGIN_MIN,        C_WORKPIECE_MARGIN_MAX        );

// Test Parameters

m_test_column_count           = clip ( test_column_count,           C_TEST_COLUMN_COUNT_MIN,           C_TEST_COLUMN_COUNT_MAX           );
m_test_increment              = clip ( test_increment,              C_TEST_INCREMENT_MIN,              C_TEST_INCREMENT_MAX              );
m_test_increment_range        = clip ( test_increment_range,        C_TEST_INCREMENT_RANGE_MIN,        C_TEST_INCREMENT_RANGE_MAX        );
m_test_increment_range_offset = clip ( test_increment_range_offset, C_TEST_INCREMENT_RANGE_OFFSET_MIN, C_TEST_INCREMENT_RANGE_OFFSET_MAX );

// Text Parameters

m_text_depth           = clip ( C_TEXT_DEPTH, C_TEXT_DEPTH_MIN, C_TEXT_DEPTH_MAX );
m_text_panel_thickness = clip ( C_TEXT_PANEL_THICKNESS, 3.0, 4.0 );
m_text_panel_width     = clip ( C_TEXT_PANEL_WIDTH, 10.0, 30 );
m_text_note            = note;


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
    color ( m_component_color )
    difference ()    
    {
        union ()
        {
            workpiece_panel ();
            if ( m_standoffs_enabled )
            {
                tool_adder_standoff_array ();
            }
            
            if ( m_text_relief == C_TEXT_POSITIVE ) tool_cutter_text_labels ();
        }
        
        tool_cutter_heat_insert_hole_array ();
        
        if ( m_text_relief == C_TEXT_NEGATIVE ) tool_cutter_text_labels ();
    }
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      tool_cutter_text_labels.
// Module Type: Cutting Tool.
//
// Description:
//
// - Data label array.
//
// Parameters:
//
// - N/A
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module tool_cutter_text_labels ()
{   
    // Retrieve parameters.
    
    diameter            = ( m_standoffs_enabled ) ? m_standoff_diameter : m_heat_insert_outer_diameter;
    grid_spacing        = m_workpiece_grid_spacing;
    margin              = m_workpiece_margin;
    col_count           = ( m_test_column_count < 1 ) ? 1 : m_test_column_count;
    row_count           = ( m_test_increment_range < 0 ) ? 0 :  2*m_test_increment_range + 1;    
    font_size           = C_TEXT_FONT_SIZE;
    data_diameter       = m_heat_insert_outer_diameter - m_test_increment_range*m_test_increment;
    data_delta          = - m_test_increment_range*m_test_increment;
    data_diameter_delta = m_test_increment;
    i_offset            = m_test_increment_range_offset;
    
    // Compute panel dimentions.
    
    width             = grid_spacing*( col_count - 1 ) + diameter + 2.0*margin;
    height            = grid_spacing*( row_count - 1 ) + diameter + 2.0*margin;
    height_note_panel = C_NOTE_PANEL_HEIGHT_SCALE * m_text_panel_width;
    
    // Compute grid origin.
    
    xo_right =  ( width + m_text_panel_width )/2.0;
    xo_left  = -( width + m_text_panel_width )/2.0;
    yo       = -( height - diameter )/2.0 + margin;
    
    // Create label array.
    
    for ( iy = [ 0 : row_count - 1 ] )
    {           
        xd_right      = xo_right;
        xd_left       = xo_left;
        yd            = yo + iy*grid_spacing;
        data_size     = data_diameter + ( iy + i_offset )*data_diameter_delta;
        data_incrment = data_delta    + ( iy + i_offset )*data_diameter_delta;
                
        if ( m_size_lables_enabled )      translate ( [ xd_left,  yd, 0.0 ] ) tool_cutter_text ( str ( data_size ),     font_size );
        if ( m_increment_lables_enabled ) translate ( [ xd_right, yd, 0.0 ] ) tool_cutter_text ( str ( data_incrment ), font_size );
    }
    
    // Create note.
        
    half_width = C_TEXT_PANEL_WIDTH + m_heat_insert_outer_diameter + m_standoff_diameter;    
    xo         = ( half_width/2 + m_workpiece_margin )/2;    

    if ( m_note_panel_enabbled )
    {
        if      ( !m_size_lables_enabled && !m_increment_lables_enabled ) translate ( [ 0.0, ( height + height_note_panel )/2.0, 0.0 ] ) tool_cutter_text ( m_text_note, font_size );
        else if (  m_size_lables_enabled &&  m_increment_lables_enabled ) translate ( [ 0.0, ( height + height_note_panel )/2.0, 0.0 ] ) tool_cutter_text ( m_text_note, font_size );
        else if (  m_size_lables_enabled && !m_increment_lables_enabled ) translate ( [ -xo, ( height + height_note_panel )/2.0, 0.0 ] ) tool_cutter_text ( m_text_note, font_size );
        else if ( !m_size_lables_enabled &&  m_increment_lables_enabled ) translate ( [  xo, ( height + height_note_panel )/2.0, 0.0 ] ) tool_cutter_text ( m_text_note, font_size );
    }
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      tool_cutter_text.
// Module Type: Cutting Tool.
//
// Description:
//
// - Inscribes a string of text onto a surface.
//
// Parameters:
//
// - string:
//   The string of text we would like to inscribes.
//
// - size:
//   The size of the font.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module tool_cutter_text ( string, size )
{   
    // create text cutter.

    //font   = "Ariel:style=Bold";
    font   = "Ariel";
    height = m_text_depth + SCG_OVERLAP;    
    zd     = height/2.0 + m_text_panel_thickness - m_text_depth;
    
    n   = 3;
    si  = 0.2;
    nx  = n;
    ny  = n;
    siy = si;
    six = si;
    oix = round ( -six*nx/2.0 );
    oiy = round ( -siy*ny/2.0 );
    
    translate ( [ 0.0, 0.0, zd ] )
    {
        linear_extrude ( height = height )
        {
            // We create a nested 2D loop to place many instances of the text, in order to simulate
            // bold font, since Thingiverse Customizer does not support font styles.
            
            for ( iy = [ 0 : ny-1 ] )
                for ( ix = [ 0 : nx-1 ] )
                {
                    xd = oix + six*ix;
                    xd = oiy + siy*iy;
                    translate ( [ xd, 0.0, zd ] ) text ( string, font = font, size = size, valign = "center", halign = "center" );
                }  
        }
    }
}


// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      workpiece_panel
// Module Type: Workpiece
//
// Description:
//
// - Main panel workpiece.
// - The heat insert holes and labels are cut into this pannel.
//
// Parameters:
//
// - N/A
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module workpiece_panel ()
{
    // Retrieve parameters.
    
    diameter      = ( m_standoffs_enabled ) ? m_standoff_diameter : m_heat_insert_outer_diameter;    
    grid_spacing  = m_workpiece_grid_spacing;
    margin        = m_workpiece_margin;
    col_count     = ( m_test_column_count < 1 ) ? 1 : m_test_column_count;
    row_count     = ( m_test_increment_range < 0 ) ? 0 :  2*m_test_increment_range + 1;
    fillet_radius = m_workpiece_fillet_radius;
    thickness     = m_workpiece_thickness;    
    
    // Compute panel dimentions.
    
    width  = grid_spacing*( col_count - 1 ) + diameter + 2.0*margin;
    height = grid_spacing*( row_count - 1 ) + diameter + 2.0*margin;
    
    width_size_lables      = m_text_panel_width;
    width_increment_lables = m_text_panel_width;
    width_note_panel_scale = ( m_size_lables_enabled && m_increment_lables_enabled ) ? 2.0 : ( m_size_lables_enabled || m_increment_lables_enabled ) ? 1.0 : 0.0;
    width_note_panel       = width + width_note_panel_scale*m_text_panel_width;
    height_note_panel      = C_NOTE_PANEL_HEIGHT_SCALE * m_text_panel_width;
    label_panel_height     = m_text_panel_thickness;    
    
    // Compute label panel offests.
    
    yd_note_panel        = ( height + height_note_panel )/2.0;
    xd_note_panel_factor = width_size_lables/2.0; 
    xd_note_panel        = ( !m_size_lables_enabled && m_increment_lables_enabled ) ? xd_note_panel_factor : ( m_size_lables_enabled && !m_increment_lables_enabled ) ? -xd_note_panel_factor : 0.0;
    xd_size_labels       =  ( width + width_size_lables      )/2.0;    
    xd_increment_labels  = -( width + width_increment_lables )/2.0;
    
    // Create panel object.
   
    union ()
    {
        // Workpiece.
        
        if ( m_workpiece_fillet_enabled )
        {
            linear_extrude ( height = thickness ) fillet_rectangle ( w = width, h = height, r = fillet_radius, center = true );
        }
        else
        {
            linear_extrude ( height = thickness ) rectangle ( w = width, h = height, center = true );
        }
        
        // Note panel.
        
        if ( m_note_panel_enabbled )
        {
            linear_extrude ( height = label_panel_height )
            {
                translate ( [ xd_note_panel, yd_note_panel, 0.0 ] )
                {
                    if ( m_workpiece_fillet_enabled )
                    {
                        fillet_rectangle ( w = width_note_panel, h = height_note_panel, r = fillet_radius, center = true );
                    }
                    else
                    {
                        rectangle ( w = width_note_panel, h = height_note_panel, center = true );
                    }
                }
            }
        }
        
        // Increment labels.
        
        if ( m_increment_lables_enabled )
        {
            linear_extrude ( height = label_panel_height )
            {
                translate ( [ xd_size_labels, 0.0, 0.0 ] )
                {
                    if ( m_workpiece_fillet_enabled )
                    {
                        fillet_rectangle ( w = width_size_lables, h = height, r = fillet_radius, center = true );
                    }
                    else
                    {
                        rectangle ( w = width_size_lables, h = height, center = true );
                    }
                }
            }
        }
        
        // Size labels.
        
        if ( m_size_lables_enabled )
        {
            linear_extrude ( height = label_panel_height )
            {
                translate ( [ xd_increment_labels, 0.0, 0.0 ] )
                {
                    if ( m_workpiece_fillet_enabled )
                    {
                        fillet_rectangle ( w = width_increment_lables, h = height, r = fillet_radius, center = true );
                    }
                    else
                    {
                        rectangle ( w = width_size_lables, h = height, center = true );
                    }
                }
            }
        }
    }
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      tool_adder_standoff_array
// Module Type: Adding Tool
//
// Description:
//
// - Creates a 2D array of standoffs
//
// Parameters:
//
// - N/A
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module tool_adder_standoff_array ()
{
    // Retrieve parameters.
    
    diameter        = m_standoff_diameter;
    radius          = diameter/2.0;
    grid_spacing    = m_workpiece_grid_spacing;
    margin          = m_workpiece_margin;
    col_count       = ( m_test_column_count < 1 ) ? 1 : m_test_column_count;
    row_count       = ( m_test_increment_range < 0 ) ? 0 :  2*m_test_increment_range + 1;    
    standoff_height = m_standoff_height + m_workpiece_thickness;
    i_offset        = m_test_increment_range_offset;
    
    // Compute panel dimentions.
    
    width  = grid_spacing*( col_count - 1 ) + diameter + 2.0*margin;
    height = grid_spacing*( row_count - 1 ) + diameter + 2.0*margin;
    
    // Compute grid origin.
    
    xo = -(  width - diameter )/2.0 + margin;
    yo = -( height - diameter )/2.0 + margin;
    zo = standoff_height/2.0;
    
    // Create heat insert hole array object.
    
    for ( iy = [ 0 : row_count - 1 ] )
    {
        for ( ix = [ 0 : col_count - 1 ] )    
        {
            xd = xo + ix*grid_spacing;
            yd = yo + iy*grid_spacing;
            rs = radius + ( iy + i_offset )*m_test_increment;
            translate ( [ xd, yd, zo ] ) cylinder ( h = standoff_height, r1 = rs, r2 = rs, center = true );
        }
    }
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      tool_cutter_heat_insert_holes
// Module Type: Cutting Tool
//
// Description:
//
// - Creates a 2D array of heat insert holes.
//
// Parameters:
//
// - N/A
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module tool_cutter_heat_insert_hole_array ()
{
    // Retrieve parameters.
    
    radius          = m_heat_insert_outer_diameter/2.0;
    diameter        = ( m_standoffs_enabled ) ? m_standoff_diameter : m_heat_insert_outer_diameter;    
    grid_spacing    = m_workpiece_grid_spacing;
    margin          = m_workpiece_margin;
    col_count       = ( m_test_column_count < 1 ) ? 1 : m_test_column_count;
    row_count       = ( m_test_increment_range < 0 ) ? 0 :  2*m_test_increment_range + 1;
    standoff_height = ( m_standoffs_enabled ) ? m_standoff_height : 0.0;
    i_offset        = m_test_increment_range_offset;
    
    // Compute panel dimentions.
    
    width  = grid_spacing*( col_count - 1 ) + diameter + 2.0*margin;
    height = grid_spacing*( row_count - 1 ) + diameter + 2.0*margin;
    
    // Compute grid origin.
    
    xo = -(  width - diameter )/2.0 + margin;
    yo = -( height - diameter )/2.0 + margin;
    zo = 0.0;
    
    // Create heat insert hole array object.
    
    for ( iy = [ 0 : row_count - 1 ] )
    {
        for ( ix = [ 0 : col_count - 1 ] )    
        {
            xd = xo + ix*grid_spacing;
            yd = yo + iy*grid_spacing;
            rs = radius + ( iy + i_offset )*m_test_increment - m_test_increment*m_test_increment_range;
            translate ( [ xd, yd, zo ] ) tool_cutter_heat_insert_hole ( radius = rs );            
        }
    }
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      tool_cutter_heat_insert_hole
// Module Type: Cutting Tool
//
// Description:
//
// - Creates a single heat insert cutting tool.
//
// Parameters:
//
// - N/A
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module tool_cutter_heat_insert_hole ( radius )
{   
    // Retrieve parameters.
        
    c               = SCG_OVERLAP;    
    c_height        = ( m_heat_insert_length >= m_workpiece_thickness ) ? 2.0*c : c;
    height          = m_heat_insert_length + c_height;
    standoff_height = ( m_standoffs_enabled ) ? m_standoff_height : 0.0;
    pilot_height    = m_workpiece_thickness + m_standoff_height + 2.0*c;
    pilot_radius    = m_pilot_hole_diameter/2.0;    
    
    // Compute translation.
    
    zd       = m_heat_insert_length/2.0 + m_workpiece_thickness - m_heat_insert_length + standoff_height;
    pilot_zd = pilot_height/2.0 - c;
    
    // Create heat insert array.
    
    union ()
    {
        translate ( [ 0.0, 0.0, zd ] ) cylinder ( h = height, r1 = radius, r2 = radius, center = true );
        
        if ( m_pilot_hole_enabled )
        {
            translate ( [ 0.0, 0.0, pilot_zd ] ) cylinder ( h = pilot_height, r1 = pilot_radius, r2 = pilot_radius, center = true );
        }
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


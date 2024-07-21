# OpenSCAD - 3D Printing Projects

## Parametric Butt Hinge
Thingiverse URL: [www.thingiverse.com/thing:2187167](https://www.thingiverse.com/thing:2187167)
### Gusset Parameters

Parabolic
![Image](images/parametric_hinge/Parabolic.PNG)

**Circular**

Initialize input values.

> $w = \text{Gusset width}$<br>
  $g = \text{Knuckle radius}$

Compute gusset radius. The radius of the circle, that is tangential to the knuckle cylinder.

> $r = \frac{2 \cdot g \cdot w \space + \space w^2}{2 \cdot g}$

Compute gusset height. The point of intersection between the knuckle cylinder and the gusset cutter.

h = ( g*r ) / sqrt ( g*g + 2.0*g*w + r*r + w*w )

Compute intersection point between the knuckle and gusset cutting tool, using gusset height.
The coordinate of the intersection point are, p(x,h), where h is the vertical value of the coordinate.

x = h*( g + w ) / r

![Image](images/parametric_hinge/Circular.PNG)

Linear
![Image](images/parametric_hinge/Linear.PNG)

None
![Image](images/parametric_hinge/None.PNG)

### Sample Prints
| ![Image](images/parametric_hinge/composite_1_0.PNG) | ![Image](images/parametric_hinge/photo_4_0.png) | ![Image](images/parametric_hinge/photo_1_0.png) |
| - | - | - |
| ![Image](images/parametric_hinge/composite_2_0.PNG) | ![Image](images/parametric_hinge/photo_3_0.png) | ![Image](images/parametric_hinge/photo_2_0.png) |







  

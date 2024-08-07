# OpenSCAD - 3D Printing Projects

## Caged Ball Bearing
Thingiverse URL: [www.thingiverse.com/thing:2224678](https://www.thingiverse.com/thing:2224678)

### Sample Prints
| ![Image](images/caged_ball_bearing/internal_1_0.png) | ![Image](images/caged_ball_bearing/internal_2_0.png) | ![Image](images/caged_ball_bearing/internal_3_0.png) | ![Image](images/caged_ball_bearing/internal_4_0.png) |
| - | - | - | - |
| ![Image](images/caged_ball_bearing/code_1_0.png) | ![Image](images/caged_ball_bearing/photo_1_0.png) | ![Image](images/caged_ball_bearing/photo_2_0.png) | ![Image](images/caged_ball_bearing/photo_3_0.png) |

## Parametric Butt Hinge
Thingiverse URL: [www.thingiverse.com/thing:2187167](https://www.thingiverse.com/thing:2187167)

### Sample Prints
| ![Image](images/parametric_hinge/model_2_0.png) | !![Image](images/parametric_hinge/model_3_0.png) | ![Image](images/parametric_hinge/model_1_0.png) | ![Image](images/parametric_hinge/model_4_0.png) |
| - | - | - | - |
| ![Image](images/parametric_hinge/photo_1_0.png) | ![Image](images/parametric_hinge/photo_2_0.png) | ![Image](images/parametric_hinge/photo_3_0.png) | ![Image](images/parametric_hinge/photo_4_0.png) |
| ![Image](images/parametric_hinge/sample_1_0.png) | ![Image](images/parametric_hinge/sample_2_0.png) | ![Image](images/parametric_hinge/sample_3_0.png) | ![Image](images/parametric_hinge/sample_4_0.png) |

### Gusset Parameters

#### Parabolic

- Input values.

$$w \quad \text{...Gusset width.}$$
  
$$h \quad \text{...Hinge leaf height.}$$

$$r \quad \text{...Knuckle radius is equal to the leaf gauge.}$$
 
$$g \quad \text{...Leafe gauge.}$$

- Compute the parabolic point of contact with the knuckle cylinder.

$$s = w \space + \space r \quad \text{...Cartesian position of the point where the gusset curve merges with the leaf.}$$

$$i = \sqrt { 8 \cdot r^2 + s^2 } \quad \text{...Common root.}$$

$$x = \dfrac{ i - s }{2} \quad \text{...x intercept.}$$

$$y = \sqrt { r^2 - x^2 } \quad \text{...y intercept.}$$

- Compute coefficient $a$ of vertex form parabola.

$$a_n = \sqrt[4]{ 2 } \cdot \sqrt[4]{ s \cdot ( i - s ) - 2 \cdot r^2 } \quad \text{...Numerator}.$$

$$a_d = \sqrt{ s \cdot ( 5 \cdot s - 3 \cdot i ) + 4 \cdot r^2 } \quad \text{...Denominator.}$$

$$a = \dfrac{a_n}{a_d}$$

$$y = a^2 \cdot ( x - s )^2$$


![Image](images/parametric_hinge/Parabolic.PNG)

#### Circular

- Input values:

$$w \quad \text{...Gusset width}$$

$$g \quad \text{...Knuckle radius}$$

- Compute gusset radius:<br>
  The radius of the circle, that is tangential to the knuckle cylinder.

$$r = \dfrac{ 2 \cdot g \cdot w \space + \space w^2}{ 2 \cdot g}$$

- Compute gusset height:<br>
  The point of intersection between the knuckle cylinder and the gusset cutter.

$$h = \dfrac{ g \cdot r }{ \sqrt{ 2 \cdot g \cdot w \space + \space g^2 \space + \space r^2 \space + \space w^2 } }$$

- Compute the intersection point between the knuckle and gusset cutting tool, using gusset height:<br>
  The coordinates of the intersection point are, $p(x,h)$, where $h$ is the vertical value of the coordinate.

$$x = \dfrac{ h \cdot ( g \space + \space w ) }{ r }$$

![Image](images/parametric_hinge/Circular.PNG)

#### Linear

- Input values.

$$w \quad \text{...Gusset width.}$$

$$h \quad \text{...Hinge leaf height.}$$

$$r \quad \text{...Knuckle radius is equal to the leaf gauge.}$$

$$r \quad \text{...Leafe gauge.}$$

- Compute gusset tangent gradient.

$$s = w + r \quad \text{...Cartesian position of the point where the gusset curve merges with the leaf.}$$

$$x = \dfrac{ r^2 }{ s }$$

$$y = \sqrt{ r^2 - x^2}$$

$$a = \dfrac{ y }{x - s}$$

$$b = -a \cdot s$$

![Image](images/parametric_hinge/Linear.PNG)

#### None

![Image](images/parametric_hinge/None.PNG)

## Parametric Test Block
Thingiverse URL: [www.thingiverse.com/thing:2224678](https://www.thingiverse.com/thing:2386923)

### Sample Prints
| ![Image](images/parametric_test_block/photo_1_0.png) | ![Image](images/parametric_test_block/photo_2_0.png) | ![Image](images/parametric_test_block/photo_3_0.png) |
| - | - | - |

## Gear Tester

### Sample Prints
| ![Image](images/gear_tester/code_1_0.png) | ![Image](images/gear_tester/gear_tester_1_0.png) | ![Image](images/gear_tester/gear_tester_2_0.png) |
| - | - | - |

## 3D Printer - Endpoint Upgrade Mount

### Sample Prints
| ![Image](images/temp/3d_printer_mount_1_0.png) | ![Image](images/temp/3d_printer_mount_2_0.png) |
| - | - |


## Cat-Food Sieve

- Mixed my cat's food.
- The vet told me not to mix it.
- So I 3D-printed a sieve to separate it again.

### Sample Prints
| ![Image](images/temp/sieve_1_0.png) |
| - |








  

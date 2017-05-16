# FORTE
A short script able to execute Fortran 90 code from within the linux shell more flexibly.

## USAGE
There are 4 ways to use this script:
- From a pipe (Useful from within vim/emacs):
```
<CMD PRODUCING FORTRAN SOURCE> | forte
```
 e.g.
```
$> echo "x=5; print *, x, x**2" | forte
```
- From a file:
```
forte <FILENAME>
```
  e.g.
```
$> forte test.f90
```
- From a string:
```
forte "<FORTRAN SOURCE>"
```
  e.g.
```
$> forte "x=5; print *, x, x**2"
```

- From the command line (finish with "end"):
```
$> forte
```
  e.g.
```    `
      $> forte
      $> integer :: x = 5
      $> print *, x, x**2
      $> end
```

A customizable $HEADER and $FOOTER are available below if you want anything
to be run automatically, for example:
```
HEADER="real, parameter :: pi = 3.14159265\n"
FOOTER="print *, 'Have a nice day!'\n end"
```

Note, the $HEADER/$FOOTER do NOT apply to the second case above,
 (`$>forte <FILENAME>`).

## DEPENDENCIES
  - gfortran (tested on v4.8.4 and above)
  - bash (tested on v4.3.11 and above)

## AUTHOR
Edward Higgins <ed.j.higgins@gmail.com>

## VERSION
0.2.1, 2017-05-16

## LICENSE
This code is distributed under the MIT license.

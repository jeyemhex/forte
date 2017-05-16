#!/usr/bin/env bash
#==============================================================================#
# FORTE
# A script to run Fortran code/snippets dynamically
#
#------------------------------------------------------------------------------#
# USAGE
#   There are 4 ways to use this script:
#
#   - From a pipe (Useful from within vim/emacs):
#       <CMD PRODUCING FORTRAN SOURCE> | forte
#     e.g.
#       $> echo "x=5; print *, x, x**2" | forte
#
#   - From a file:
#       forte <FILENAME>
#     e.g.
#       $> forte test.f90
#
#   - From a string:
#       forte "<FORTRAN SOURCE>"
#     e.g.
#       $> forte "x=5; print *, x, x**2"
#
#   - From the command line (finish with "end"):
#       $> forte
#     e.g.
#       $> forte
#       $> integer :: x = 5
#       $> print *, x, x**2
#       $> end
#
#   A customizable $HEADER and $FOOTER are available below if you want anything
#   to be run automatically, for example:
#     HEADER="real, parameter :: pi = 3.14159265\n"
#     FOOTER="print *, 'Have a nice day!'\n end"
#
#   Note, the $HEADER/$FOOTER do NOT apply to the second case above,
#   ($>forte <FILENAME>).
#
#------------------------------------------------------------------------------#
# DEPENDENCIES
#   - gfortran (tested on v4.8.4 and above)
#   - bash (tested on v4.3.11 and above)
#------------------------------------------------------------------------------#
# Author:  Edward Higgins <ed.j.higgins@gmail.com>
#------------------------------------------------------------------------------#
# Version: 0.2.1, 2017-05-16
#------------------------------------------------------------------------------#
# This code is distributed under the MIT license.
#==============================================================================#

# Let's try and pick a unique binary name, but die if it already exists
BIN=.fortran-$(date -Isecond)
if [ -f "$BIN" ]; then
  echo "ERROR: File $BIN already exists!" >&2
  exit 1
fi

# Define a header and footer for the Fortran source
HEADER=""
FOOTER="end"

# If there are no args, assume we're reading from a pipe or stdin
if [ -z "$@" ]; then
  str="$HEADER"
  while read line; do
    if [ "$line" = "end" ]; then break; fi
    str="$str\n$line"
  done
  str="$str\n$FOOTER"
  echo -ne "$str" | gfortran -x f95 -ffree-form -o $BIN - && ./$BIN ; rm -f $BIN

# Else if the arg is a filename, run that
elif [ -f "$@" ] ; then
  cat "$@" | gfortran -x f95 -ffree-form -o $BIN - && ./$BIN ; rm -f $BIN

# Else just run whatever is left in the args
else
  echo -ne "$HEADER\n$@\n$FOOTER" | gfortran -x f95 -ffree-form -o $BIN - && ./$BIN ; rm -f $BIN

fi

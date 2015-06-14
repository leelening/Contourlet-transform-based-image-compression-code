#!/bin/sh
#
aclocal
automake --foreign
autoconf

echo "Now you are ready to run ./configure"

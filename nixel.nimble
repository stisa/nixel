# Package

version       = "0.1.0"
author        = "Silvio T."
description   = "A pixel drawing utility in nim"
license       = "MIT"

# Dependencies

requires "nim >= 0.14.2"
requires "strfmt >= 0.3.1"
#We install this on our own, so no requires "nimage >= 0.2.0"

#postinstall:
#  echo "Cloning custom fork of nimage, because it's not on nimble:"
#  exec("git clone https://github.com/stisa/nimage.git")
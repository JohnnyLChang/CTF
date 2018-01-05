#!/bin/sh
socat tcp-listen:1337,fork,reuseaddr system:"ltrace -f -e malloc+free-@libc.so*  ./sgc"
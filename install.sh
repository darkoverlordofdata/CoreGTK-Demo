#!/usr/bin/bash

#
# run sudo su
# then run this batch
#
# Why?
#
# because gnustep is typically sourced in your login, 
# and then sudo gmake doesn't find the environment variables. 
#
. /usr/local/GNUstep/System/Library/Makefiles/GNUstep.sh
export RUNTIME_VERSION=gnustep-2.0
export CXXFLAGS="-std=c++11"
gmake install

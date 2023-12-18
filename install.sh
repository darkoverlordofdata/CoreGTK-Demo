#!/usr/local/bin/zsh
#
#   Install CoreGTK
#
cd $HOME/Documents/GitHub
git clone https://github.com/coregtk/coregtk.git
cd coregtk/src/CoreGTK
gmake
sudo su
. /usr/local/GNUstep/System/Library/Makefiles/GNUstep.sh
export RUNTIME_VERSION=gnustep-2.0
export CXXFLAGS="-std=c++11"
gmake install
exit
cd $HOME/Documents/GitHub/CoreGTK-Demo
sudo cp CoreGTK.h /usr/local/GNUstep/Local/Library/Frameworks/CoreGTK.framework/Headers/CoreGTK.h


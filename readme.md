# CoreGTK Demo

Gnustep is great! Up to a point. The gnustep ux is different. I just don't get the big icon. It seems like clutter, but I have to display it because if I minimize the window, then I can locate it again because the way I normally do this doesn't work with gnustep apps. Yeah. And nothing matches the desktop theme. There are gnustep themes, but nothing that matches existing desktops well. And the icon on docs and taskbars is often just a generic app icon.  

As an alternative, there is CoreGTK, a GTK wrapper adapter for Objective-C that corrects all of this. It replaces AppKit. You'll also write some different code. But you still have Foundation, so your business logic should stay the same. 

## help
make says 
```
make: no target to make.
```
Are you on FreeBSD?
```
sudo pkg install gmake
gmake
```

![alt App1](https://github.com/darkoverlordofdata/CoreGTK-Demo/blob/main/App1/2023-12-17-173931_204x130_scrot.png?raw=true)
```
cd App1
make
openapp ./App1
```
![alt App2](https://github.com/darkoverlordofdata/CoreGTK-Demo/blob/main/App2/2023-12-17-174015_204x130_scrot.png?raw=true)
```
cd App2
make
openapp ./App2
```
![alt SimpleTextEditor](https://github.com/darkoverlordofdata/CoreGTK-Demo/blob/main/SimpleTextEditor/2023-12-16-155117_1920x1080_scrot.png?raw=true)



# CoreGTK Demo

Gnustep is great! Up to a point. The gnustep ux is different. I prefer a native look.

As an alternative, there is CoreGTK, a GTK wrapper adapter for Objective-C that gives your app a Gtk UX. It replaces AppKit. You'll also write some different code. But you still have Foundation, so your business logic should stay the same. 

## What gui elements change?
* no big icon. 
* minimized windows appear in the desktop window menu.
* menu integrates with the global menu bar.
* same theme as the desktop.
* correct icon appears on the dock.

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



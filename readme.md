# simpletexteditor

@see https://github.com/coregtk/coregtk

this is the example from CoreGTK, with gnustep oriented build.

for a similar project using ObjFW see https://github.com/ObjGTK/ObjGTK3

## changes

icon: https://www.flaticon.com/free-icon/text-editor_4400968

Switched to GNUmakefile

simplified header:
```objective-c
#import <CoreGTK/CoreGTK.h>
```

glade ui is now stored in the application bundle:
```objective-c
		NSString *icon = [NSString stringWithFormat:@"%@/%@", 
            [[NSBundle mainBundle] bundlePath], 
            @"Resources/SimpleTextEditor.png"]; 
		GError* err = NULL;
		[CGTKWindow setDefaultIconFromFileWithFilename:icon andErr:&err];

		NSString *filename = [NSString stringWithFormat:@"%@/%@", 
            [[NSBundle mainBundle] bundlePath], 
            @"Resources/gui.glade"]; 

		if(![builder addFromFileWithFilename:filename andErr:NULL])
```

## build - FreeBSD
```
gmake
openapp ./SimpleTextEditor
```
## install - FreeBSD
```
sudo su
password:
sh install.sh
cp /usr/local/GNUstep/Local/Applications/SimpleTextEditor.app/Resources/SimpleTextEditor.desktop /usr/local/share/applications/SimpleTextEditor.desktop
exit
openapp SimpleTextEditor
```
or find in the menu

![alt App1](https://github.com/darkoverlordofdata/SimpleTextEditor/blob/main/App1/2023-12-17-173931_204x130_scrot.png?raw=true)

![alt App2](https://github.com/darkoverlordofdata/SimpleTextEditor/blob/main/App2/2023-12-17-174015_204x130_scrot.png?raw=true)

![alt SimpleTextEditor](https://github.com/darkoverlordofdata/SimpleTextEditor/blob/main/2023-12-16-155117_1920x1080_scrot.png?raw=true)


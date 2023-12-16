# simpletexteditor

@see https://github.com/coregtk/coregtk

this is the example from CoreGTK, with gnustep oriented build.

## changes

icon: https://www.flaticon.com/free-icon/text-editor_4400968

Switched to GNUmakefile

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

## build
```
gmake
openapp ./SimpleTextEditor
```
## install
```
sudo su
password:
sh install.sh
cp /usr/local/GNUstep/Local/Applications/SimpleTextEditor.app/Resources/SimpleTextEditor.desktop /usr/local/share/applications/SimpleTextEditor.desktop
exit
openapp SimpleTextEditor
```


![alt text](https://github.com/darkoverlordofdata/SimpleTextEditor/blob/main/2023-12-16-155117_1920x1080_scrot.png?raw=true)

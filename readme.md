# simpletexteditor

@see https://github.com/coregtk/coregtk

this is the example from CoreGTK, with gnustep oriented build.

## changes

icon: https://www.flaticon.com/free-icon/text-editor_4400968

Switched to GNUmakefile

glade ui is now stored in the application bundle:
```objective-c
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
### current user
```
gmake install GNUSTEP_INSTALLATION_DOMAIN=USER
openapp SimpleTextEditor
```
### globally
```
sudo su
password:
sh install.sh
exit
openapp SimpleTextEditor
```

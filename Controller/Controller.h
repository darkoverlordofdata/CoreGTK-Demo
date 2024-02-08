#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import <CoreGTK/CoreGTK.h>

#import "NSPatch/NSPatch.h"
#import "Window.h"

@interface Controller : NSObject
{
    Window *window;

}

- (void)applicationWillFinishLaunching:(NSNotification *) not;
- (void)applicationDidFinishLaunching:(NSNotification *) not;

@end
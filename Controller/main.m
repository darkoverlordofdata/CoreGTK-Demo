#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

#import "Controller.h"

int main(int argc, const char *argv[]) 
{

  @autoreleasepool {
    [NSApplication sharedApplication];
    Controller *controller = [Controller new];
    [[NSApplication sharedApplication] setDelegate: controller];

		[CGTK autoInitWithArgc:argc andArgv:(char **)argv];
    NSApplicationMain(argc, argv);

  }
}
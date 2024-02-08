#include <CoreFoundation/CoreFoundation.h>
#include <stdio.h>
#include <Block.h>
#include "CoreFoundation/CFBase.h"
#include "MyTimer.h"
/*
clang -I/usr/local/GNUstep/Local/Library/Headers -I/usr/local/GNUstep/System/Library/Headers -I/usr/local/include -L/usr/local/lib -L/usr/local/GNUstep/Local/Library/Libraries -fblocks -lgnustep-corebase -lBlocksRuntime main.c MyTimer.c -o timer

clang -I/usr/local/include -L/usr/local/lib -lCoreFoundation timer.c -o timer
*/

int main(int argc, char **argv) {

    printf("Hello World\n");

    MyTimer gTmr1 = MyTimerCreate(kCFAllocatorDefault);
    MyTimer gTmr2 = MyTimerCreate(kCFAllocatorDefault);

    //Set 1st timer 20 seconds from now
    MyTimerSetTimer(gTmr1, 5 * 1000, ^(MyTimer this) {
        printf("callback1\n");
        MyTimerStopTimer(this);
    });

    //And then reset the 2nd timer 2 seconds from now
    MyTimerSetTimer(gTmr2, 2 * 1000, ^(MyTimer this) {
        printf("callback2\n");
        MyTimerStopTimer(this);
    });

    // ...

    //Enter the run-loop...
    CFRunLoopRun();

    CFRelease(gTmr1);
    CFRelease(gTmr2);
    return 0;
}
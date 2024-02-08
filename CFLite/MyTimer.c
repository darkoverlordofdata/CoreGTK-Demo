#include <CoreFoundation/CFRuntime.h>
#include <CoreFoundation/CFBase.h>
#include "MyTimer.h"
/*
clang -I/usr/local/GNUstep/Local/Library/Headers -I/usr/local/GNUstep/System/Library/Headers -I/usr/local/include -L/usr/local/lib -L/usr/local/GNUstep/Local/Library/Libraries -lgnustep-corebase main.c MyTimer.c -o timer

clang -I/usr/local/include -L/usr/local/lib -lCoreFoundation timer.c -o timer
*/

struct __MyTimer
{
    CFRuntimeBase _parent;
    CFRunLoopTimerRef timer;
    void (^callback)(MyTimer this);
};

static void 
MyTimerFinalize(CFTypeRef cf)
{
    MyTimer mt = (MyTimer)cf;
}

static Boolean 
MyTimerEqual (CFTypeRef cf1, CFTypeRef cf2)
{
    MyTimer mt1 = (MyTimer)cf1;
    MyTimer mt2 = (MyTimer)cf2;

    if (mt1->timer == mt2->timer)
    {
        return true;
    }
    return false;
}

static CFHashCode
MyTimerHash (CFTypeRef cf)
{
    MyTimer mt = (MyTimer)cf;
    return (CFHashCode)mt->timer;
}

static CFTypeID _kMyTimerTypeID = _kCFRuntimeNotATypeID;

static CFRuntimeClass MyTimerClass =
{
    0,                            /* version*/
    "MyTimer",                    /* class name*/
    NULL,                         /* init */
    NULL,                         /* copy */
    MyTimerFinalize,              /* finalize */
    MyTimerEqual,                 /* equal */
    MyTimerHash,                  /* hash */
    NULL,                         /* copyFormattingDes */
    NULL,                         /* copyDebugDesc */
    NULL,                         /* reclaim */
    NULL                          /* refCount */
};

__attribute__((constructor (101))) void MyTimerInitialize (void);
void 
MyTimerInitialize (void)
{
    _kMyTimerTypeID = _CFRuntimeRegisterClass (&MyTimerClass);
    printf("_kMyTimerTypeID = %lu\n", (unsigned long)_kMyTimerTypeID);
}

CFTypeID
MyTimerGetTypeID (void)
{
    return _kMyTimerTypeID;
}

MyTimer
MyTimerCreate (CFAllocatorRef alloc)
{
    struct __MyTimer *new;

    new = (struct __MyTimer *) _CFRuntimeCreateInstance (alloc, _kMyTimerTypeID,
                                                        sizeof (struct __MyTimer) - sizeof (CFRuntimeBase),
                                                        NULL);
    if (new)
    {
        new->timer = NULL;
    }

    return new;
}

static void 
MyTimerCallback(CFRunLoopTimerRef timer, void *info)
{
    MyTimer this = (MyTimer)info;
    this->callback(this);
}

bool 
MyTimerSetTimer(MyTimer this, size_t nmsPeriod, void (^cb)(MyTimer))
{
    MyTimerStopTimer(this);

    CFTimeInterval fInterval = ((CFTimeInterval)nmsPeriod) / 1000.0;

    CFRunLoopTimerContext ctx = {};
    ctx.info = this;

    this->callback = cb;

    this->timer = CFRunLoopTimerCreate(kCFAllocatorDefault,
                                   CFAbsoluteTimeGetCurrent() + fInterval,
                                   fInterval,
                                   0, 0,
                                   MyTimerCallback,
                                   &ctx);

    if(!this->timer)
        return false;

    CFRunLoopAddTimer(CFRunLoopGetCurrent(), this->timer, kCFRunLoopCommonModes);

    return true;
}

void 
MyTimerStopTimer(MyTimer this)
{
    if(this->timer)
    {
        CFRunLoopTimerInvalidate(this->timer);
            
        CFRelease(this->timer);
            
        this->timer = NULL;
    }
}


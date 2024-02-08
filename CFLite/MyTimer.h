#ifndef _MYTIMER_H__
#define _MYTIMER_H__

#include <CoreFoundation/CoreFoundation.h>
#include <Block.h>

typedef struct __MyTimer* MyTimer;

bool MyTimerSetTimer(MyTimer this, size_t nmsPeriod, void (^cb)(MyTimer));
void MyTimerStopTimer(MyTimer this);
MyTimer MyTimerCreate (CFAllocatorRef alloc);


#endif
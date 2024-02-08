struct MyTimer
{

MyTimer()
{
}

~MyTimer()
{
    stopTimer();
}


bool setTimer(size_t nmsPeriod, //Period in milliseconds
              void (*pfn)(void) //Function to call when timer fires
             )
{
    stopTimer();

    CFTimeInterval fInterval = ((CFTimeInterval)nmsPeriod) / 1000.0;

    CFRunLoopTimerContext ctx = {};
    ctx.info = this;

    _pfnCallback = pfn;

    _refTmr = CFRunLoopTimerCreate(kCFAllocatorDefault,
                                   CFAbsoluteTimeGetCurrent() + fInterval,
                                   fInterval,
                                   0, 0,
                                   _callbackTmr,
                                   &ctx);

    if(!_refTmr)
        return false;

    CFRunLoopAddTimer(CFRunLoopGetCurrent(), _refTmr, kCFRunLoopCommonModes);

    return true;
}

void stopTimer()
{
    if(_refTmr)
    {
        CFRunLoopTimerInvalidate(_refTmr);
            
        CFRelease(_refTmr);
            
        _refTmr = NULL;
    }
}


protected:
    static void _callbackTmr(CFRunLoopTimerRef timer, void *info)
    {
        MyTimer* pThis = (MyTimer*)info;
        pThis->_pfnCallback();
    }


private:

    CFRunLoopTimerRef _refTmr = NULL;
    void (*_pfnCallback)(void) = NULL;
}


MyTimer gTmr1;
MyTimer gTmr2;
//Set 1st timer 2 minutes from now
gTmr1.setTimer(2 * 60 * 1000, callback1);

//Set 2nd timer 300 seconds from now
gTmr2.setTimer(300 * 1000, callback2);

//And then reset the 2nd timer 2 seconds from now
gTmr2.setTimer(2 * 1000, callback2);

// ...

//Enter the run-loop...
CFRunLoopRun();
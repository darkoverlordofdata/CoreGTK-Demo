

#include <stdio.h>
#include <CoreFoundation/CoreFoundation.h>
#include "EXUInt32.h"

int main() {
    char buf[1024] = {0}; 
    printf("Hello, World!\n");
    CFStringRef formatString = CFSTR("This is %@ example");
    
    CFStringRef aString =  CFSTR("one");
    CFStringRef resultString0 = CFStringCreateWithFormat(NULL, NULL, formatString, aString);
    CFStringGetCString(resultString0, buf, 1024, kCFStringEncodingUTF8);
    printf("%s\n", buf);

    EXUInt32Ref aNumber = EXUInt32Create(kCFAllocatorDefault, 420);
    CFStringRef resultString1 = CFStringCreateWithFormat(NULL, NULL, formatString, aNumber);
    CFStringGetCString(resultString1, buf, 1024, kCFStringEncodingUTF8);
    printf("%s\n", buf);

    return 0;
}


// clang -std=c2x main.c -o main EXUInt32.c -I/usr/local/include -I/usr/local/GNUstep/System/Library/Headers -I/usr/local/GNUstep/Local/Library/Headers -L/usr/local/lib -L/usr/local/GNUstep/Local/Library/Libraries -lgnustep-corebase
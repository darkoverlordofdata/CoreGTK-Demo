// Mac OS X: clang -F<path-to-CFLite-framework> -framework CoreFoundation Examples/plconvert.c -o plconvert
//  note: When running this sample, be sure to set the environment variable DYLD_FRAMEWORK_PATH to point to the directory containing your new version of CoreFoundation.
//   e.g.
//  DYLD_FRAMEWORK_PATH=/tmp/CF-Root ./plconvert <input> <output>
// 

/*
clang -I/usr/local/include -L/usr/local/lib -L/usr/local/GNUstep/Local/Library/Libraries -lgnustep-corebase plconvert.c -o plconvert

clang -I/usr/local/include -L/usr/local/lib -lCoreFoundation plconvert.c -o plconvert

*/
// Linux: clang -I/usr/local/include -L/usr/local/lib -lCoreFoundation plconvert.c -o plconvert

/*
 This example shows usage of CFString, CFData, and other CFPropertyList types. It takes two arguments:
    1. A property list file to read, in either binary or XML property list format.
    2. A file name to write a converted property list file to.
 If the first input is binary, the output is XML and vice-versa.
*/

#include "CoreFoundation/CFBase.h"
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <stdio.h>
#include <unistd.h>

#include <CoreFoundation/CoreFoundation.h>

static void logIt(CFStringRef format, ...) {
    va_list args;
    va_start(args, format); 
    CFStringRef str = CFStringCreateWithFormatAndArguments(kCFAllocatorSystemDefault, NULL, format, args);
    if (!str) return;
    
    CFIndex blen = CFStringGetMaximumSizeForEncoding(CFStringGetLength(str), kCFStringEncodingUTF8);
    char *buf = str ? (char *)malloc(blen + 1) : 0;
    if (buf) {
        Boolean converted = CFStringGetCString(str, buf, blen, kCFStringEncodingUTF8);
        if (converted) {
            // null-terminate
            buf[blen] = 0;
            printf("%s\n", buf);
        }
    }
    if (buf) free(buf);
    if (str) CFRelease(str);      va_end(args);
}

static CFMutableDataRef createDataFromFile(const char *fname) {
    int fd = open(fname, O_RDONLY);
    CFMutableDataRef res = CFDataCreateMutable(kCFAllocatorSystemDefault, 0);
    char buf[4096];
    
    ssize_t amountRead;
    while ((amountRead = read(fd, buf, 4096)) > 0) {
        CFDataAppendBytes(res, (const UInt8 *)buf, amountRead);
    }
    
    close(fd);
    return res;
}

static bool writeDataToFile(CFDataRef data, const char *fname) {
    printf("enter writeDataToFile\n");
    int fd = open(fname, O_WRONLY | O_CREAT | O_TRUNC, 0666);
    if (fd < 0) {
        printf("There was an error creating the file: %d", errno);
        return false;
    }
    int dataLen = CFDataGetLength(data);
    int w = write(fd, CFDataGetBytePtr(data), dataLen);
    fsync(fd);
    close(fd);
    if (w != dataLen) return false;
    printf("leave writeDataToFile\n");
    return true;
}

int main(int argc, char **argv) {
    char buf[1024] = {0}; 

    CFStringRef formatString = CFSTR("This is %@ example");
    CFStringRef aString =  CFSTR("one");
    CFStringRef resultString = CFStringCreateWithFormat(NULL, NULL, formatString, aString);

    CFStringGetCString(resultString, buf, 1024, kCFStringEncodingUTF8);
    logIt(CFSTR("%s"), buf);

    CFRelease(formatString);
    CFRelease(aString);
    CFRelease(resultString);

    logIt(CFSTR("Hello, World!"));


    if (argc != 3) {
        printf("Usage: plconvert <in file> <out file>\nIf the in file is an XML property list, convert to binary property list in out file. If the in file is a binary property list, convert to XML property list in out file.\n");
    } else {
        
        CFMutableDataRef plistData = createDataFromFile(argv[1]);
        if (!plistData) {
            printf("Unable to create data from file name: %s", argv[1]);
        } else {
            CFPropertyListFormat fmt;
            printf("size = %lu\n", (sizeof(fmt)));
            CFErrorRef err;
            // CFDataRef xx = (CFDataRef)plistData;
            // CFPropertyListRef plist = CFPropertyListCreateWithData(kCFAllocatorSystemDefault, xx, 0, &fmt, &err);
            CFPropertyListRef plist = CFPropertyListCreateWithData(kCFAllocatorSystemDefault, (CFDataRef)plistData, 0, &fmt, &err);

            printf("fmt = %u\n", fmt);
            fmt = fmt & 0xffff;
            printf("fmt = %u\n", fmt);

            if (!plist) {
                // logIt(CFSTR("Unable to create property list from data: %@"), err);
                logIt(CFSTR("Unable to create property list from data"));
            } else {
                logIt(CFSTR("Property list contents:\n%@"), plist);
                if (fmt == kCFPropertyListBinaryFormat_v1_0) {
                    logIt(CFSTR("Converting to XML property list at: %s"), argv[2]);
                    fmt = kCFPropertyListXMLFormat_v1_0;
                } else if (fmt == kCFPropertyListXMLFormat_v1_0) {
                    logIt(CFSTR("Converting xml to binary property list at: %s"), argv[2]);
                    fmt = kCFPropertyListBinaryFormat_v1_0;
                } else if (fmt == kCFPropertyListOpenStepFormat) {
                    logIt(CFSTR("Converting gs to binary property list at: %s"), argv[2]);
                    fmt = kCFPropertyListBinaryFormat_v1_0;
                } else {
                    logIt(CFSTR("Unknown property list format! Not converting output format."));
                    printf("format: %u", fmt);
                }
                
                CFDataRef outputData = CFPropertyListCreateData(kCFAllocatorSystemDefault, plist, fmt, 0, &err);
                if (!outputData) {
                    logIt(CFSTR("Unable to write property list to data: %@"), err);
                } else {
                    bool success = writeDataToFile(outputData, argv[2]);
                    if (!success) {
                        logIt(CFSTR("Unable to write data to file"));
                    }
                    CFRelease(outputData);
                }
                CFRelease(plist);
            }
            CFRelease(plistData);
        }
    }
}

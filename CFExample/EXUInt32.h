/* EXUInt32.h

   Copyright (C) 2014 Free Software Foundation, Inc.

   This file is part of the GNUstep CoreBase Library distribution.

   Permission is hereby granted, free of charge, to any person obtaining
   a copy of this software and associated documentation files (the
   "Software"), to deal in the Software without restriction, including
   without limitation the rights to use, copy, modify, merge, publish,
   distribute, sublicense, and/or sell copies of the Software, and to
   permit persons to whom the Software is furnished to do so, subject to
   the following conditions:

   The above copyright notice and this permission notice shall be included
   in all copies or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
   THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
   OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
   ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
   OTHER DEALINGS IN THE SOFTWARE.
*/

#ifndef __EXUINT32_H__
#define __EXUINT32_H__ 1

#include <CoreFoundation/CFBase.h>

// typedef const struct __EXUInt32 *UInt32Ref;
typedef const struct __EXUInt32 *EXUInt32Ref;

CFTypeID EXUInt32GetTypeID (void);

EXUInt32Ref EXUInt32Create (CFAllocatorRef alloc, UInt32 value);

UInt32 EXUInt32GetValue (EXUInt32Ref u);


#endif /* __EXUINT32_H__ */

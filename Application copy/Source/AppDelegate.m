/*
 * AppDelegate.m
 *
 * Copyright (C) 2023 darkoverlordofdata
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 */

/*
 * Objective-C imports
 */
#import "AppDelegate.h"
#import "SimpleTextEditor.h"

@implementation AppDelegate
{
	char **m_array;
}

- (void)applicationWillTerminate:(NSNotification *) not
{
	NSLog(@"applicationWillTerminate");
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	NSLog(@"applicationDidFinishLaunching");
	// NSArray *arguments = [[NSProcessInfo processInfo] arguments];
	// [CGTK autoInitWithArgc:[arguments count] andArgv:[self getCArray:arguments]];

	// Create and display editor
	SimpleTextEditor *editor = [[SimpleTextEditor alloc] init];
	
	// Check for error
	if (editor == nil) {
		[NSApp terminate:nil];
		return;// nil;
	}
	
	// Show the window	
	[editor show];
	
	// Start GTK+ loop
	[CGTK main];


}

- (char**)getCArray:(NSArray*) array
{
        int count = [array count];
		m_array = calloc(count, sizeof(char*));

        for (int i = 0; i < count; i++) {
             m_array[i] = (char*)[[array objectAtIndex:i] UTF8String];
        }
        return m_array;     
}

@end

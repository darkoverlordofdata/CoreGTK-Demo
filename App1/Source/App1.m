/*
 * SimpleTextEditor.m
 * This file is part of SimpleTextEditor
 *
 * Copyright (C) 2015 - Tyler Burton
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
#import "App1.h"

@implementation App1

-(id)init
{
	self = [super init];
	
	if(self)
	{
		window = [[CGTKWindow alloc]init:GTK_WINDOW_TOPLEVEL];
	// Here we connect the "destroy" event to a signal handler in the HelloWorld class
		[CGTKSignalConnector connectGpointer:[window WIDGET] withSignal:@"destroy" 
		toTarget:[CGTK class] withSelector:@selector(mainQuit) andData:NULL];
		

		[window setTitle:@"Window"];
		[window setDefaultSizeWithWidth:200 andHeight:100];

		NSString *icon = [NSString stringWithFormat:@"%@/%@", 
            [[NSBundle mainBundle] bundlePath], 
            @"Resources/App1.png"]; 
		[CGTKWindow setDefaultIconFromFileWithFilename:icon andErr:NULL];
	}
	
	return self;
}

-(void)show
{
	[window showAll];
}


-(void)dealloc
{
	[window release];
	[super dealloc];
}

@end

/*
 * App3.m
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
#import "App3.h"

@implementation App3

-(instancetype)init
{
	// self = [super init];
	
	if(self)
	{
		[super init:GTK_WINDOW_TOPLEVEL];
		[CGTKSignalConnector connectGpointer:[self WIDGET] withSignal:@"destroy" 
							toTarget:[CGTK class] withSelector:@selector(mainQuit) andData:NULL];

		[self setTitle:@"Window"];
		[self setDefaultSizeWithWidth:200 andHeight:100];

		button_box = [[CGTKButtonBox alloc]init:GTK_ORIENTATION_HORIZONTAL];
		[self add:(CGTKWidget*)button_box];

		button = [[CGTKButton alloc]initWithLabel:@"Hello World!"];
		[button_box add:(CGTKWidget*)button];
		
		[CGTKSignalConnector connectGpointer:[button WIDGET] withSignal:@"clicked" 
							toTarget:self withSelector:@selector(print_hello) andData:NULL];

		NSString *icon_path = [NSString stringWithFormat:@"%@/%@", 
            [[NSBundle mainBundle] bundlePath], 
            @"Resources/App3.png"]; 
		[CGTKWindow setDefaultIconFromFileWithFilename:icon_path andErr:NULL];
	}
	
	return self;
}

-(void)show
{
	[self showAll];
}

-(void)print_hello
{
	NSLog(@"Hello World!");
}


-(void)dealloc
{
	[super dealloc];
}

@end

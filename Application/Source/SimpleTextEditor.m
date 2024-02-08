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
#import "SimpleTextEditor.h"

@implementation SimpleTextEditor

- (instancetype)init
{
	// self = 
	
	if (self)
	{
		[super init:GTK_WINDOW_TOPLEVEL];
		CGTKBuilder *builder = [[CGTKBuilder alloc] init];
		NSString *uifile = [NSString stringWithFormat:@"%@/%@", 
            [[NSBundle mainBundle] bundlePath], @"Resources/Application.glade"]; 

		if (![builder addFromFileWithFilename:uifile andErr:NULL])
		{
			NSLog(@"Error loading GUI file");
			return nil;
		}

		NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:
			[CGTKCallbackData withObject:self andSEL:@selector(winMain_Destroy)], 	@"winMain_Destroy",
			[CGTKCallbackData withObject:self andSEL:@selector(btnNew_Clicked)], 	@"btnNew_Clicked",
			[CGTKCallbackData withObject:self andSEL:@selector(btnOpen_Clicked)], 	@"btnOpen_Clicked",
			[CGTKCallbackData withObject:self andSEL:@selector(btnSave_Clicked)], 	@"btnSave_Clicked",
			[CGTKCallbackData withObject:self andSEL:@selector(btnSaveAs_Clicked)], @"btnSaveAs_Clicked",
			[CGTKCallbackData withObject:self andSEL:@selector(btnCut_Clicked)], 	@"btnCut_Clicked",
			[CGTKCallbackData withObject:self andSEL:@selector(btnCopy_Clicked)], 	@"btnCopy_Clicked",
			[CGTKCallbackData withObject:self andSEL:@selector(btnPaste_Clicked)], 	@"btnPaste_Clicked",
			[CGTKCallbackData withObject:self andSEL:@selector(btnDelete_Clicked)], @"btnDelete_Clicked",
			[CGTKCallbackData withObject:self andSEL:@selector(btnAbout_Clicked)], 	@"btnAbout_Clicked",
			nil];
		
		[CGTKBaseBuilder connectSignalsToObjectsWithBuilder:builder andSignalDictionary:dic];
		
		// Get a reference to the window
		widget = [CGTKBaseBuilder getWidgetFromBuilder:builder withName:@"winMain"];

		// Get a reference to the text view
		txtView = [[CGTKTextView alloc] initWithGObject:[[CGTKBaseBuilder getWidgetFromBuilder:builder withName:@"txtView"] GOBJECT]];
		
		[builder release];
		NSString *icon = [NSString stringWithFormat:@"%@/%@", 
            [[NSBundle mainBundle] bundlePath], @"Resources/Application.png"]; 
		[CGTKWindow setDefaultIconFromFileWithFilename:icon andErr:NULL];
	}
	
	return self;
}

- (void)show
{
	[widget showAll];
}

- (void)winMain_Destroy
{
	[CGTK mainQuit];
    [NSApp terminate:nil];
}

- (void)btnNew_Clicked
{
	[self setText:@""];
}

- (void)btnOpen_Clicked
{
	filename = [MultiDialog presentOpenDialog];
	NSString *text = [NSString stringWithContentsOfFile:filename];	
	[self setText:text];
	[self setTitle:filename];
}

- (void)btnSave_Clicked
{
	// filename = [MultiDialog presentSaveDialog];
	NSString *text = [self getText];
		
	NSError *error;
	BOOL succeed = [text writeToFile:filename atomically:YES encoding:NSUTF8StringEncoding error:&error];

	if (!succeed)
	{
		NSLog(@"%@:%s Error saving: %@", [self class], sel_getName(_cmd), [error localizedDescription]);
	}
	else 
	{
		[self setTitle:filename];
	}
}


- (void)btnSaveAs_Clicked
{
	filename = [MultiDialog presentSaveDialog];
	NSString *text = [self getText];
		
	NSError *error;
	BOOL succeed = [text writeToFile:filename atomically:YES encoding:NSUTF8StringEncoding error:&error];

	if(!succeed)
	{
		NSLog(@"%@:%s Error saving: %@", [self class], sel_getName(_cmd), [error localizedDescription]);
	}
	else 
	{
		[self setTitle:filename];
	}
}

- (void)btnCut_Clicked
{

}
- (void)btnCopy_Clicked
{

}
- (void)btnPaste_Clicked
{

}
- (void)btnDelete_Clicked
{

}
- (void)btnAbout_Clicked
{
	GError *err = NULL;
	CGTKAboutDialog *dialog = [[CGTKAboutDialog alloc]init];
	[dialog setProgramName:@"SimpleTextEditor"];
	[dialog setVersion:@"0.9"];
	[dialog setCopyright:@"(c) 2023 darkoverlordofdata"];
	[dialog setComments:@"Remember: When the kids track dirt all over your clean mines,\nJust use Minesweeper to sweep then clean!"];
	[dialog setWebsite:@"http://www.application.org"];
	[dialog setIconFromFileWithFilename:@"Application.png" andErr:&err];
	if (err != NULL)
	{
		g_error_free(err);
	}
	[dialog run];
	[dialog destroy];
	
}

/**
 * setTitle
 * due to side effects of builder, which only returns superclass GtkWidget,
 * we don't know that window wraps a GtkWindow subclass.
 * Therefore, manually reify.
 */
- (void)setTitle:(NSString *)title
{
	gtk_window_set_title(GTK_WINDOW([self GOBJECT]), [title UTF8String]);
}


- (NSString *)getText
{
	gchar *gText = NULL;
	GtkTextBuffer *buf = NULL;
	GtkTextIter start, end;
	NSString *nsText = nil;
	
	// Grab reference to text buffer
	buf = [txtView getBuffer];
	
	// Determine the bounds of the buffer
	gtk_text_buffer_get_bounds (buf, &start, &end);
	
	// Get the gchar text from the buffer
	gText = gtk_text_buffer_get_text(buf, &start, &end, FALSE);
	
	// Convert it to an NSString
	nsText = [NSString stringWithUTF8String:gText];
	
	// Free the allocated gchar string
	g_free(gText);

	// Return the text
	return nsText;
}

- (void)setText:(NSString *)text
{
	// Get reference to text buffer
	GtkTextBuffer *buf = [txtView getBuffer];
	
	// Set contents of text buffer
	gtk_text_buffer_set_text(buf, [text UTF8String], -1);
}

- (void)dealloc
{
	[txtView release];
	[widget release];
	[super dealloc];
}


@end

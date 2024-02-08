/*
 * SimpleTextEditor.h
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
#import <Cocoa/Cocoa.h>
#import <CoreGTK/CoreGTK.h>
#import "MultiDialog.h"

@interface SimpleTextEditor : CGTKWindow
{
	CGTKWidget *widget;
	CGTKTextView *txtView;
	NSString *filename;
  	CGTKButton *button;
  	CGTKButtonBox *button_box;
}

- (void)show;

// Callbacks
- (void)winMain_Destroy;
- (void)btnNew_Clicked;
- (void)btnOpen_Clicked;
- (void)btnSave_Clicked;
- (void)btnSaveAs_Clicked;
- (void)btnCut_Clicked;
- (void)btnCopy_Clicked;
- (void)btnPaste_Clicked;
- (void)btnDelete_Clicked;
- (void)btnAbout_Clicked;


- (instancetype)init;
// Helper methods to deal with the text view
- (NSString *)getText;
- (void)setText:(NSString *)text;
- (void)setTitle:(NSString *)title;

@end

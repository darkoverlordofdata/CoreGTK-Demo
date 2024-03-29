/*
 * Menu.h
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
#import <CoreGTK/CoreGTK.h>
@interface Menu : NSObject
@property (strong, nonatomic) CGTKWindow *window;
@property (strong, nonatomic) CGTKMenuBar *menubar;
@property (strong, nonatomic) CGTKBox *appBox;
@property (strong, nonatomic) CGTKMenu *gameMenu;
@property (strong, nonatomic) CGTKMenuItem *gameMenuGame;
@property (strong, nonatomic) CGTKMenuItem *gameMenuNewGame;
@property (strong, nonatomic) CGTKMenuItem *gameMenuSetup;
@property (strong, nonatomic) CGTKMenuItem *gameMenuOptions;
@property (strong, nonatomic) CGTKMenuItem *gameMenuQuit;
@property (strong, nonatomic) CGTKMenu *gameHelp;
@property (strong, nonatomic) CGTKMenuItem *gameHelpHelp;
@property (strong, nonatomic) CGTKMenuItem *gameHelpAbout;

-(void)show;
// Callbacks
-(void)newGame;
-(void)openSetupDialog;
-(void)openOptionDialog;
-(void)gameQuit;
-(void)gameAbout;
-(void)print_hello;

@end

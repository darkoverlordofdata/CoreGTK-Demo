/*
 * Menu.m
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
#import "Menu.h"

@implementation Menu
{
  	CGTKButton *_button;
  	CGTKLayout *_layout;

}
@synthesize window = _window;
@synthesize gameMenuGame = _gameMenuGame;
@synthesize gameMenuNewGame = _gameMenuNewGame;
@synthesize gameMenuSetup = _gameMenuSetup;
@synthesize gameMenuOptions = _gameMenuOptions;
@synthesize gameMenuQuit = _gameMenuQuit;
@synthesize gameHelp = _gameHelp;
@synthesize gameHelpHelp = _gameHelpHelp;
@synthesize gameHelpAbout = _gameHelpAbout;

-(id)init
{
	self = [super init];
	
	if(self)
	{
		_window = [[CGTKWindow alloc]init:GTK_WINDOW_TOPLEVEL];
		[CGTKSignalConnector connectGpointer:[_window WIDGET] withSignal:@"destroy" 
							toTarget:[CGTK class] withSelector:@selector(mainQuit) andData:NULL];

		[_window setTitle:@"Window"];
		[_window setDefaultSizeWithWidth:480 andHeight:360];
		// [_window setSizeRequestWithWidth:480 andHeight:360];


		NSString *icon_path = [NSString stringWithFormat:@"%@/%@", 
            [[NSBundle mainBundle] bundlePath], @"Resources/minesweeper.png"]; 
		[CGTKWindow setDefaultIconFromFileWithFilename:icon_path andErr:NULL];

		_layout = [[CGTKLayout alloc]initWithHadjustment:NULL andVadjustment:NULL];
		_appBox = [[CGTKBox alloc]initWithOrientation:GTK_ORIENTATION_VERTICAL andSpacing:0];
		[_window add:_layout];
		[_layout add:_appBox];

		_menubar = [[CGTKMenuBar alloc]init];
		[_appBox packStartWithChild:_menubar andExpand:FALSE andFill:FALSE andPadding:0];

		_gameMenu = 		[[CGTKMenu alloc]init];
		_gameMenuGame = 	[[CGTKMenuItem alloc]initWithLabel:@"Game"];
		_gameMenuNewGame = 	[[CGTKMenuItem alloc]initWithLabel:@"New Game"];
		_gameMenuSetup = 	[[CGTKMenuItem alloc]initWithLabel:@"Setup"];
		_gameMenuOptions = 	[[CGTKMenuItem alloc]initWithLabel:@"Options"];
		_gameMenuQuit = 	[[CGTKMenuItem alloc]initWithLabel:@"Quit"];

		_gameHelp = 		[[CGTKMenu alloc]init];
		_gameHelpHelp = 	[[CGTKMenuItem alloc]initWithLabel:@"Help"];
		_gameHelpAbout = 	[[CGTKMenuItem alloc]initWithLabel:@"About"];

		[_gameMenuGame setSubmenu:_gameMenu];
		[_menubar append:_gameMenuGame];
		[_gameMenu append:_gameMenuNewGame];
		[_gameMenu append:_gameMenuSetup];
		[_gameMenu append:_gameMenuOptions];
		[_gameMenu append:[CGTKSeparatorMenuItem new]];
		[_gameMenu append:_gameMenuQuit];

		[_gameHelpHelp setSubmenu:_gameHelp];
		[_menubar append:_gameHelpHelp];
		[_gameHelp append:[CGTKSeparatorMenuItem new]];
		[_gameHelp append:_gameHelpAbout];

		[_window showAll];
    	// Signalhandlers
		[_window setKeepAbove:YES];
		
		int width = 1920;
		int height = 1080;
		[_window setSizeRequestWithWidth:width andHeight:height];
		[_window moveWithX:0 andY:0];
		[_window fullscreen];
		
		_button = [[CGTKButton alloc]initWithLabel:@"Hello World!"];
		[_layout add:(CGTKWidget*)_button];

				
		[_button setName:@"backgroundImage"];
		[_window setName:@"backgroundImage"];

		

		[CGTKSignalConnector connectGpointer:[_button WIDGET] withSignal:@"clicked" 
							toTarget:self withSelector:@selector(print_hello) andData:NULL];

		[CGTKSignalConnector connectGpointer:[_window WIDGET] withSignal:@"destroy" 
							toTarget:self withSelector:@selector(gameQuit) andData:NULL];

		[CGTKSignalConnector connectGpointer:[_gameMenuNewGame WIDGET] withSignal:@"activate" 
							toTarget:self withSelector:@selector(newGame) andData:NULL];
		[CGTKSignalConnector connectGpointer:[_gameMenuSetup WIDGET] withSignal:@"activate" 
							toTarget:self withSelector:@selector(openSetupDialog) andData:NULL];
		[CGTKSignalConnector connectGpointer:[_gameMenuOptions WIDGET] withSignal:@"activate" 
							toTarget:self withSelector:@selector(openOptionDialog) andData:NULL];
		[CGTKSignalConnector connectGpointer:[_gameMenuQuit WIDGET] withSignal:@"activate" 
							toTarget:self withSelector:@selector(gameQuit) andData:NULL];

		[CGTKSignalConnector connectGpointer:[_gameHelpAbout WIDGET] withSignal:@"activate" 
							toTarget:self withSelector:@selector(gameAbout) andData:NULL];

							

	}
	
	return self;
}


-(void)print_hello
{
	NSLog(@"Hello World!");
	NSLog(@"[*] quit game...");
	[CGTK mainQuit];

}



-(void)newGame
{
	NSLog(@"[*] new game...");
}

-(void)openSetupDialog
{
	NSLog(@"[*] mew game...");
}
-(void)openOptionDialog
{
	NSLog(@"[*] open options...");
}
-(void)gameQuit
{
	NSLog(@"[*] quit game...");
	[CGTK mainQuit];
}

-(void)gameAbout 
{
	NSLog(@"[*] about...");
	GError *err = NULL;
	CGTKAboutDialog *dialog = [[CGTKAboutDialog alloc]init];
	[dialog setProgramName:@"Minesweeper"];
	[dialog setVersion:@"0.9"];
	[dialog setCopyright:@"(c) 2023 darkoverlordofdata"];
	[dialog setComments:@"Remember: When the kids track dirt all over your clean mines,\nJust use Minesweeper to sweep then clean!"];
	[dialog setWebsite:@"http://www.minesweeper.org"];
	[dialog setIconFromFileWithFilename:@"minesweeper.png" andErr:&err];
	if (err != NULL)
	{
		g_error_free(err);
	}
	[dialog run];
	[dialog destroy];
	NSLog(@"[*] about...bye!");
}


-(void)show
{
	[_window showAll];
}



-(void)dealloc
{
	[super dealloc];
}

@end

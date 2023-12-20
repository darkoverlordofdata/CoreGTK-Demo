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

-(id)init
{
	self = [super init];
	
	if(self)
	{
		window = [[CGTKWindow alloc]init:GTK_WINDOW_TOPLEVEL];
		[CGTKSignalConnector connectGpointer:[window WIDGET] withSignal:@"destroy" 
							toTarget:[CGTK class] withSelector:@selector(mainQuit) andData:NULL];

		[window setTitle:@"Window"];
		[window setDefaultSizeWithWidth:200 andHeight:100];


		NSString *icon_path = [NSString stringWithFormat:@"%@/%@", 
            [[NSBundle mainBundle] bundlePath], @"Resources/minesweeper.png"]; 
		[CGTKWindow setDefaultIconFromFileWithFilename:icon_path andErr:NULL];

		app_box = [[CGTKBox alloc]initWithOrientation:GTK_ORIENTATION_VERTICAL andSpacing:0];
		[window add:app_box];

		menubar = [[CGTKMenuBar alloc]init];
		[app_box packStartWithChild:menubar andExpand:FALSE andFill:FALSE andPadding:0];

		gameMenu = 			[[CGTKMenu alloc]init];
		gameMenu_game = 	[[CGTKMenuItem alloc]initWithLabel:@"Game"];
		gameMenu_newGame = 	[[CGTKMenuItem alloc]initWithLabel:@"New Game"];
		gameMenu_setup = 	[[CGTKMenuItem alloc]initWithLabel:@"Setup"];
		gameMenu_options = 	[[CGTKMenuItem alloc]initWithLabel:@"Options"];
		gameMenu_quit = 	[[CGTKMenuItem alloc]initWithLabel:@"Quit"];

		gameHelp = 			[[CGTKMenu alloc]init];
		gameHelp_help = 	[[CGTKMenuItem alloc]initWithLabel:@"Help"];
		gameHelp_about = 	[[CGTKMenuItem alloc]initWithLabel:@"About"];

		sep = [[CGTKSeparatorMenuItem alloc]init];

		[gameMenu_game setSubmenu:gameMenu];
		[menubar append:gameMenu_game];
		[gameMenu append:gameMenu_newGame];
		[gameMenu append:gameMenu_setup];
		[gameMenu append:gameMenu_options];
		[gameMenu append:sep];
		[gameMenu append:gameMenu_quit];

		[gameHelp_help setSubmenu:gameHelp];
		[menubar append:gameHelp_help];
		[gameHelp append:sep];
		[gameHelp append:gameHelp_about];

		[window showAll];
    	// Signalhandlers

		[CGTKSignalConnector connectGpointer:[window WIDGET] withSignal:@"destroy" 
							toTarget:self withSelector:@selector(gameQuit) andData:NULL];

		[CGTKSignalConnector connectGpointer:[gameMenu_newGame WIDGET] withSignal:@"activate" 
							toTarget:self withSelector:@selector(newGame) andData:NULL];
		[CGTKSignalConnector connectGpointer:[gameMenu_setup WIDGET] withSignal:@"activate" 
							toTarget:self withSelector:@selector(openSetupDialog) andData:NULL];
		[CGTKSignalConnector connectGpointer:[gameMenu_options WIDGET] withSignal:@"activate" 
							toTarget:self withSelector:@selector(openOptionDialog) andData:NULL];
		[CGTKSignalConnector connectGpointer:[gameMenu_quit WIDGET] withSignal:@"activate" 
							toTarget:self withSelector:@selector(gameQuit) andData:NULL];

		[CGTKSignalConnector connectGpointer:[gameHelp_about WIDGET] withSignal:@"activate" 
							toTarget:self withSelector:@selector(gameAbout) andData:NULL];



	}
	
	return self;
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
	[window showAll];
}



-(void)dealloc
{
	[super dealloc];
}

@end

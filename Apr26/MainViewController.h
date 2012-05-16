//
//  MainViewController.h
//  Apr26
//
//  Created by Georges Labreche on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"
#import "SpaceViewController.h"

@interface MainViewController : UIViewController{
    //holds the two subviews we transtion between
	NSArray *views;
    
    MenuViewController *menuViewController;
    SpaceViewController *spaceViewController;
    
    UITapGestureRecognizer *singleTapGestureRecognizer;
    MusicPlayer *musicPlayer;
    
}

@property MenuViewController *menuViewController;
@property SpaceViewController *spaceViewController;

// Needs to be reinit every time we go back to the menu.
-(void) initSingleTapGestureRecognizer;

@end

//
//  MainViewController.h
//  Apr26
//
//  Created by Georges Labreche on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpaceViewController.h"
#import "MusicPlayer.h"

@interface MainViewController : UIViewController{
    //holds the two subviews we transtion between
	NSArray *views;
    
	UITapGestureRecognizer *singleTapGestureRecognizer;
    
    SpaceViewController *spaceViewController;
    
    bool gameStarted;
    MusicPlayer *musicPlayer;
}

@end

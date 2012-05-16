//
//  SpaceViewController.h
//  Apr26
//
//  Created by Georges Labreche on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadViewController.h"
#import "MusicPlayer.h"
#import "HeadSoundPlayer.h"


@interface SpaceViewController : UIViewController{
    HeadViewController *headViewController;
    
    // Keep track of the asteroid views we've created
    // so that we may check if any of them have collided with our head view.
    NSMutableArray *asteroidViews;
    
    // Needed for when we detect collision between asteroids and head.
    // Also when we rotate device and move the head
    HeadSoundPlayer *headSoundPlayer;
    
    // Keep track of how many lives left.
    NSUInteger lives;
    // Display how many lives left.
    UILabel *livesLeftLabel;
    
    // time tracker of how long the player is surviving
    NSUInteger survivalTimeTracker;
    UILabel *survivalTimeLabel;
    
    
    NSTimer *collisionDetectionTimer;
    NSTimer *timeTrackerTimer;
    
    MusicPlayer *musicPlayer;
    
}

//-(id)initWithMainViewController:(MainViewController *) viewController;
-(void) startGame;

@end

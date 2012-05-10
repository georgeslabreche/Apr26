//
//  SpaceViewController.h
//  Apr26
//
//  Created by Georges Labreche on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadViewController.h"
#import "HeadSoundPlayer.h"

@interface SpaceViewController : UIViewController{
    HeadViewController *headViewController;
    
    // Keep track of the asteroid views we've created
    // so that we may check if any of them have collided with our head view.
    NSMutableArray *asteroidViews;
    
    // Needed for when we detect collision between asteroids and head.
    // Also when we rotate device and move the head
    HeadSoundPlayer *headSoundPlayer;
}

@end

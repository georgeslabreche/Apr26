//
//  MainViewController.h
//  Apr26
//
//  Created by Georges Labreche on 4/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadViewController.h"
#import "HeadSoundPlayer.h"

@interface MainViewController : UIViewController{
    HeadViewController *headViewController;
    HeadSoundPlayer *headSoundPlayer;
}
@end
